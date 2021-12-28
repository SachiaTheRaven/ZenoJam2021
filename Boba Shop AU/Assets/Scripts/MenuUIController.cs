using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class MenuUIController : MonoBehaviour
{
    public GameObject helpPanel;
    public GameObject creditsPanel;


   
    public void ToggleHelp(bool val)
    {
        helpPanel.SetActive(val);
    }
    public void ToggleCredits(bool val)
    {
        creditsPanel.SetActive(val);
    }
}
