//
//  share it share it share it share it ShareViewController.swift
//  Calender
//
//  Created by Simon on 2018/8/27.
//  Copyright © 2018年 Simon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ShareViewController: UIViewController {
    var postID = ""
    var imageURL = ""
    var array:[[String:Any]] = []
    var arrayCount:Int?
    var post:[Post] = []
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var moodImage: UIImageView!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBAction func returnButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func nextButton(_ sender: UIButton) {
        if array.count == 1{
            var postDatabaseRef = Database.database().reference().child("posts").queryOrdered(byChild: "timestamp")
            postDatabaseRef.observeSingleEvent(of: .value) { (snapshot) in
                for item in snapshot.children.allObjects as! [DataSnapshot]{
                    let postInfo = item.value as? [String:Any] ?? [:]
                    self.array.append(postInfo)
                    self.arrayCount = self.array.count - 1
                    self.read()
                }
            }
        }else{
            DispatchQueue.main.async {
                self.array.removeLast()
                self.arrayCount = self.array.count - 1
                self.postID = self.array[self.arrayCount!]["postID"] as! String
               self.nameLabel.text = self.array[self.arrayCount!]["user"] as! String
                self.titleLabel.text = self.array[self.arrayCount!]["diaryWords"] as! String
                self.dateLabel.text = self.array[self.arrayCount!]["date"] as! String
                let weather = self.array[self.arrayCount!]["weatherImage"] as! String
                if weather == ""{
                    self.weatherImage.image = UIImage(named: "18")
                }else{
                    self.weatherImage.image = UIImage(named: weather)
                }
                let mood = self.array[self.arrayCount!]["moodImage"] as! String
                if mood == ""{
                    self.moodImage.image = UIImage(named: "22")
                }else{
                    self.moodImage.image = UIImage(named: mood)
                }
                self.currentTextView.text = self.array[self.arrayCount!]["diary"] as! String
                
                self.myImage.image = nil
                let imageURL = self.array[self.arrayCount!]["imageFileURL"] as? String
                if let image = CacheManager.shard.getFromCache(key: imageURL!) as? UIImage{
                    self.myImage.image = image
                    self.myImage.contentMode = .scaleToFill
                }else{
                    if let url = URL(string: imageURL!){
                        let downloadTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                            guard let imageData = data else{
                                return
                            }
                            OperationQueue.main.addOperation {
                                guard let image = UIImage(data: imageData) else{
                                    return
                                }
                                self.myImage.image = image
                                self.myImage.contentMode = .scaleToFill
                                CacheManager.shard.cache(object: image, key: imageURL!)
                            }
                        }
                        downloadTask.resume()
                    }
                }
            }
        }
    }
    @IBOutlet weak var nButton: UIButton!
    @IBOutlet weak var currentTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rButton: UIButton!
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          read()
        rButton.layer.cornerRadius = rButton.frame.size.width / 2
        nButton.layer.cornerRadius = nButton.frame.size.width / 2
        messageButton.layer.cornerRadius = messageButton.frame.size.width / 2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var postDatabaseRef = Database.database().reference().child("posts").queryOrdered(byChild: "timestamp")
        postDatabaseRef.observeSingleEvent(of: .value) { (snapshot) in
            for item in snapshot.children.allObjects as! [DataSnapshot]{
                let postInfo = item.value as? [String:Any] ?? [:]
                self.array.append(postInfo)
                self.arrayCount = self.array.count - 1
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func read(){
        var postDatabaseRef = Database.database().reference().child("posts").queryOrdered(byChild: "timestamp")
        postDatabaseRef = postDatabaseRef.queryLimited(toLast: 1)
        postDatabaseRef.observeSingleEvent(of: .value) { (snapshot) in
            for item in snapshot.children.allObjects as! [DataSnapshot]{
                DispatchQueue.main.async {
                    let postInfo = item.value as? [String:Any] ?? [:]
                    self.postID = postInfo["postID"] as? String ?? ""
                    self.nameLabel.text = postInfo["user"] as? String
                    self.titleLabel.text = postInfo["diaryWords"] as? String
                    self.dateLabel.text = postInfo["date"] as? String
                    let weather = postInfo["weatherImage"] as? String
                    if weather == ""{
                        self.weatherImage.image = UIImage(named: "18")
                    }else{
                        self.weatherImage.image = UIImage(named: weather!)
                    }
                    let mood = postInfo["moodImage"] as? String
                    if mood == ""{
                        self.moodImage.image = UIImage(named: "22")
                    }else{
                        self.moodImage.image = UIImage(named: mood!)
                    }
                    self.currentTextView.text = postInfo["diary"] as? String
                    self.myImage.image = nil
                    let imageURL = postInfo["imageFileURL"] as? String
                    if let image = CacheManager.shard.getFromCache(key: imageURL!) as? UIImage{
                        self.myImage.image = image
                        self.myImage.contentMode = .scaleToFill
                    }else{
                        if let url = URL(string: imageURL!){
                            let downloadTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                                guard let imageData = data else{
                                    return
                                }
                                //OperationQueue.main.addOperation
                                         DispatchQueue.main.async {
                                    guard let image = UIImage(data: imageData) else{
                                        return
                                    }
                                    self.myImage.image = image
                                    self.myImage.contentMode = .scaleToFill
                                    CacheManager.shard.cache(object: image, key: imageURL!)
                                }
                            }
                            downloadTask.resume()
                        }
                    }
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? MessageViewController{
            controller.postID = self.postID
            controller.imageURL = self.imageURL
            print("圖片\(self.imageURL)")
        }
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
