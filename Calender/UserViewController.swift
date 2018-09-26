//
//  UserViewController.swift
//  Calender
//
//  Created by Simon on 2018/8/21.
//  Copyright © 2018年 Simon. All rights reserved.
//

import UIKit
import CoreData
import JTAppleCalendar
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FBSDKLoginKit
import GoogleSignIn


class UserViewController: UIViewController {
    let a = 1
    var diary = [DiaryUser]()
    var myImageURL = [[String:Any]]()
    @IBOutlet weak var uidLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    let formatter = DateFormatter()
    //用於比較的日期
    var date = Date()
    @IBAction func CanaelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    //交換
    @IBAction func exchangeButton(_ sender: UIButton) {
        //先取到今天的日期再去跟陣列做比較 然後帶出交換頁面
//        formatter.dateFormat = "yyyy/MM/dd"
//        if diary.count != 0{
//            for i in 0..<diary.count{
//                let to = Calendar.current.date(byAdding: .day, value: -1, to: date)
//               let too =  Calendar.current.date(byAdding: .hour, value: 16, to: to!)
//                let tooo = Calendar.current.date(byAdding: .minute, value: -33, to: too!)
//                let t = Calendar.current.date(byAdding: .second, value: -71, to: tooo!)
//                print("to\(t)")
//                switch date.compare(diary[i].date!){
//                case .orderedAscending:
//                    let alertController = UIAlertController(title: "錯誤", message: "請先紀錄今天的日記", preferredStyle: .alert)
//                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                    print("2")
//                    present(alertController, animated: true, completion: nil)
//                case .orderedDescending:
//                    let alertController = UIAlertController(title: "錯誤", message: "請先紀錄今天的日記", preferredStyle: .alert)
//                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                    print("3")
//                    present(alertController, animated: true, completion: nil)
//                case .orderedSame:
//                    if diary[i].diary != ""{
//                        guard let controller = storyboard?.instantiateViewController(withIdentifier: "diary") as? DiaryViewController else{return}
//                        controller.date = formatter.string(from: t!)
//                        controller.diary = diary[i]
//                        present(controller, animated: true, completion: nil)
//                        print("1")
//                        break
//                    }
//                }
        

//                if to!.compare(diary[i].date!) == .orderedDescending{
//                    if diary[i].diary != ""{
//                        guard let controller = storyboard?.instantiateViewController(withIdentifier: "diary") as? DiaryViewController else{return}
//                        controller.date = formatter.string(from: to! )
//                        controller.diary = diary[i]
//                        present(controller, animated: true, completion: nil)
//                        print("1")
//                        break
//                    }
//                }else{
//                    let alertController = UIAlertController(title: "錯誤", message: "請先紀錄今天的日記", preferredStyle: .alert)
//                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                    print("2")
//                    present(alertController, animated: true, completion: nil)
//                }
//            }
//        }else{
//            let alertController = UIAlertController(title: "錯誤", message: "請先紀錄今天的日記", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            print("4")
//            present(alertController, animated: true, completion: nil)
//            }
        }
    //登出
    @IBAction func SignOutButton(_ sender: UIButton) {
        do{
            if let providerData = Auth.auth().currentUser?.providerData {
                let userInfo = providerData[0]
                
                switch userInfo.providerID {
                case "google.com":
                    GIDSignIn.sharedInstance().signOut()
                    
                default:
                    break
                }
            }
            try Auth.auth().signOut()
        }catch{
            let alertController = UIAlertController(title: "登出錯誤", message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "email"){
            UIApplication.shared.keyWindow?.rootViewController = viewController
            self.dismiss(animated: true, completion: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let curr = Auth.auth().currentUser{
            nameLabel.text = curr.displayName
            emailLabel.text = curr.email
            let imageURL = Database.database().reference().child("user")
            imageURL.observeSingleEvent(of: .value) { (snapshot) in
                for i in snapshot.children.allObjects as! [DataSnapshot]{
                    let imageID = i.value as? [String:Any] ?? [:]
                    let imagesURL = imageID["email"] as! String
                    if curr.email == imagesURL{
                        self.myImageURL.append(imageID)
                        let i = self.myImageURL[0] as? [String:Any] ?? [:]
                        let urls = i["imageFileURL"] as! String
                        print("圖片\(urls)")
                        if let url = URL(string: urls){
                            let downloadTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                                DispatchQueue.main.async {
                                    guard let imageData = data else{return}
                                    self.imageView.image = UIImage(data: imageData)
                                    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
                                }
                            }
                            downloadTask.resume()
                        }
                    }else{
                        print("沒有圖片")
                    }
                }
            }
        }
        //讀檔
//        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
//            let users:NSFetchRequest<DiaryUser> = DiaryUser.fetchRequest()
//            let context = appDelegate.persistentContainer.viewContext
//            do{
//                diary = try context.fetch(users)
//                for i in 0..<diary.count{
//                    print("時間\(diary[i].date)")
//                }
//            }catch{
//            }
//        }
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
