//
//  ContentViewController.swift
//  Calender
//
//  Created by Simon on 2018/7/9.
//  Copyright © 2018年 Simon. All rights reserved.
//

import UIKit
import CoreData

class ContentViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
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
        moneLabel.text = user[row]
    }
    var row:Int?
    @IBOutlet weak var helloButton: UIButton!
    @IBOutlet weak var myImgae: UIImageView!
    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var moneysView: UIView!
    @IBOutlet weak var usersView: UIView!
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var moneyView: UIView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var moneyText: UITextField!
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var moneLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    var diary:DiaryUser!
    var date:String?
    @IBOutlet weak var myButton: UIButton!
    @IBAction func tapView(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func saveButton(_ sender: UIButton) {
        if isSwitch.isOn == true{
            let alert = UIAlertController(title: "錯誤", message: "請把開關關掉", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }else if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            let result = NSFetchRequest<NSFetchRequestResult>(entityName: "DiaryUser")
            let context = appDelegate.persistentContainer.viewContext
            do{
                let results = try context.fetch(result)
                if let totalDiary = diary.totalUser?.allObjects as? [TotalUser]{
                    totalDiary[row!].monay = userLabel.text
                    totalDiary[row!].user = moneLabel.text
                    totalDiary[row!].note = noteLabel.text
                    if let diaryImage = myImgae.image{
                        if let imageData = UIImagePNGRepresentation(diaryImage){
                            totalDiary[row!].accImage = NSData(data:imageData) as Data
                        }
                    }
                    appDelegate.saveContext()
                }
                dismiss(animated: true, completion: nil)
            }catch{
                
            }
        }
    }
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        //收鍵盤
        view.endEditing(true)
        if isSwitch.isOn == true{
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
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            myImgae.image = image
            myImgae.contentMode = .scaleToFill
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
    @IBAction func mySwitch(_ sender: UISwitch) {
        if isSwitch.isOn == false{
            myButton.backgroundColor = UIColor(red: 199/255, green: 79/255, blue: 78/255, alpha: 1)
            userLabel.isHidden = false
            moneLabel.isHidden = false
            noteLabel.isHidden = false
            userLabel.text = userText.text
            //moneLabel.text = moneyText.text
            noteLabel.text = noteText.text
            userText.isHidden = true
            //moneyText.isHidden = true
            myPickerView.isHidden = true
            noteText.isHidden = true
            userView.backgroundColor = UIColor(red: 199/255, green: 79/255, blue: 78/255, alpha: 1)
            moneyView.backgroundColor = UIColor(red: 199/255, green: 79/255, blue: 78/255, alpha: 1)
            noteView.backgroundColor = UIColor(red: 199/255, green: 79/255, blue: 78/255, alpha: 1)
            myPickerView.reloadAllComponents()
        }else{
            myButton.backgroundColor = UIColor(red: 119/255, green: 124/255, blue: 168/255, alpha: 1)
            userLabel.isHidden = true
                moneLabel.isHidden = true
                noteLabel.isHidden = true
                userText.isHidden = false
                //moneyText.isHidden = false
                noteText.isHidden = false
                userText.text = userLabel.text
                //moneyText.text = moneLabel.text
                myPickerView.isHidden = false
                noteText.text = noteLabel.text
                userView.backgroundColor = UIColor(red: 119/255, green: 124/255, blue: 168/255, alpha: 1)
            moneyView.backgroundColor = UIColor(red: 119/255, green: 124/255, blue: 168/255, alpha: 1)
            noteView.backgroundColor = UIColor(red: 119/255, green: 124/255, blue: 168/255, alpha: 1)
            myPickerView.reloadAllComponents()
        }
    }
    @IBOutlet weak var isSwitch: UISwitch!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func returnButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myButton.layer.cornerRadius = myButton.frame.size.width / 2
        helloButton.layer.cornerRadius = helloButton.frame.size.width / 2
        usersView.layer.cornerRadius = 4.0
        usersView.layer.borderWidth = 1.0
        usersView.layer.borderColor = UIColor.clear.cgColor
        usersView.layer.masksToBounds = false
        usersView.layer.shadowColor = UIColor.gray.cgColor
        usersView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        usersView.layer.shadowRadius = 4.0
        usersView.layer.shadowOpacity = 1.0
        usersView.layer.masksToBounds = false
        //userView.layer.shadowPath = UIBezierPath(roundedRect:userView.bounds, cornerRadius: userView.layer.cornerRadius).cgPath
        
        notesView.layer.cornerRadius = 4.0
        notesView.layer.borderWidth = 1.0
        notesView.layer.borderColor = UIColor.clear.cgColor
        notesView.layer.masksToBounds = false
        notesView.layer.shadowColor = UIColor.gray.cgColor
        notesView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        notesView.layer.shadowRadius = 4.0
        notesView.layer.shadowOpacity = 1.0
        notesView.layer.masksToBounds = false
        //noteView.layer.shadowPath = UIBezierPath(roundedRect:noteView.bounds, cornerRadius: noteView.layer.cornerRadius).cgPath
        
        moneysView.layer.cornerRadius = 4.0
        moneysView.layer.borderWidth = 1.0
        moneysView.layer.borderColor = UIColor.clear.cgColor
        moneysView.layer.masksToBounds = false
        moneysView.layer.shadowColor = UIColor.gray.cgColor
        moneysView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        moneysView.layer.shadowRadius = 4.0
        moneysView.layer.shadowOpacity = 1.0
        moneysView.layer.masksToBounds = false
        //moneyView.layer.shadowPath = UIBezierPath(roundedRect:moneyView.bounds, cornerRadius: moneyView.layer.cornerRadius).cgPath
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let date = date{
            dateLabel.text = date
        }
    if let row = row{
        if let diary = diary{
            if let totalDiary = diary.totalUser?.allObjects as? [TotalUser]{
                print(totalDiary)
            userLabel.text = totalDiary[row].monay
            moneLabel.text = totalDiary[row].user
            noteLabel.text = totalDiary[row].note
                myImgae.image = UIImage(data: totalDiary[row].accImage!)
                myImgae.contentMode = .scaleToFill
                }
            }
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
