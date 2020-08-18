//
//  SecondController.swift
//  PracticalDemo
//
//  Created by mehul modhvadiya on 17/07/20.
//  Copyright © 2020 mehul modhvadiya. All rights reserved.
//

import UIKit

class SecondController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var lblQuestion:UILabel!
    @IBOutlet var btnA:UIButton!
    @IBOutlet var btnB:UIButton!
    @IBOutlet var btnC:UIButton!
    @IBOutlet var btnD:UIButton!
    @IBOutlet var btnNext:UIButton!
    var strAnswer:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.largeTitleDisplayMode = .never

        
        lblQuestion.text = appDelegate.arrQuestion[1]
        self.title = "Second Page"
    }
    
    @IBAction func btnClick(_ sender:UIButton) {
        if sender.tag == 100 {
            btnA.setImage(UIImage(named: "radiobtn.png"), for: .normal)
            btnB.setImage(UIImage(named: "ellipse1450.png"), for: .normal)
            btnC.setImage(UIImage(named: "ellipse1450.png"), for: .normal)
            btnD.setImage(UIImage(named: "ellipse1450.png"), for: .normal)
            strAnswer = "Sachin Tendulkar"
        }else if sender.tag == 101 {
            btnB.setImage(UIImage(named: "radiobtn.png"), for: .normal)
            btnA.setImage(UIImage(named: "ellipse1450.png"), for: .normal)
            btnC.setImage(UIImage(named: "ellipse1450.png"), for: .normal)
            btnD.setImage(UIImage(named: "ellipse1450.png"), for: .normal)
            strAnswer = "Virat Kohli"
        }else if sender.tag == 102 {
            btnA.setImage(UIImage(named: "ellipse1450.png"), for: .normal)
            btnB.setImage(UIImage(named: "ellipse1450.png"), for: .normal)
            btnC.setImage(UIImage(named: "radiobtn.png"), for: .normal)
            btnD.setImage(UIImage(named: "ellipse1450.png"), for: .normal)
            strAnswer = "Adam Gilchrist"
        }else if sender.tag == 103 {
            btnA.setImage(UIImage(named: "ellipse1450.png"), for: .normal)
            btnB.setImage(UIImage(named: "ellipse1450.png"), for: .normal)
            btnC.setImage(UIImage(named: "ellipse1450.png"), for: .normal)
            btnD.setImage(UIImage(named: "radiobtn.png"), for: .normal)
            strAnswer = "jacques Kallis"
        }

    }
    @IBAction func btnNext(_sender:UIButton) {
        let name = Common.shared.removeWhiteSpaceFromString(str: strAnswer)
        
        if name.count == 0 {
            self.showAlert(strMsg: "Please select one option")
        }else {
            //DatabaseHelper.instance.insertSquestion(squestion1: name)
            UserDefaults.standard.set(name, forKey: "Question1") //setObject
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "ThirdController") as! ThirdController
            self.navigationController?.pushViewController(obj, animated: true)
            
        }

    }
    
}
extension SecondController{
    func showAlert(strMsg : String)  {
        
        let alert = UIAlertController.init(title: nil, message: strMsg, preferredStyle: UIAlertController.Style.alert)
        
        let actionOk = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default) { (action) in
            
        }
        alert.addAction(actionOk)
        
        self.present(alert, animated: true) {
            
        }
        
    }
}
