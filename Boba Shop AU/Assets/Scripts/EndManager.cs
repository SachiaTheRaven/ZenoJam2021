using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EndManager : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        var changer = FindObjectOfType<SceneChangeController>();
        changer.DisplayText();
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
