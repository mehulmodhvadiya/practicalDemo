//
//  ViewController.swift
//  PracticalDemo
//
//  Created by mehul modhvadiya on 17/07/20.
//  Copyright © 2020 mehul modhvadiya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var lblQuestion:UILabel!
    @IBOutlet var txtName:UITextField!
    @IBOutlet var btnNext:UIButton!
    var result:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "First Page"
        //DatabaseHelper.instance.FetchAllStudentList()
        lblQuestion.text = appDelegate.arrQuestion[0]
        
        

//        appDelegate.arrQuestion
    }
    override func viewWillAppear(_ animated: Bool) {
        txtName.text = ""
        
    }
    
    @IBAction func btnClick(_sender:UIButton) {
        let name = Common.shared.removeWhiteSpaceFromString(str: txtName.text!)
        
        if name.count == 0 {
            self.showAlert(strMsg: "Please enter name")
        }else {
           // DatabaseHelper.instance.insertSname(sname: name, date: result)
            
            let date = Date()
            let formatter = DateFormatter()

            formatter.dateFormat = "MM-dd-yyyy HH:mm"

            result = formatter.string(from: date)

            UserDefaults.standard.set(result, forKey: "Date")
            
            UserDefaults.standard.set(name, forKey: "Name") //setObject
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "SecondController") as! SecondController
            self.navigationController?.pushViewController(obj, animated: true)
            
        }

    }
}
extension ViewController{
    func showAlert(strMsg : String)  {
        
        let alert = UIAlertController.init(title: nil, message: strMsg, preferredStyle: UIAlertController.Style.alert)
        
        let actionOk = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default) { (action) in
            
        }
        alert.addAction(actionOk)
        
        self.present(alert, animated: true) {
            
        }
        
    }
}
