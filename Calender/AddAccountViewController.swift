//
//  AddAccountViewController.swift
//  Calender
//
//  Created by Simon on 2018/7/8.
//  Copyright © 2018年 Simon. All rights reserved.
//

import UIKit
import CoreData

class AddAccountViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
    var user = ["美食","通勤","娛樂","電話","醫療","日常用品","飲料","其他"]
    
    @IBOutlet weak var myPickerView: UIPickerView!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return user.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return user[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        moneyText.text = user[row]
    }
    var diary:DiaryUser?
    var total:TotalUser?
    var date:String?
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var helloButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let date = date{
            dateLabel.text = date
        }
        print("ok\(diary)")
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
        let my = myButton.frame.size.width / 2
        myButton.layer.cornerRadius = my
        let hello = helloButton.frame.size.width / 2
        helloButton.layer.cornerRadius = hello
        userView.layer.cornerRadius = 4.0
        userView.layer.borderWidth = 1.0
        userView.layer.borderColor = UIColor.clear.cgColor
        userView.layer.masksToBounds = false
        userView.layer.shadowColor = UIColor.gray.cgColor
        userView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        userView.layer.shadowRadius = 4.0
        userView.layer.shadowOpacity = 1.0
        userView.layer.masksToBounds = false
        //userView.layer.shadowPath = UIBezierPath(roundedRect:userView.bounds, cornerRadius: userView.layer.cornerRadius).cgPath
        noteView.layer.cornerRadius = 4.0
        noteView.layer.borderWidth = 1.0
        noteView.layer.borderColor = UIColor.clear.cgColor
        noteView.layer.masksToBounds = false
        noteView.layer.shadowColor = UIColor.gray.cgColor
        noteView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
       noteView.layer.shadowRadius = 4.0
        noteView.layer.shadowOpacity = 1.0
        noteView.layer.masksToBounds = false
      // noteView.layer.shadowPath = UIBezierPath(roundedRect:noteView.bounds, cornerRadius: noteView.layer.cornerRadius).cgPath
        moneyView.layer.cornerRadius = 4.0
        moneyView.layer.borderWidth = 1.0
        moneyView.layer.borderColor = UIColor.clear.cgColor
        moneyView.layer.masksToBounds = false
        moneyView.layer.shadowColor = UIColor.gray.cgColor
        moneyView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        moneyView.layer.shadowRadius = 4.0
        moneyView.layer.shadowOpacity = 1.0
        moneyView.layer.masksToBounds = false
        //moneyView.layer.shadowPath = UIBezierPath(roundedRect:moneyView.bounds, cornerRadius: moneyView.layer.cornerRadius).cgPath
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        if userText.text == ""{
            let alert = UIAlertController(title: "錯誤", message: "請輸入幾金額", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }else{
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                 total = TotalUser(context: appDelegate.persistentContainer.viewContext)
        let context = appDelegate.persistentContainer.viewContext
                if moneyText.text == ""{
                    total?.user = "美食"
                }else{
                    total?.user = moneyText.text ?? ""
                }
                total?.monay = userText.text ?? ""
                total?.note = noteText.text ?? ""
                if let diaryImage = myImage.image{
                    if let imageData = UIImagePNGRepresentation(diaryImage){
                        total?.accImage = NSData(data:imageData) as Data
                    }
                }
                total?.setValue(diary, forKey: "diaryUser")
                //diary?.addToTotalUser(total!)
                appDelegate.saveContext()
            }
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func returnButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            myImage.image = image
            myImage.contentMode = .scaleToFill
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
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
    @IBAction func taoGesture(_ sender: UITapGestureRecognizer) {
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
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
         view.endEditing(true)
        
    }
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var moneyText: UITextField!
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var moneyView: UIView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
