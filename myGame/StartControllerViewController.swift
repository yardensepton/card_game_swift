//
//  StartControllerViewController.swift
//  myGame
//
//  Created by Student25 on 13/07/2024.
//

import UIKit
import CoreLocation

class StartControllerViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var eastImage: UIImageView!
    @IBOutlet weak var westImage: UIImageView!
    @IBOutlet weak var userName: UITextField!
    let gameManager = GameManager.sharedGameManager
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
               locationManager.requestWhenInUseAuthorization()
        self.navigationItem.hidesBackButton = true
        userName.placeholder = "Enter your name"
        westImage.image = UIImage(named: "west.png")
        eastImage.image = UIImage(named: "east.png")
        startBtn.titleLabel?.text = "START"
        checkName()
        locationManager.requestLocation()
        checkLocation()
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
            
            if let location = locations.last {
                _ = location.coordinate.latitude
                let lon = location.coordinate.longitude
                
                if lon > 34.81801612783521 {
                    self.westImage.isHidden = true
                    self.gameManager.saveUserSide(text: "east")
                } else {
                    self.eastImage.isHidden = true
                    self.gameManager.saveUserSide(text: "west")
                }
            }
        }
    
    func checkLocation(){
        let side = gameManager.getUserSide()
        if !side.isEmpty{
            if side == "west"{
                self.westImage.isHidden = false
                self.eastImage.isHidden = true
            }else if side == "east"{
                self.westImage.isHidden = true
                self.eastImage.isHidden = false
            }
           
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("locationManager Error: \(error)")
     }
    
    func checkName(){
        let name : String = gameManager.getUserName()
        if  name != "" {
            userNameLabel.text = "Hi " + name
            userName.isHidden = true
        }else{
            userNameLabel.isHidden = true
            userName.isHidden = false
        }
    }
    
    
    @IBAction func start(_ sender: Any) {
        if !userName.isHidden{
            if let text = userName.text {
                gameManager.saveUserName(text: text)
                
            }
        }
        
        let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") as! GameViewController
        self.navigationController?.pushViewController(storyBoard, animated: true)
        
        
    }

}

