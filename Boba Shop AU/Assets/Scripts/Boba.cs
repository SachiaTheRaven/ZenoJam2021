using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace BobaShopAU
{
    public enum Flavour
    {
        LIME,
        LYCHEE,
        PEAR,
        STRAWBERRY
    }

    public enum TeaType
    {
        BLACK,
        COFFEE,
        GREEN,
        ROOIBOS,
        WHITE
    }

    public enum PearlType
    {
        JELLY,
        JUICEBALLS,
        TAPIOCA,
    }

    public enum MilkOption
    {
        YES,
        NO
    }

    public enum Temperature
    {
        WARM,
        COLD
    }
  public enum ChoiceType
    {
        BEVERAGE,
        FLAVOUR,
        PEARL,
        MILK,
        TEMPERATURE
    }
    public class Boba : MonoBehaviour
    {
        public DialogueManager dialogueManager;
        public GameController controller;
        public CustomerHandler customer;

        public List<GameObject> teaBaseSprites;
        public List<GameObject> flavourSprites;
        public List<GameObject> toppingSprites;
        public List<GameObject> milkSprites;
        public List<GameObject> iceSprites;

        public TMP_Dropdown BeverageDropdown;
        public TMP_Dropdown FlavourDropdown;
        public TMP_Dropdown MilkDropdown;
        public TMP_Dropdown IceDropdown;
        public TMP_Dropdown ToppingDropDown;

        public int  BobaFlavour;
        public int  BobaType;
        public int  BobaTopping;
        public bool  BobaMilk;
        public bool  BobaIce;

        List<string> flavours = new List<string>
        {
            "lime",
            "lychee",
            "pear",
            "strawberry"
        };
                List<string> teas = new List<string>
        {
            "black",
            "coffee",
            "green",
            "rooibos",
            "white"
        };

        List<string> guestTypes = new List<string>
        {
            "negative",
            "positive",
            "neutral"
        };

        List<string> problemTypes = new List<string>
        {
            "school"
        };

        int RateBoba()
        {
            int score = 0;
            //milk, ice
            switch(controller.dailyWeather)
            {
                case "mild":
                    {
                        if (BobaMilk && BobaIce) score++;
                    }
                    break;
                case "hot":
                    {
                        if (!BobaMilk && BobaIce) score++;
                    }
                    break;
                case "snowy":
                    {
                        if (BobaMilk && !BobaIce) score++;
                    }
                    break;
                case "rainy":
                    {
                        if (!BobaMilk && !BobaIce) score++;
                    }
                    break;
            }
            //flavour
            if (customer.currentCustomer.faveTaste.Equals(flavours[BobaFlavour]))
                {
                score++;
            }
            //topping
            var type = guestTypes.IndexOf(customer.currentCustomer.customerType);
            if (BobaTopping == type) score++;
            //tea
            var tea = problemTypes.IndexOf(customer.currentCustomer.problemType);
            if(BobaType == tea) score++;
            return score;

        }
        public void SelectTea()
        {
            var idx = BeverageDropdown.value;
            SelectGeneric(teaBaseSprites, BobaType, idx);
            BobaType = idx;
        }
         public void SelectFlavour()
        {
            var idx = FlavourDropdown.value;
            SelectGeneric(flavourSprites, BobaFlavour, idx);
            BobaFlavour = idx;
        }
         public void SelectTopping()
        {
            var idx = ToppingDropDown.value;
            SelectGeneric(toppingSprites, BobaTopping, idx);
            BobaTopping = idx;
        }
         public void SelectMilk()
        {
            var idx = MilkDropdown.value;
            var val = idx == 0;
            SelectBooleanGeneric(milkSprites, val);
            
            BobaMilk =val;
        }
         public void SelectIce()
        {
            var idx = IceDropdown.value;
            var val = idx == 0;
            SelectBooleanGeneric(iceSprites, val);

            BobaIce = val;
        }
        
        public void SelectGeneric(List<GameObject> list, int oldIdx, int newIdx)
        {
            list[oldIdx].SetActive(false);
            list[newIdx].SetActive(true);
        }

        public void SelectBooleanGeneric(List<GameObject> list, bool val)
        {
            list[0].SetActive(val);
        }
        public void SetOptions()
        {
            BobaFlavour = FlavourDropdown.value;
            BobaType = BeverageDropdown.value;
            BobaTopping = FlavourDropdown.value;
            BobaMilk = FlavourDropdown.value==0;
            BobaIce = FlavourDropdown.value==0;

            var score = RateBoba();
            dialogueManager.SetVariableInStory(InkVarNames.success, score);
            controller.StartWork();
            //enable game space
            //check if person liked it
        }
    }
}

