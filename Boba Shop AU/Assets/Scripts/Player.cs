using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace BobaShopAU
{

    public class Player : MonoBehaviour
    {
        public string playerName = "Angel";
        public int epicness = 0;
        public int bobaMeter = 0;
        public int lvl = 0;
        public bool goodDecision = false;
        public bool adviced = false;

        SceneChangeController changer;
        // Start is called before the first frame update
        void Start()
        {
            changer = FindObjectOfType<SceneChangeController>();
        }

        public bool CheckEndCondition()
        {
            if (lvl < 4) return false;
            if (epicness >= 2 || (lvl >= 4 && bobaMeter < 10))
            {
                changer.winState = false;
            }
            else if (lvl >= 4 && bobaMeter >= 10)
            {
                changer.winState = true;
            }
            
            changer.ChangeScene("EndScene");
            return true;
        }
        // Update is called once per frame
        void Update()
        {
           
            


        }
    }
}