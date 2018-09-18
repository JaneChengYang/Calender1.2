//
//  DiaryViewController.swift
//  Calender
//
//  Created by Simon on 2018/6/28.
//  Copyright © 2018年 Simon. All rights reserved.
//

import UIKit
import BubbleTransition
import Firebase
import FirebaseDatabase
import FirebaseStorage

class DiaryViewController: UIViewController,UIViewControllerTransitioningDelegate{
    var diary:DiaryUser?
    var date:String?
    @IBAction func shareButton(_ sender: UIButton) {
       let alertController = UIAlertController(title: "分享", message: "把日記分享至雲端", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "確定", style: .default, handler: { (alertAction) in
            self.share()
        }))
        present(alertController, animated: true, completion: nil)
    }
    @IBOutlet weak var sButton: UIButton!
    @IBOutlet weak var oneView: UIView!
    @IBOutlet weak var heightLayout: NSLayoutConstraint!
    @IBOutlet weak var helloButton: UIButton!
    //日記
    @IBOutlet weak var diaryTextView: UITextView!
    //心情圖
    @IBOutlet weak var moodImage: UIImageView!
    //天氣圖
    @IBOutlet weak var weatherImage: UIImageView!
    //每日一句
    @IBOutlet weak var diaryWeatherLabel: UILabel!
    //日期label
    @IBOutlet weak var myLabel: UILabel!
    //返回按鈕
    @IBAction func returnButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    //圖片
    @IBOutlet weak var myImage: UIImageView!
    //特效按鈕
    @IBAction func accountButton(_ sender: UIButton) {
        
        
    }
    @IBAction func addButton(_ sender: UIButton) {
    }
    
    @IBOutlet weak var acButton: UIButton!
    @IBOutlet weak var myButton: UIButton!
    let transition = BubbleTransition()
    //更新
    @IBAction func unwindToLoversPage(segue: UIStoryboardSegue) {
//        if let source = segue.source as? EditViewController,let diarys = source.diary{
//            self.diary = diarys
//        }
    }
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addController = segue.destination as? EditViewController {
            addController.diary = self.diary
            addController.date = myLabel.text
        }else{
            let addController = segue.destination as? AccountViewController
            addController?.date = myLabel.text
            addController?.diary = self.diary
        }
        let controller = segue.destination
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.duration = 0.4
        transition.startingPoint = acButton.center
        transition.bubbleColor = acButton.backgroundColor!
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.duration = 0.5
        transition.startingPoint = acButton.center
        transition.bubbleColor = acButton.backgroundColor!
        return transition
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let hello = helloButton.frame.size.width / 2
        helloButton.layer.cornerRadius = hello
        let my = myButton.frame.size.width / 2
        myButton.layer.cornerRadius = my
        let ac = acButton.frame.size.width / 2
        acButton.layer.cornerRadius = ac
        sButton.layer.cornerRadius = sButton.frame.size.width / 2
        if let date = date{
            myLabel.text = date
        }
        if let diary = diary{
            diaryWeatherLabel.text = diary.diaryLabel
            if let weatherImage = diary.weather{
                if weatherImage == ""{
                    self.weatherImage.image = UIImage(named: "18")
                }else{
                    self.weatherImage.image = UIImage(named: weatherImage)
                }
            }
            if let moodImage = diary.mood{
                if moodImage == ""{
                    self.moodImage.image = UIImage(named: "23")
                }else{
                    self.moodImage.image = UIImage(named:moodImage)
                }
            }
            if diary.diaryImage == nil{
                myImage.image = UIImage(named:"4")
                myImage.contentMode = .center
            }else if diary.diaryImage != nil{
                myImage.image = UIImage(data: diary.diaryImage!)
                myImage.contentMode = .scaleToFill
            }
            diaryTextView.text = diary.diary
        }
    }
    func share(){
        //產生一個唯一的貼文 ID 並準備貼文資料庫的參照
        let postDatabaseRef = Database.database().reference().child("posts").childByAutoId()
        // 使用這唯一的 key 作為圖片名稱並準備 Storage 參照
        let imageStorageRef = Storage.storage().reference().child("photos").child("\(postDatabaseRef.key).jpg")
        // 調整圖片大小
        let scaledImage = myImage.image!.scale(newWidth: 640.0)
        guard let imageData = UIImageJPEGRepresentation(scaledImage, 0.9) else {
            return
        }
        // 建立檔案的元資料
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        // 上傳任務準備
        let uploadTask = imageStorageRef.putData(imageData, metadata: metadata)
        // 觀察上傳狀態
        uploadTask.observe(.success) { (snapshot) in
            guard let displayName = Auth.auth().currentUser?.displayName else {
                return
            }
            let timestamp = Int(NSDate().timeIntervalSince1970 * 1000)
            // 在資料庫加上一個參照
            let url = imageStorageRef.downloadURL(completion: { (url, error) in
                if let error = error{
                    print(error.localizedDescription)
                }
                if let url = url{
                    let post:[String:Any] = ["imageFileURL": url.absoluteString,"user": displayName,"diaryWords":self.diaryWeatherLabel.text,"date":self.myLabel.text,"weatherImage":self.diary?.weather,"moodImage":self.diary?.mood,"diary":self.diaryTextView.text,"timestamp":timestamp,"postID":postDatabaseRef.key]
                    postDatabaseRef.setValue(post)
                }
            })
        }
        uploadTask.observe(.progress) { (snapshot) in
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            print("Uploading \(postDatabaseRef.key).jpg... \(percentComplete)% complete")
        }
        uploadTask.observe(.failure) { (snapshot) in
            
            if let error = snapshot.error {
                print(error.localizedDescription)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
