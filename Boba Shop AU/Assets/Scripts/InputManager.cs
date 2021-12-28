using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace BobaShopAU
{
    public class InputManager : MonoBehaviour
    {
        //add from editor!
        public DialogueManager dialogueManager;
        public GameController controller;

        // Start is called before the first frame update
        void Start()
        {

        }

        // Update is called once per frame
        void Update()
        {
            HandleTouch();
        }

        void HandleTouch()
        {
            if (Input.GetMouseButtonDown(0))
            {
                //check what we have touched

                //Debug.Log(controller.state);
                switch (controller.state)
                {
                    case GameState.MORNING:
                        {
                            controller.StartWork();
                        }
                        break;
                    case GameState.WORK:
                        {
                            
                            dialogueManager.DoConversation();
                        }
                        break;
                    default: break;
                }
                //if (Physics.Raycast(ray, out hit))
                //{
                //    Debug.Log(hit.collider.tag);
                //    switch (hit.collider.tag)
                //    {
                //        case "Customer":
                //            dialogueManager.StartConversation();
                //            break;
                //        case "Phone":
                //            break;
                //        default:
                //            Debug.Log("What the actual fuck, bro"); break;
                //    }
                //}
            }
        }
    }
}