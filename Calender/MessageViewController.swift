//
//  MessageViewController.swift
//  Calender
//
//  Created by Simon on 2018/9/9.
//  Copyright © 2018年 Simon. All rights reserved.
//

import UIKit
import Firebase

class MessageViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var imageURL = ""
    var date = Date()
    var postID = ""
    var timeArray = [String]()
    var nameArray = [String]()
    var messageArray = [String]()
    var message = [[String:Any]]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return message.count
    }
    @IBAction func reButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    let cells = MessageCollectionViewCell()
    //這裡
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = myCollectionView.frame.size.width
//        let height = cells.massageLabel.frame.height
//        
//        return CGSize(width: width , height: height)
//    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cells", for: indexPath) as! Cell
            for i in 0..<message.count{
                let a = message[i] as? [String:Any] ?? [:]
                print("ABC\(a)")
                print("不\(message)")
                nameArray.append(a["name"] as! String)
                messageArray.append(a["message"] as! String)
                timeArray.append(a["date"] as? String ?? "")
            }
            cell.nameLabel.text = nameArray[indexPath.row]
            cell.contentLabel.text = messageArray[indexPath.row]
            cell.timeLabel.text = timeArray[indexPath.row]
            timeArray.removeAll()
            nameArray.removeAll()
            messageArray.removeAll()
            //        cell.nameLabel.text = "12"
            //        cell.timeLabel.text = "302"
            //        cell.contentLabel.text = "33"
        return cell
    }
//    利用上一頁將貼文ID傳過來
//    1.找出貼文的ID 然後把貼文的ID存進一個json檔 json檔案有貼文ID,姓名,留言
//    2.用貼文ID跟留言的貼文ID比較 依樣的就顯示在留言
    
    @IBAction func myButton(_ sender: UIButton) {
        if let curr = Auth.auth().currentUser{
            let messageRef = Database.database().reference().child("message").childByAutoId()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let dateTime = formatter.string(from: date)
            print("時間\(dateTime)")
            let post:[String:Any] = ["name" : curr.displayName, "message" : myTextField.text, "messageID" : postID ,"date":dateTime]
            messageRef.setValue(post)
            self.message.append(post)
            myTextField.text = ""
            myCollectionView.reloadData()
            view.endEditing(true)
        }
    }
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.register(UINib.init(nibName: "Cell", bundle:nil), forCellWithReuseIdentifier: "cells")
        if let flowLayout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
            print("貼文ID\(postID)")
        // 註冊監控
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow), // 執行keyboardWillShow function
            name: NSNotification.Name.UIKeyboardWillShow, // 在鍵盤跳出來的時候
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide), // 執行keyboardWillHide function
            name: NSNotification.Name.UIKeyboardWillHide, // 在鍵盤收起來的時候
            object: nil
        )
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        // 擷取鍵盤高度，並將view的y座標設定為負的鍵盤高度，這樣view就會往上提高
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame = CGRect(x: 0.0, y: -keyboardHeight, width: self.view.frame.width, height: self.view.frame.size.height)
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        // 鍵盤收起來時，就將view歸回原位
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        returnButton.layer.cornerRadius = returnButton.frame.size.width / 2
        let messageRef = Database.database().reference().child("message")
        messageRef.observeSingleEvent(of: .value) { (snapshot) in
            for i in snapshot.children.allObjects as! [DataSnapshot]{
                let messageRefs = i.value as? [String:Any] ?? [:]
                print("陣列\(messageRefs)")
                var messageID = messageRefs["messageID"] as! String
                print("IIIID\(messageID)")
                if self.postID == messageID{
                    self.message.append(messageRefs)
                    self.myCollectionView.reloadData()
                    print("陣列列\(self.message)")
                }
            }
        }
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
