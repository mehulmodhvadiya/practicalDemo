//
//  ThirdController.swift
//  PracticalDemo
//
//  Created by mehul modhvadiya on 17/07/20.
//  Copyright © 2020 mehul modhvadiya. All rights reserved.
//

import UIKit

class ThirdController: UIViewController {
    
    @IBOutlet var lblQuestion:UILabel!
    @IBOutlet var btnA:UIButton!
    @IBOutlet var btnB:UIButton!
    @IBOutlet var btnC:UIButton!
    @IBOutlet var btnD:UIButton!
    @IBOutlet var btnNext:UIButton!
    var arrAnswer = [String]()
    var strAnswer:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.largeTitleDisplayMode = .never

        arrAnswer.removeAll()
        self.title = "Third Page"
    }
    
    
    @IBAction func btnClick(_ sender:UIButton){
        if sender.tag == 1001 {
            if sender.isSelected == true {
                btnA.isSelected = false
                arrAnswer.removeAll { $0 == "White" }
                btnA.setImage(UIImage(named: "uncheck1.png"), for: .normal)
            }else {
                btnA.isSelected = true
                btnA.setImage(UIImage(named: "check.png"), for: .normal)
                arrAnswer.append("White")
                //arrAnswer.removeAll { $0 == "White" }
            }
        }else if sender.tag == 1002 {
            
            if sender.isSelected == true {
                btnB.isSelected = false
                arrAnswer.removeAll { $0 == "Yellow" }
                btnB.setImage(UIImage(named: "uncheck1.png"), for: .normal)
            }else {
                arrAnswer.append("Yellow")
                btnB.isSelected = true
                btnB.setImage(UIImage(named: "check.png"), for: .normal)
            }
        }else if sender.tag == 1003 {
            
            if sender.isSelected == true {
                btnC.isSelected = false
                arrAnswer.removeAll { $0 == "Orange" }
                btnC.setImage(UIImage(named: "uncheck1.png"), for: .normal)
            }else {
                arrAnswer.append("Orange")
                btnC.isSelected = true
                btnC.setImage(UIImage(named: "check.png"), for: .normal)
            }
        }else if sender.tag == 1004 {
            
            if sender.isSelected == true {
                btnD.isSelected = false
                arrAnswer.removeAll { $0 == "Green" }
                btnD.setImage(UIImage(named: "uncheck1.png"), for: .normal)
            }else {
                arrAnswer.append("Green")
                btnD.isSelected = true
                btnD.setImage(UIImage(named: "check.png"), for: .normal)
            }
        }
        
        let stringRepresentation = arrAnswer.joined(separator: ",") // "1-2-3"
        
        strAnswer = stringRepresentation
    }
    @IBAction func btnNext(_sender:UIButton) {
        let name = Common.shared.removeWhiteSpaceFromString(str: strAnswer)
        
        if name.count == 0 {
            self.showAlert(strMsg: "Please select one more option")
        }else {
            
            UserDefaults.standard.set(name, forKey: "Question2") //setObject
            
            guard let name1 = UserDefaults.standard.string(forKey: "Name") else {
                return
            }
            guard let date = UserDefaults.standard.string(forKey: "Date") else {
                return
            }
            guard let Question1 = UserDefaults.standard.string(forKey: "Question1") else {
                return
            }

            DatabaseHelper.instance.insertData(sname: name1, date: date, question1: Question1, question2: name)
            
            
           // UserDefaults.standard.set(name, forKey: "Question2") //setObject
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "SummaryController") as! SummaryController
            self.navigationController?.pushViewController(obj, animated: true)
            
        }

    }
}
extension ThirdController{
    func showAlert(strMsg : String)  {
        
        let alert = UIAlertController.init(title: nil, message: strMsg, preferredStyle: UIAlertController.Style.alert)
        
        let actionOk = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default) { (action) in
            
        }
        alert.addAction(actionOk)
        
        self.present(alert, animated: true) {
            
        }
        
    }
}
