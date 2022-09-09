//
//  OTPScreenViewController.swift
//  AppApiDemo
//
//  Created by Atul Dhiman on 06/07/22.
//

import UIKit

class OTPScreenViewController: UIViewController{

    @IBOutlet weak var PhoneNumberLabel: UILabel!
    @IBOutlet weak var OTPTxtField: UITextField!
    @IBOutlet weak var EditBT: UIImageView!
    @IBOutlet weak var editBTiMG: UIButton!
    @IBOutlet weak var ContinueBT: UIButton!
    @IBOutlet weak var TimerLabel: UILabel!
    var get : String = ""
    var count : String = ""
    var token: String?
    var secondsRemaining = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        OTPTxtField.enablesReturnKeyAutomatically = true
        ContinueBT.layer.cornerRadius = 20
        OTPTxtField.layer.borderWidth = 1.2
        OTPTxtField.layer.borderColor = UIColor.lightGray.cgColor
        // Do any additional setup after loading the view.
        OTPTxtField.layer.cornerRadius = 5
        PhoneNumberLabel.text = "+91 " + get
        
        startCountDown()
    }
    @IBAction func EditNumber(_ sender: Any) {
        let nextvc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.pushViewController(nextvc, animated: true)
    }
    func OTPApi()
    {
        guard let url = URL(string:"https://testa2.aisle.co/V1/users/verify_otp") else {
            return
        }
        print("Making OTP Api Request......")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 58
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String : Any] = [
            "number" : count,
            "otp" : OTPTxtField.text!,
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _,error in
            guard let data = data,error == nil else{
                return
            }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as Any
                if let dict = response as? NSDictionary{
                    let token = dict["token"] as? String
                    print(token,"token")
                    self.token = token
                    DispatchQueue.main.async {
                        self.nav()
                    }
                }
               
                print("success response:\(response)")
            }
            catch{
                print("error details", error)
            }
            
        }
        task.resume()
    }

    
    func startCountDown(){
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsRemaining > 0 {
                print ("\(self.secondsRemaining) seconds")
                self.secondsRemaining -= 1
                self.TimerLabel.text = "00:\(self.secondsRemaining)"
            } else {
                Timer.invalidate()
            }
        }
    }

    
    private func nav(){
        let nextvc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        nextvc?.token = self.token
        //nextvc!.get = pass
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.pushViewController(nextvc!, animated: true)
    }
        
    @IBAction func ContinueAction(_ sender: Any) {
        
        if OTPTxtField.text == ""
        {
            print("can't move forward")
            let alertController = UIAlertController(title: "Alert", message: "Arre yaar OTP lekhoo..", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Accha", style: .default) {
                (action: UIAlertAction!) in
                // Code in this block will trigger when OK button tapped.
                print("Ok button tapped");
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if count != "+919876543212"
        {
            print("can't move forward,Phone Number is Wrong")
            let alertController = UIAlertController(title: "Alert", message: "Bhai/Behan Number sahi nhi OTP k leye", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "abhi thik karta hu", style: .default) {
                (action: UIAlertAction!) in
                // Code in this block will trigger when OK button tapped.
                print("Ok button tapped");
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            self.OTPApi()
        }
       
        
    }
    
    //@IBOutlet var timer: UIView!
}
