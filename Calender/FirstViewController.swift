//
//  FirstViewController.swift
//  Calender
//
//  Created by Simon on 2018/5/23.
//  Copyright © 2018年 Simon. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var total = 0
    //收鍵盤
    @IBAction func endTap(_ sender: Any) {
        view.endEditing(true)
    }
    var moneys = [Use(use: "Breakfast:", money: "0"),Use(use: "Lunch:", money: "0"),Use(use: "Dinner:", money: "0"),Use(use: "Snacks:", money: "0"),Use(use: "Social:", money: "0"),Use(use: "Daily:", money: "0"),Use(use: "Traffic:", money: "0"),Use(use: "Gift:", money: "0"),Use(use: "rent:", money: "0"),Use(use: "Medical treatment:", money: "0"),Use(use: "Investment:", money: "0"),Use(use: "phone:", money: "0"),Use(use: "credit card:", money: "0"),Use(use: "other:", money: "0")]
//        var moneys = [Use(use: "Breakfast:", money: 0),Use(use: "Lunch:", money: 0),Use(use: "Dinner:", money: 0),Use(use: "Snacks:", money: 0),Use(use: "Social:", money: 0),Use(use: "Daily:", money: 0),Use(use: "Traffic:", money: 0),Use(use: "Gift:",money: 0),Use(use: "rent:", money: 0),Use(use: "Medical treatment:", money: 0),Use(use: "Investment:", money: 0),Use(use: "phone:", money: 0),Use(use: "credit card:", money: 0),Use(use: "other:", money: 0)]
//    let spend = ["Breakfast:","Lunch:","Dinner:","Snacks:","Social:","Daily:","Traffic:","Gift:","rent:","Medical treatment:","Investment:","phone:","credit card:","other:"]
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentTable: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  moneys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FristTableViewCell else{fatalError()}
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FristTableViewCell
            cell.useLabel.text = moneys[indexPath.row].use
//        if cell.tag >= 7 {
//            //cell.moneyTextField.text = ""
//            cell.moneyTextField.text = cell.moneyTextField.text
//        }else{
//                cell.moneyTextField.text = ""
//               // cell.moneyTextField.text = cell.moneyTextField.text
//
//        }
            if aSwitch.isOn == false{
                cell.moneyLabel.isHidden = false
                cell.moneyTextField.isHidden = true
                cell.moneyLabel.text = cell.moneyTextField.text
            }else{
                cell.moneyLabel.isHidden = true
                cell.moneyTextField.isHidden = false
                cell.moneyLabel.text = cell.moneyTextField.text
            }
            if cell.moneyTextField.text != nil{
                moneys[indexPath.row].money = cell.moneyTextField.text!
                if Int(moneys[indexPath.row].money) != nil {
                    total += Int(moneys[indexPath.row].money)!
                    totalLabel.text = "\(total)"
                    print(total)

                    }
                }
        return cell
}
    var dateString:String?
    @IBAction func bSwitch(_ sender: UISwitch) {
        if aSwitch.isOn == false{
            contentTable.reloadData()
            total = 0
            print("關")
                    }else{
            contentTable.reloadData()
             total = 0
            print("開")
        }
    }
    @IBOutlet weak var aSwitch: UISwitch!
    @IBAction func button(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTable.delegate = self
        contentTable.dataSource = self
        dateLabel.text = dateString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
