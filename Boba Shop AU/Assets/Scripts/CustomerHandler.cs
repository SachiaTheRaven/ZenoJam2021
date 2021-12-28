using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace BobaShopAU {
    public class CustomerHandler : MonoBehaviour
    {
        public DialogueManager dialogueManager;

        public Customer currentCustomer = null;
        // Start is called before the first frame update
        public void SetCustomer(Customer cust)
        {
            currentCustomer = cust;
        }
    }
}