//
//  ExchangeViewController.swift
//  Calender
//
//  Created by Simon on 2018/8/27.
//  Copyright © 2018年 Simon. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {
    @IBAction func returnButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func editButton(_ sender: UIButton) {
    }
    @IBAction func exchangeButton(_ sender: UIButton) {
    }
    
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rButton: UIButton!
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rButton.layer.cornerRadius = rButton.frame.size.width / 2
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
