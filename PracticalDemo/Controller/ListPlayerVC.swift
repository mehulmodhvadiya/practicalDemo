//
//  ListPlayerVC.swift
//  PracticalDemo
//
//  Created by mehul modhvadiya on 17/07/20.
//  Copyright © 2020 mehul modhvadiya. All rights reserved.
//

import UIKit

class ListPlayerVC: UIViewController {

    @IBOutlet var tblPlayer:UITableView!
    var arrPlayer = [StudentModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.title = "List Page"

        
        arrPlayer = DatabaseHelper.instance.FetchAllStudentList()
        // Do any additional setup after loading the view.
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
extension ListPlayerVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPlayer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlayerCell
        cell.lblGame.text = "Game :\(indexPath.row) \(arrPlayer[indexPath.row].Sdate)"
        cell.lblname.text = "Name : \(arrPlayer[indexPath.row].Sname)"
        cell.lblAnswer.text = "Answer :\(arrPlayer[indexPath.row].SQuestion1)"
        cell.lblAnswer1.text = "Answer :\(arrPlayer[indexPath.row].SQuestion2)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 193
    }
    
    
}
