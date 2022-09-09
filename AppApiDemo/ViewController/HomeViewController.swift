//
//  HomeViewController.swift
//  AppApiDemo
//
//  Created by Atul Dhiman on 07/07/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var Img2: UIImageView!
    @IBOutlet weak var MainImgName: UILabel!
    @IBOutlet weak var MainImg: UIImageView!
    @IBOutlet weak var MainDisp: UILabel!
    @IBOutlet weak var UpgradeBT: UIButton!
    @IBOutlet weak var Img1: UIImageView!
    @IBOutlet weak var DiscoverTxt: UILabel!
    @IBOutlet weak var DiscoverImg: UIButton!
    @IBOutlet weak var NotesImg: UIButton!
    @IBOutlet weak var MatchesImg: UIButton!
    @IBOutlet weak var MatchesLabel: UILabel!
    @IBOutlet weak var ProfileImg: UIButton!
    @IBOutlet weak var NotesLabel: UILabel!
    @IBOutlet weak var ProfileLabel: UILabel!
    @IBOutlet weak var img1Label: UILabel!
    var token: String?
    
    @IBOutlet weak var img2Label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeApi()
        MainImg.layer.cornerRadius = 20
        Img1.layer.cornerRadius = 10
        Img2.layer.cornerRadius = 10
        UpgradeBT.layer.cornerRadius = 25
        Img1.blur()
        Img2.blur()
        
        // Do any additional setup after loading the view.
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.NotesImg.tintColor = UIColor.black
    }
    @IBAction func Profilection(_ sender: Any) {
        self.ProfileImg.tintColor = UIColor.black
        self.NotesImg.tintColor = UIColor.lightGray
        self.DiscoverImg.tintColor = UIColor.lightGray
        self.MatchesImg.tintColor = UIColor.lightGray
        
    }
    @IBAction func matchAction(_ sender: Any) {
        self.ProfileImg.tintColor = UIColor.lightGray
        self.NotesImg.tintColor = UIColor.lightGray
        self.DiscoverImg.tintColor = UIColor.lightGray
        self.MatchesImg.tintColor = UIColor.black

    }
    @IBAction func noteaction(_ sender: Any) {
        self.ProfileImg.tintColor = UIColor.lightGray
        self.NotesImg.tintColor = UIColor.black
        self.DiscoverImg.tintColor = UIColor.lightGray
        self.MatchesImg.tintColor = UIColor.lightGray
    }
    
    
    @IBAction func discoverAction(_ sender: Any) {
        self.ProfileImg.tintColor = UIColor.lightGray
        self.NotesImg.tintColor = UIColor.lightGray
        self.DiscoverImg.tintColor = UIColor.black
        self.MatchesImg.tintColor = UIColor.lightGray
    }
    func HomeApi()
    {
        guard let url = URL(string:"https://testa2.aisle.co/V1/users/test_profile_list"), let token = self.token else {
            return
        }
        print("Making Home Api Request......")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        //request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _,error in
            guard let data = data,error == nil else{
                return
            }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("success response:\(response)")
                if let dict = response as? NSDictionary{
                    let invite =  dict["invites"] as? NSDictionary
                    let likes = dict["likes"] as? NSDictionary
                    guard let profilesarr =  invite?["profiles"] as? NSArray else{
                        return
                    }
                    guard let likesarr = likes?["profiles"] as? NSArray else {
                        return
                    }
                    for item in likesarr{
                        guard let like = item as? NSDictionary else {
                            return
                        }
                        if let name = like["first_name"] as? String{
                            if name == "Ishant"{
                            DispatchQueue.main.async {
                                self.img1Label.text = name
                                
                            }
                        }
                        }
                        if let name2 = like["first_name"] as? String{
                            if name2 == "Ajith"{
                                DispatchQueue.main.async {
                                    self.img2Label.text = name2
                                    //self.Img2.load(url: imageUrl2)
                                }
                            }
                                    
                           
                        }
                        
                        if let photo = like["avatar"] as? String{
                            if photo == "https://aisle.co/cdn-cgi/image/width=500,height=500,quality=90,fit=scale-down/https://testimages.aisle.co/dd510d5260eeebcdc7d7fc752c598c39728894004.png"{
                                if let imageUrl = URL(string: photo){
                                    DispatchQueue.main.async{
                                        self.Img1.load(url: imageUrl)
                                    }
                                }
                            }
                        }
                        
                        if let photo2 = like["avatar"] as? String{
                                if photo2 == "https://testimages.aisle.co/58b125e52d319c0390fc2d68b7da2ba6729804903.png"{
                                    if let imageUrl2 = URL(string: photo2){
                                        DispatchQueue.main.async{
                                            self.Img2.load(url: imageUrl2)
                                        }
                                    }
                                }
                                

                        }
//
//                        if let img = like["avatar"] as? String{
//                            if let imgurl = URL(string: img){
//                                DispatchQueue.main.self{
//                                    self.Img1.load(url: imgurl)
//                                }
//                            }
//                        }
                    }
                    
                    for item in profilesarr{
                        guard let profile = item as? NSDictionary else {
                            return
                        }
                        let generalInfo = profile["general_information"] as? NSDictionary
                        if let name = generalInfo?["first_name"] as? String,let age = generalInfo?["age"] as? Int{
                            DispatchQueue.main.async{
                                
                                self.MainImgName.text = "\(name), \(age)"
                            }
                            
                        }
                        
                        if let photosArray = profile["photos"] as? NSArray{
                            for photo in photosArray{
                                
                                guard let photoItem = photo as? NSDictionary else { return }
                                if let photo = photoItem["photo"] as? String, let status = photoItem["status"] as? String{
                                    if status == "avatar"{
                                        if let imageUrl = URL(string: photo){
                                            DispatchQueue.main.async{
                                                self.MainImg.load(url: imageUrl)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                //ALL Secondary IMG
//                if let dict2 = response as? NSDictionary{
//                    let like =  dict2["likes"] as? NSDictionary
//                    guard let proarr =  like?["profiles"] as? NSArray else{
//                        return
//                    }
//                    for item1 in proarr{
//                    guard let profile2 = item1 as? NSDictionary else {
//                        return
//                    }
//
//                        let namelab = profile2["first_name"] as? NSDictionary
//                        if let name = namelab?["first_name"] as? String{
//                            DispatchQueue.main.async{
//                                self.img1Label.text = name
//                            }
//
//                        }
//
//                    if let img1 = profile2["avatar"] as? NSArray{
//                        for photo1 in img1{
//                        guard let photoItem1 = photo1 as? NSDictionary else { return }
//                        if let photo1 = photoItem1["avatar"] as? String, let Name = photoItem1["first_name"] as? String{
//                            if Name == "Ajith"{
//                            if let imageUrl1 = URL(string: photo1){
//                                DispatchQueue.main.async{
//                                    self.Img1.load(url: imageUrl1)
//                                }
//                            }
//                            }
//                        }
//                        }
//                    }
//                    }
//                }
            }
            catch{
                print("error details", error)
            }
            
        }
        task.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIView{
    
    func blur(){
        var blureffect : UIBlurEffect!
        if #available(iOS 10.0, *){
            blureffect = UIBlurEffect(style: .dark)
        }else{
            blureffect = UIBlurEffect(style: .light)
        }
        let blureffectview = UIVisualEffectView(effect: blureffect)
        blureffectview.frame = self.bounds
        blureffectview.alpha = 0.8
        blureffectview.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(blureffectview)
    }
}
