//
//  SummaryController.swift
//  PracticalDemo
//
//  Created by mehul modhvadiya on 17/07/20.
//  Copyright © 2020 mehul modhvadiya. All rights reserved.
//

import UIKit

class SummaryController: UIViewController {

    var arrDetail = [StudentModel]()
    
    @IBOutlet var lblName:UILabel!
    @IBOutlet var lblQuestion:UILabel!
    @IBOutlet var lblQuestion1:UILabel!
    @IBOutlet var lblAns:UILabel!
    @IBOutlet var lblAns2:UILabel!
    @IBOutlet var btnFinish:UIButton!
    @IBOutlet var btnHistory:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.title = "Summary Page"
        
        if let name1 =   UserDefaults.standard.string(forKey: "Name") {
            lblName.text = "Hello \"\(name1)\""

        }
       // let date =  UserDefaults.standard.string(forKey: "Date")!
        if let Question1 =  UserDefaults.standard.string(forKey: "Question1"){
            lblAns.text = "Answer: \"\(Question1)\""
        }
        if let Question2 =  UserDefaults.standard.string(forKey: "Question2"){
            lblAns2.text = "Answer: \"\(Question2)\""
        }
        
       // arrDetail = DatabaseHelper.instance.FetchAllStudentList()
        
        
    }
    @IBAction func btnFinishClick(){
        UserDefaults.standard.removeObject(forKey: "Name")
        UserDefaults.standard.removeObject(forKey: "Date")
        UserDefaults.standard.removeObject(forKey: "Question1")
        UserDefaults.standard.removeObject(forKey: "Question2")
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func btnHistoryClick(){
        
        UserDefaults.standard.removeObject(forKey: "Name")
        UserDefaults.standard.removeObject(forKey: "Date")
        UserDefaults.standard.removeObject(forKey: "Question1")
        UserDefaults.standard.removeObject(forKey: "Question2")

        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "ListPlayerVC") as! ListPlayerVC
        self.navigationController?.pushViewController(obj, animated: true)

    }
}
