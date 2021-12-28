using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneChangeController : MonoBehaviour
{
    // Start is called before the first frame update

    string LossText = @"Corporate requires you to report home ASAP!

It came before our eyes and understanding that you became just too involved with the mundane lives and problems of your guests.

And you forgot about your task at hand: to be a good bartender at the Heavenly Bobatea.
We did not ask You To Solve Problems.

We did not Expect You to Reveal youSElF

yOU aRe NOt ReAdy.

YoU wILL nOT ascEND.
";

    string WinText = @"Great news! 
(No, nobody died, don't worry about it.)

You have finished your task - to be a good server at Heavenly Boba!

Yes, you can be happy and proud of yourself!

You gave your guest enough good Boba teas, so you can now come back to the Heavens, after you made the Heavenly Bobatea shop quite a local favourite!
";
    public bool winState = false;

    void Start()
    {
        DontDestroyOnLoad(gameObject);
    }

    public void ChangeScene(string scene)
    {
        SceneManager.LoadScene(scene);
    }

    public void DisplayText()
    {
        var Text = FindObjectOfType<TextMeshProUGUI>();
        if (winState)
        {
            Text.text = WinText;
        }
        else
        {
            Text.text = LossText;
        }
    }
}
