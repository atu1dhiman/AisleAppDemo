//
//  ViewController.swift
//  AppApiDemo
//
//  Created by Atul Dhiman on 06/07/22.
//

import UIKit


class ViewController: UIViewController {
    
    

    @IBOutlet weak var PhoneNumberTxtField: UITextField!
    @IBOutlet weak var ContinueBT: UIButton!
    @IBOutlet weak var CountryCodeTxt: UITextField!
    var pass : String = ""
    var count : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        ContinueBT.layer.cornerRadius = 20
        PhoneNumberTxtField.layer.cornerRadius = 5
        CountryCodeTxt.layer.cornerRadius = 5
        CountryCodeTxt.layer.borderWidth = 1
        PhoneNumberTxtField.layer.borderWidth = 1
        PhoneNumberTxtField.layer.borderColor = UIColor.lightGray.cgColor
        CountryCodeTxt.layer.borderColor = UIColor.lightGray.cgColor
        //PhoneNumberTxtField.text = "9876543212"
        //PhoneNumberTxtField.enablesReturnKeyAutomatically = true
       
        
        
    }
    private func nav()
    {
        count = CountryCodeTxt.text! + PhoneNumberTxtField.text!
        pass = PhoneNumberTxtField.text ?? ""
        let nextvc = self.storyboard?.instantiateViewController(withIdentifier: "OTPScreenViewController") as? OTPScreenViewController
        nextvc!.get = pass
        nextvc!.count = count
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.pushViewController(nextvc!, animated: true)
    }
    
    @IBAction func ContinueAction(_ sender: Any)
    {
        if PhoneNumberTxtField.text == ""
        {
            print("can't move forward")
            let alertController = UIAlertController(title: "Alert", message: "Arre yaar phone number lekhoo..", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Thik Hai", style: .default) {
                (action: UIAlertAction!) in
                // Code in this block will trigger when OK button tapped.
                print("Ok button tapped");
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            self.phoneAPI()
        }
        
    }
    
    
    func phoneAPI()
    {
        guard let url = URL(string:"https://testa2.aisle.co/V1/users/phone_number_login") else {
            return
        }
        print("Making Phone Api Request......")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String : Any] = [
            "number" : CountryCodeTxt.text! + PhoneNumberTxtField.text!,
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _,error in
            guard let data = data,error == nil else{
                return
            }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("success response:\(response)")
                DispatchQueue.main.async {
                    self.nav()
                }
            }
            catch{
                print("error details", error)
            }
            
        }
        task.resume()
    }
    
    
    
    
    
}
    


    

