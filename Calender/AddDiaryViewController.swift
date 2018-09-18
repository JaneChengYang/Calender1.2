//
//  AddDiaryViewController.swift
//  Calender
//
//  Created by Simon on 2018/6/28.
//  Copyright © 2018年 Simon. All rights reserved.
//

import UIKit
import CoreData

class AddDiaryViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var diary:DiaryUser?
    var moodString = ""
    var weatherString = ""
    var date:String?
    
    @IBOutlet weak var helloButton: UIButton!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myImage: UIImageView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let my = myButton.frame.size.width / 2
        myButton.layer.cornerRadius = my
        let hello = helloButton.frame.size.width / 2
        helloButton.layer.cornerRadius = hello
        moodImage.image = UIImage(named: "22")
        weatherImage.image = UIImage(named: "18")
    }
    @IBAction func tapView(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        //收鍵盤
        view.endEditing(true)
                let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                alertController.addAction(UIAlertAction(title: "拍照", style: .default, handler: { (alerAction) in
                    self.photograph()
                }))
                alertController.addAction(UIAlertAction(title: "從相簿選照片", style: .default, handler: { (alerAction) in
                    let imagePickerController = UIImagePickerController()
                    imagePickerController.sourceType = .photoLibrary
                    imagePickerController.delegate = self
                    imagePickerController.allowsEditing = true
                    self.present(imagePickerController, animated: true, completion: nil)
                }))
                alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
                present(alertController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            myImage.image = image
            myImage.contentMode = .scaleToFill
            //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        dismiss(animated: true, completion: nil)
    }
    func photograph(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBAction func returnButton(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
    }
    @IBAction func myButton(_ sender: UIButton) {
        if noteText.text == ""{
         let alertController = UIAlertController(title: "錯誤", message: "紀錄您的一天吧", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }else{
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                diary = DiaryUser(context: appDelegate.persistentContainer.viewContext)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy/MM/dd"
                let date = dateFormatter.date(from: dateLabel.text!)
                diary?.date = date
                diary?.diaryLabel = diaryText.text
                diary?.diary = noteText.text
                diary?.mood = moodString
                diary?.weather = weatherString
                if let diaryImage = myImage.image{
                    if let imageData = UIImagePNGRepresentation(diaryImage){
                        diary?.diaryImage = NSData(data:imageData) as Data
                    }
                }
                appDelegate.saveContext()
            }
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func mood1Button(_ sender: UIButton) {
        //22~38
        if sender.tag == 0{
            moodImage.image = UIImage(named: "22")
            moodString = "22"
        }else if sender.tag == 1 {
            moodImage.image = UIImage(named: "23")
            moodString = "23"
        }else if sender.tag == 2{
            moodImage.image = UIImage(named: "24")
            moodString = "24"
        }else if sender.tag == 3{
            moodImage.image = UIImage(named: "25")
            moodString = "25"
        }else if sender.tag == 4{
           moodImage.image = UIImage(named: "26")
            moodString = "26"
        }else if sender.tag == 5{
           moodImage.image = UIImage(named: "27")
            moodString = "27"
        }else if sender.tag == 6{
            moodImage.image = UIImage(named: "28")
            moodString = "28"
        }else if sender.tag == 7{
            moodImage.image = UIImage(named: "29")
            moodString = "29"
        }else if sender.tag == 8{
            moodImage.image = UIImage(named: "30")
            moodString = "30"
        }else if sender.tag == 9{
            moodImage.image = UIImage(named: "31")
            moodString = "31"
        }else if sender.tag == 10{
            moodImage.image = UIImage(named: "32")
            moodString = "32"
        }else if sender.tag == 11{
            moodImage.image = UIImage(named: "37")
            moodString = "37"
        }else if sender.tag == 12{
            moodImage.image = UIImage(named: "34")
            moodString = "34"
        }else if sender.tag == 13{
            moodImage.image = UIImage(named: "35")
            moodString = "35"
        }else if sender.tag == 14{
           moodImage.image = UIImage(named: "36")
            moodString = "36"
        }else if sender.tag == 15{
            moodImage.image = UIImage(named: "38")
            moodString = "38"
        }
    }
    @IBAction func myWeatherButton(_ sender: UIButton) {
        // 5~21
        if sender.tag == 0{
            weatherImage.image = UIImage(named: "5")
            weatherString = "5"
        }else if sender.tag == 1 {
            weatherImage.image = UIImage(named: "6")
            weatherString = "6"
        }else if sender.tag == 2{
            weatherImage.image = UIImage(named: "7")
            weatherString = "7"
        }else if sender.tag == 3{
            weatherImage.image = UIImage(named: "8")
            weatherString = "8"
        }else if sender.tag == 4{
            weatherImage.image = UIImage(named: "9")
            weatherString = "9"
        }else if sender.tag == 5{
            weatherImage.image = UIImage(named: "10")
            weatherString = "10"
        }else if sender.tag == 6{
            weatherImage.image = UIImage(named: "11")
            weatherString = "11"
        }else if sender.tag == 7{
            weatherImage.image = UIImage(named: "12")
            weatherString = "12"
        }else if sender.tag == 8{
            weatherImage.image = UIImage(named: "13")
            weatherString = "13"
        }else if sender.tag == 9{
            weatherImage.image = UIImage(named: "14")
            weatherString = "14"
        }else if sender.tag == 10{
            weatherImage.image = UIImage(named: "15")
            weatherString = "15"
        }else if sender.tag == 11{
            weatherImage.image = UIImage(named: "16")
            weatherString = "16"
        }else if sender.tag == 12{
            weatherImage.image = UIImage(named: "17")
            weatherString = "17"
        }else if sender.tag == 13{
            weatherImage.image = UIImage(named: "18")
            weatherString = "18"
        }else if sender.tag == 14{
            weatherImage.image = UIImage(named: "19")
            weatherString = "19"
        }else if sender.tag == 15{
            weatherImage.image = UIImage(named: "20")
            weatherString = "20"
        }else if sender.tag == 16{
            weatherImage.image = UIImage(named: "21")
            weatherString = "21"
        }
    }
    @IBOutlet weak var moodImage: UIImageView!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var diaryText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let date = date{
            dateLabel.text = date
        }
        if let diary = diary{
            if let image = diary.diaryImage{
             myImage.image = UIImage(data: image)
            }else{
                myImage.image = UIImage(named: "4")
            }
            diaryText.text = diary.diaryLabel
            moodImage.image = UIImage(named: diary.mood!)
            weatherImage.image = UIImage(named: diary.weather!)
            noteText.text = diary.diary
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
