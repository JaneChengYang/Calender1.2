//
//  AccountViewController.swift
//  Calender
//
//  Created by Simon on 2018/6/26.
//  Copyright © 2018年 Simon. All rights reserved.
//

import UIKit
import BubbleTransition
import CoreData

class AccountViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIViewControllerTransitioningDelegate{
    var diary:DiaryUser?
    var date:String?
    var total = 0
    
    @IBOutlet weak var piechartButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBAction func diaryButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func myButton(_ sender: UIButton) {
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (diary?.totalUser?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AccountCollectionViewCell else{fatalError()}
        //抓出DiaryUser的totalUser並加入cell
        if let totalDiary = diary?.totalUser?.allObjects as? [TotalUser]{
            cell.moneyLabel.text = totalDiary[indexPath.row].monay
            cell.userLabel.text = totalDiary[indexPath.row].user
            cell.myImage.image = UIImage(data: totalDiary[indexPath.row].accImage!)
            let total = totalDiary.reduce(0) { $0 + Int($1.monay!)! }
            self.total = total
            totalLabel.text = ("總額:\(String(total))")
        }
        //設定陰影效果
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    var image = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3")]
    override func viewDidLoad() {
        super.viewDidLoad()
        if let date = date{
            dateLabel.text = date
        }
        if let diary = diary{
            self.diary = diary
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myCollection.reloadData()
        print("AccountViewController\(diary?.totalUser?.count)")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? AddAccountViewController{
            //            if let row = self.myCollection.indexPathsForSelectedItems?.first?.item{
            controller.date = dateLabel.text
            controller.diary = self.diary
            //            let rows = row
            //            controller.show = rows
            //            }
        }else if let controller = segue.destination as? ContentViewController{
            //抓到使用者點選的row
            if let row = self.myCollection.indexPathsForSelectedItems?.first?.item{
                let rows = row
                controller.date = dateLabel.text
                controller.diary = self.diary
                controller.row = rows
            }
        }else if let controller = segue.destination as? PieChartViewController{
            controller.diary = self.diary
            controller.total = String(self.total)
        }
    }
}
