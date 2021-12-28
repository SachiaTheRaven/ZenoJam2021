using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

namespace BobaShopAU
{
    public enum GameState
    {
        MORNING,
        WORK,
        DIALOGUE,
        BOBA,
    }

    public class GameController : MonoBehaviour
    {
        public bool bobaTime = false;
        //from editor
        public GameObject startDayLayer;
        public GameObject bobaLayer;
        public GameObject dialogueLayer;
        public TextMeshProUGUI startDayText;
        public Player player;

        //inside stuff
        public GameState state;

        static List<string> weatherTypeNames =new List<string>
        {
            "mild",
            "hot",
            "snowy",
            "rainy"
        };
        public string dailyWeather = weatherTypeNames[0];
        public int friendshipThreshold = 5;
        public int dayNumber = 0;
        // Start is called before the first frame update
        void Start()
        {
            StartNewDay();
        }

        // Update is called once per frame
        void Update()
        {

        }
        public void StartDialogue()
        {
            bobaLayer.SetActive(false);
            state = GameState.DIALOGUE;
            dialogueLayer.SetActive(true);
        }

        public void StartNewDay()
        {
          
            dayNumber++;
            state = GameState.MORNING;
            var rnd = new System.Random();
            //initialize stuff
            var weatherIdx = rnd.Next(weatherTypeNames.Count);
            dailyWeather = weatherTypeNames[weatherIdx];
            string txt = $"Welcome to day {dayNumber} at Heavenly Boba, {player.playerName}! It's quite {dailyWeather} today, isn't it?";
            startDayText.text = txt;
            startDayLayer.SetActive(true);
        }
        public void StartWork()
        {
            startDayLayer.SetActive(false);
            dialogueLayer.SetActive(true);
            bobaLayer.SetActive(false);
            state = GameState.WORK;
        }
        
        public void StartBobaCreation()
        {
            bobaLayer.SetActive(true);
            dialogueLayer.SetActive(false);
            state = GameState.BOBA;
        }
    }
}