//
//  PieChartViewController.swift
//  Calender
//
//  Created by Simon on 2018/7/21.
//  Copyright © 2018年 Simon. All rights reserved.
//

import UIKit

class PieChartViewController: UIViewController{
    var diary:DiaryUser?
    var total:String?
    var start:CGFloat = 0
    var foodArray = [Double]()
    var commutingArray = [Double]()
    var entertainmentArray = [Double]()
    var phoneArray = [Double]()
    var medicalArray = [Double]()
    var dailySuppliesArray = [Double]()
    var drinkArray = [Double]()
    var otherArray = [Double]()
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var commutingLabel: UILabel!
    @IBOutlet weak var entertainmentLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    @IBOutlet weak var drinkLabel: UILabel!
    @IBOutlet weak var dailySuppliesLabel: UILabel!
    @IBOutlet weak var medicalLabel: UILabel!
    @IBOutlet weak var returnButton: UIButton!
    @IBAction func myButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func pieChart(radius:CGFloat,startAngle:CGFloat,endAngle:CGFloat,color:CGColor) {
        print(startAngle, endAngle)
        let path = UIBezierPath(arcCenter: view.center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.addLine(to: view.center)
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = color
        self.view.layer.addSublayer(layer)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let total = total{
            let totals = Double(total)
            var totalDiarys:Double = 0
        if let diary = diary{
            if let totalDiary = diary.totalUser?.allObjects as? [TotalUser]{
                var foodTotal = totalDiary.filter { $0.user == "美食" }
                let foodColor = UIColor(red: 234/255, green: 50/255, blue: 35/255, alpha: 1)
                for i in 0 ..< foodTotal.count{
                    let money:Double = Double(foodTotal[i].monay!)!
                    foodArray.append(money)
                    totalDiarys += Double(foodArray[i])
                    if UIScreen.main.sizeType == .iPhone5{
                        pieChart(radius: 120, startAngle: start, endAngle: start + CGFloat(2 * Double.pi / totals! * foodArray[i]) , color: foodColor.cgColor)
                        start += CGFloat(2 * Double.pi / totals! * foodArray[i])
//                          foodLabel.text = "\(Int(foodArray[i] / totals! * 100))%"
                        foodLabel.text = "\(Int(totalDiarys / totals! * 100))%"
                        totalDiarys = 0
                    }else{
                        pieChart(radius: 160, startAngle: start, endAngle: start + CGFloat(2 * Double.pi / totals! * foodArray[i]) , color: foodColor.cgColor)
                        start += CGFloat(2 * Double.pi / totals! * foodArray[i])
                          foodLabel.text = "\(Int(totalDiarys / totals! * 100))%"
                         totalDiarys = 0
                    }
                }
                var commutingTotal = totalDiary.filter { $0.user == "通勤" }
                let commutingColor = UIColor(red: 242/255, green: 157/255, blue: 78/255, alpha: 1)
                for i in 0 ..< commutingTotal.count{
                    let money:Double = Double(commutingTotal[i].monay!)!
                    commutingArray.append(money)
                    totalDiarys += Double(commutingArray[i])

                    if UIScreen.main.sizeType == .iPhone5{
                        pieChart(radius: 120, startAngle: start, endAngle: start + CGFloat(2 * Double.pi / totals! * commutingArray[i]) , color: commutingColor.cgColor)
                        start += CGFloat(2 * Double.pi / totals! * commutingArray[i])
                        //commutingLabel.text = "\(Int(commutingArray[i] / totals! * 100))%"
                        commutingLabel.text = "\(Int(totalDiarys / totals! * 100))%"
                        totalDiarys = 0
                    }else{
                        pieChart(radius: 160, startAngle: start, endAngle: start + CGFloat(2 * Double.pi / totals! * commutingArray[i]) , color: commutingColor.cgColor)
                        start += CGFloat(2 * Double.pi / totals! * commutingArray[i])
                        commutingLabel.text = "\(Int(totalDiarys / totals! * 100))%"
                        totalDiarys = 0
                    }
                }
                var entertainmentTotal = totalDiary.filter { $0.user == "娛樂" }
                let entertainmentColor = UIColor(red: 252/255, green: 251/255, blue: 124/255, alpha: 1)
                for i in 0 ..< entertainmentTotal.count{
                    let money:Double = Double(entertainmentTotal[i].monay!)!
                    entertainmentArray.append(money)
                    totalDiarys += Double(entertainmentArray[i])

                    if UIScreen.main.sizeType == .iPhone5{
                        pieChart(radius: 120, startAngle: start, endAngle: start + CGFloat(2 * Double.pi / totals! * entertainmentArray[i]) , color: entertainmentColor.cgColor)
                        start += CGFloat(2 * Double.pi / totals! * foodArray[i])
//                        entertainmentLabel.text = "\(Int(entertainmentArray[i] / totals! * 100))%"
                        entertainmentLabel.text = "\(Int(totalDiarys / totals! * 100))%"
                        totalDiarys = 0
                    }else{
                        pieChart(radius: 160, startAngle: start, endAngle: start + CGFloat(2 * Double.pi / totals! * entertainmentArray[i]) , color: entertainmentColor.cgColor)
                        start += CGFloat(2 * Double.pi / totals! * entertainmentArray[i])
                        entertainmentLabel.text = "\(Int(totalDiarys / totals! * 100))%"
                        totalDiarys = 0
                    }
                }
                
                var phoneTotal = totalDiary.filter { $0.user == "電話" }
                let phoneColor = UIColor(red: 177/255, green: 251/255, blue: 163/255, alpha: 1)
                for i in 0 ..< phoneTotal.count{
                    let money:Double = Double(phoneTotal[i].monay!)!
                    phoneArray.append(money)
                    totalDiarys += Double(phoneArray[i])

                    if UIScreen.main.sizeType == .iPhone5{
                        pieChart(radius: 120, startAngle: start, endAngle: start + CGFloat(2 * Double.pi / totals! * phoneArray[i]) , color: phoneColor.cgColor)
                        start += CGFloat(2 * Double.pi / totals! * phoneArray[i])
//                        phoneLabel.text = "\(Int(phoneArray[i] / totals! * 100))%"
                        phoneLabel.text = "\(Int(totalDiarys / totals! * 100))%"
                        totalDiarys = 0
                    }else{
                        pieChart(radius: 160, startAngle: start, endAngle: start + CGFloat(2 * Double.pi / totals! * phoneArray[i]) , color: phoneColor.cgColor)
                        start += CGFloat(2 * Double.pi / totals! * phoneArray[i])
                        phoneLabel.text = "\(Int(totalDiarys / totals! * 100))%"
                        totalDiarys = 0
                    }
                }
                
                var medicalTotal = totalDiary.filter { $0.user == "醫療" }
                let medicalColor = UIColor(red: 176/255, green: 252/255, blue: 254/255, alpha: 1)
                for i in 0 ..< medicalTotal.count{
                    let money:Double = Double(medicalTotal[i].monay!)!
                    medicalArray.append(money)
                    totalDiarys += Double(medicalArray[i])

                    if UIScreen.main.sizeType == .iPhone5{
                        pieChart(radius: 120, startAngle: start, endAngle: start + CGFloat(2 * Double.pi / totals! * medicalArray[i]) , color: medicalColor.cgColor)
                        start += CGFloat(2 * Double.pi / totals! * medicalArray[i])
//                        medicalLabel.text = "\(Int(medicalArray[i] / totals! * 100))%"
                        medicalLabel.text = "\(Int(totalDiarys / totals! * 100))%"
                        totalDiarys = 0
                    }else{
                        pieChart(radius: 160, startAngle: start, endAngle: start + CGFloat(2 * Double.pi / totals! * medicalArray[i]) , color: medicalColor.cgColor)
                        start += CGFloat(2 * Double.pi / totals! * medicalArray[i])
                        medicalLabel.text = "\(Int(totalDiarys / totals! * 100))%"
                        totalDiarys = 0
                    }
                }
                
                var dailySuppliesTotal = totalDiary.filter { $0.user == "日常用品" }
                let dailySuppliesColor = UIColor(red: 110/255, green: 154/255, blue: 248/255, alpha: 1)
                for i in 0 ..< dailySuppliesTotal.count{
                    let money:Double = Double(dailySuppliesTotal[i].monay!)!
                   dailySuppliesArray.append(money)
                    totalDiarys += Double(dailySuppliesArray[i])

                    if UIScreen.main.sizeType == .iPhone5{
                        pieChart(radius: 120, startAngle: start, endAngle: start + CGFloat(2 * Double.pi / totals! * dailySuppliesArray[i]) , color: dailySuppliesColor.cgColor)
                        start += CGFloat(2 * Double.pi / totals! * dailySuppliesArray[i])
//                        dailySuppliesLabel.text = "\(Int(dailySuppliesArray[i] / totals! * 100))%"
                        dailySuppliesLabel.text = "\(Int(totalDiarys / totals! * 100))%"
                        totalDiarys = 0
                    }else{
                        pieChart(radius: 160, startAngle: start, endAngle: start + CGFloat(2 * Double.pi / totals! * dailySuppliesArray[i]) , color: dailySuppliesColor.cgColor)
                        start += CGFloat(2 * Double.pi / totals! * dailySuppliesArray[i])
                        dailySuppliesLabel.text = "\(Int(totalDiarys / totals! * 100))%"
                        totalDiarys = 0
                    }
                }
                
                var drinkTotal = totalDiary.filter { $0.user == "飲料" }
                let drinkColor = UIColor(red: 144/255, green: 108/255, blue: 246/255, alpha: 1)
                for i in 0 ..< drinkTotal.count{
                    let money:Double = Double(drinkTotal[i].monay!)!
                   drinkArray.append(money)
                    totalDiarys += Double(drinkArray[i])

                    if UIScreen.main.sizeType == .iPhone5{
                        pieChart(radius: 120, startAngle: start, endAngle: start + CGFloat(2 * Double.pi / totals! * drinkArray[i]) , color: drinkColor.cgColor)
                        start += CGFloat(2 * Double.pi / totals! * drinkArray[i])
//                        drinkLabel.text = "\(Int(drinkArray[i] / totals! * 100))%"
                        drinkLabel.text = "\(Int(totalDiarys / totals! * 100))%"
                        totalDiarys = 0
                    }else{
                        pieChart(radius: 160, startAngle: start, endAngle: start + CGFloat(2 * Double.pi / totals! * drinkArray[i]) , color: drinkColor.cgColor)
                        start += CGFloat(2 * Double.pi / totals! * drinkArray[i])
                        drinkLabel.text = "\(Int(totalDiarys / totals! * 100))%"
                        totalDiarys = 0
                    }
                }
                
                var otherTotal = totalDiary.filter { $0.user == "其他" }
                let otherColor = UIColor(red: 17/255, green: 237/255, blue: 238/255, alpha: 1)
                for i in 0 ..< otherTotal.count{
                    let money:Double = Double(otherTotal[i].monay!)!
                    otherArray.append(money)
                    totalDiarys += Double(otherArray[i])

                    if UIScreen.main.sizeType == .iPhone5{
                        pieChart(radius: 120, startAngle: start, endAngle: start + CGFloat(2 * Double.pi / totals! * otherArray[i]) , color: otherColor.cgColor)
                        start += CGFloat(2 * Double.pi / totals! * otherArray[i])
//                        otherLabel.text = "\(Int(otherArray[i] / totals! * 100))%"
                        otherLabel.text = "\(Int(totalDiarys / totals! * 100))%"
                        totalDiarys = 0
                    }else{
                        pieChart(radius: 160, startAngle: start, endAngle: start + CGFloat(2 * Double.pi / totals! * otherArray[i]) , color: otherColor.cgColor)
                        start += CGFloat(2 * Double.pi / totals! * otherArray[i])
                        otherLabel.text = "\(Int(totalDiarys / totals! * 100))%"
                        totalDiarys = 0
                        }
                    }
                }
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        returnButton.layer.cornerRadius = returnButton.frame.size.width / 2
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
extension UIColor{
    open class var randomColor:UIColor{
        get{
            let red = CGFloat(arc4random() % 256) / 255
            let green = CGFloat(arc4random() % 256) / 255
            let blue = CGFloat(arc4random() % 256) / 255
            return UIColor(red: red, green: green, blue: blue, alpha: 1)
        }
    }
}
extension UIScreen {
    enum SizeType: CGFloat {
        case Unknown = 0.0
        case iPhone4 = 960.0
        case iPhone5 = 1136.0
        case iPhone6 = 1334.0
        case iPhone6Plus = 1920.0
    }
    
    var sizeType: SizeType {
        let height = nativeBounds.height
        guard let sizeType = SizeType(rawValue: height) else { return .Unknown }
        return sizeType
    }
}
