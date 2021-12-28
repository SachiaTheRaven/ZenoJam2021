using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;
using TMPro;
using UnityEngine.UI;

namespace BobaShopAU
{

    public class DialogueManager : MonoBehaviour
    {
        public Player player;
        public GameController gameController;
        public List<Story> stories;
        public List<TextAsset> inkFiles;
        public Story currentStory;

        ///////////////////////Set These From Editor////////////////////////////
        //gc
        public GameController controller;
        //dialogue
        public GameObject messagePanel;
        public TextMeshProUGUI message;
        public TextMeshProUGUI nametag;

        //buttons

        public Transform buttonParent;
        public Button buttonPrefab;

        //customer object
        public CustomerHandler customer;
        ////////////////////////////Private variables///////////////////////////////
        private Choice choiceSelected = null;
        private List<Button> answerButtons;




        // Start is called before the first frame update
        void Start()
        {
            //Load all stories to pick from
            stories = new List<Story>();
            LoadStories();
            answerButtons = new List<Button>();
            SwitchToStory(0);
            ParseCustomer();

        }

        // Update is called once per frame
        void Update()
        {

        }

        public void DoConversation()
        {
            if (currentStory.canContinue)
            {
                AdvanceDialogue();
            }
            else if (currentStory.currentChoices.Count == 0)
            {

                player.goodDecision = true;
                player.lvl++;

                var end = player.CheckEndCondition();
                if (!end)
                {

                    SwitchToStory(player.lvl);
                    controller.StartNewDay();
                }
            }

            if (currentStory.currentChoices.Count != 0)
            {
                controller.StartDialogue();
                StartCoroutine(ShowChoices());
            }
            //  else if(controller.state!=GameState.BOBA) controller.StartWork();
        }


        void AdvanceDialogue()
        {
            string currentSentence = currentStory.Continue();
            //Debug.Log(currentSentence);
            StopAllCoroutines();
            StartCoroutine(TypeSentence(currentSentence));
        }

        IEnumerator TypeSentence(string sentence)
        {
            messagePanel.SetActive(sentence.Length > 0);


            message.text = "";
            foreach (char letter in sentence.ToCharArray())
            {
                message.text += letter;
                yield return null;
            }
            //set animation if necessary
        }

        IEnumerator ShowChoices()
        {

            List<Choice> _choices = currentStory.currentChoices;
            foreach (var choice in _choices)
            {
                Button choiceButton = Instantiate(buttonPrefab) as Button;
                choiceButton.transform.SetParent(buttonParent);
                answerButtons.Add(choiceButton);

                TextMeshProUGUI choiceText = choiceButton.GetComponentInChildren<TextMeshProUGUI>();
                choiceText.text = choice.text;
                //Debug.Log(choice.text);

                choiceButton.onClick.AddListener(delegate { OnClickChoiceButton(choice); });
            }
            //set panel active
            yield return new WaitUntil(() => { return choiceSelected != null; });

            AdvanceFromDecision();
        }

        void OnClickChoiceButton(Choice choice)
        {

            currentStory.ChooseChoiceIndex(choice.index);
            choiceSelected = choice;
            controller.StartWork();

        }
        void AdvanceFromDecision()
        {

            foreach (var button in answerButtons)
            {
                Destroy(button.gameObject);
            }
            answerButtons.Clear();

            choiceSelected = null;
            AdvanceDialogue();

        }
        public void LoadStories()
        {
            foreach (var file in inkFiles)
            {
                stories.Add(new Story(file.text));
            }
        }

        public void SwitchToStory(int idx)
        {
            currentStory = stories[idx];

            //Set global variables
            SetGlobalVariables();
            currentStory.ObserveVariable(InkVarNames.bobaTimeVar, (string varName, object newValue) =>
            {
                controller.StartBobaCreation();
            });
            currentStory.ObserveVariable(InkVarNames.epicVar, (string varName, object newValue) =>
            {
                player.epicness = (int)newValue;
            });

            currentStory.ObserveVariable(InkVarNames.friendshipStateVar, (string varName, object newValue) =>
            {
                customer.currentCustomer.friendship = (int)newValue;
            });

            currentStory.ObserveVariable(InkVarNames.problemTypeVar, (string varName, object newValue) =>
            {
                customer.currentCustomer.problemType = (string)newValue;
            });

            currentStory.ObserveVariable(InkVarNames.advicedVar, (string varName, object newValue) =>
            {
                player.adviced = (bool)newValue;
            });
        }

        public void SetGlobalVariables()
        {
            SetVariableInStory(InkVarNames.bobaTeaVar, player.bobaMeter);
            SetVariableInStory(InkVarNames.characterNameVar, player.playerName);
            SetVariableInStory(InkVarNames.epicVar, player.epicness);
            //set weather
            SetVariableInStory(InkVarNames.weatherVar, gameController.dailyWeather);
            SetVariableInStory(InkVarNames.friendshipThresholdVar, gameController.friendshipThreshold);
            if (player.lvl > 0)
            {
                SetVariableInStory(InkVarNames.prevChoice, player.goodDecision);
            };
        }

        //first time thingy;
        public void ParseCustomer()
        {
            Customer cust = new Customer();
            cust.name = GetVariableFromStory(InkVarNames.customerNameVar) as string;
            cust.customerType = GetVariableFromStory(InkVarNames.customerTypeVar) as string;
            cust.faveTaste = GetVariableFromStory(InkVarNames.faveTasteVar) as string;
            cust.faveBubble = GetVariableFromStory(InkVarNames.faveBubbleVar) as string;
            cust.friendship = 0; //update later
            cust.daysOut = 0; //update later

            customer.SetCustomer(cust);
        }

        public object GetVariableFromStory(string varName)
        {
            return currentStory.variablesState[varName];

        }

        public void SetVariableInStory(string varName, object varValue)
        {
            currentStory.variablesState[varName] = varValue;

        }
    }
}