//
//  EmailViewController.swift
//  Calender
//
//  Created by Simon on 2018/9/9.
//  Copyright © 2018年 Simon. All rights reserved.
//

import UIKit
import Firebase

class EmailViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var imageURL = ""
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil{
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Main"){
                UIApplication.shared.keyWindow?.rootViewController = viewController
                // self.dismiss(animated: true, completion: nil)
            }
        }
    }
    @IBAction func resetPassword(sender: UIButton) {
        // 輸入驗證
        guard let emailAddress = signEmailText.text,
            emailAddress != "" else {
                let alertController = UIAlertController(title: "錯誤", message: "請提供密碼重置的電子郵件地址", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                return
        }
        // 傳送密碼重設的 email
            Auth.auth().sendPasswordReset(withEmail: emailAddress, completion: { (error) in
                let title = (error == nil) ? "密碼重置後續" : "密碼重置錯誤"
                let message = (error == nil) ? "我們剛給您發送了密碼重置電子郵件。 請檢查您的收件箱並按照說明重置密碼。" : error?.localizedDescription
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                    if error == nil {
                        // 解除鍵盤
                        self.view.endEditing(true)
                        // 返回登入畫面
                        if let navController = self.navigationController {
                            navController.popViewController(animated: true)
                        }
                    }
                })
                alertController.addAction(okayAction)
                
                self.present(alertController, animated: true, completion: nil)
            })
    }
    @IBAction func signSegmented(_ sender: UISegmentedControl) {
        if mySegmented.selectedSegmentIndex == 0{
            myView.isHidden = false
            signView.isHidden = true
            resetButton.isHidden = true
            myButton.setImage(UIImage(named: "4"), for: .normal)
        }else{
            myView.isHidden = true
            signView.isHidden = false
            resetButton.isHidden = false
            myButton.setImage(UIImage(named: "39"), for: .normal)
        }
    }
    @IBAction func sign(_ sender: UIButton) {
        if mySegmented.selectedSegmentIndex == 0{
            guard let email = emailText.text, email != "", let password = password.text, password != "", let name = nameTextField.text, name != "" else{
               let alertController = UIAlertController(title: "註冊錯誤", message: "請確保提供您的姓名，電子郵件地址和密碼以完成註冊", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alertController, animated: true, completion: nil)
                return
            }
            let postDatabaseRef = Database.database().reference().child("user").childByAutoId()
            let imageStorageRef = Storage.storage().reference().child("user").child("\(postDatabaseRef.key).jpg")
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    let alertController = UIAlertController(title: "註冊錯誤", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    print(error.localizedDescription)
                    return
                }
                if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest(){
                    changeRequest.displayName = name
                    changeRequest.commitChanges(completion: { (error) in
                        if let error = error{
                        print("無法更改顯示名稱: \(error.localizedDescription)")
                        }
                    })
                }
                let scaledImage = self.myButton.imageView?.image?.scale(newWidth: 640.0)
                guard let imageData = UIImageJPEGRepresentation(scaledImage!, 0.9) else {
                    return
                }
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpg"
                let uploadTask = imageStorageRef.putData(imageData, metadata: metadata)
                print("喔喔喔喔喔")
                uploadTask.observe(.success) { (snapshot) in
                    // 在資料庫加上一個參照
                    let url = imageStorageRef.downloadURL(completion: { (urls, error) in
                        self.imageURL = (urls?.absoluteString)!
                        if let error = error{
                            print(error.localizedDescription)
                        }
                        if let url = urls{
                            let post:[String:Any] = ["imageFileURL":url.absoluteString,"name":name,"email":email,"password":password]
                            postDatabaseRef.setValue(post)
                            print("成功")
                        }
                    })
                }
                uploadTask.observe(.progress) { (snapshot) in
                    let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
                    print("Uploading \(postDatabaseRef.key).jpg... \(percentComplete)% complete")
                }
                uploadTask.observe(.failure) { (snapshot) in
                    
                    if let error = snapshot.error {
                        print("錯誤\(error.localizedDescription)")
                    }
                }
                self.view.endEditing(true)
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Main"){
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }else{
            guard let email = signEmailText.text, email != "", let password = signPasswordText.text, password != "" else{
               let alertController = UIAlertController(title: "登入錯誤", message: "帳號或密碼輸入錯誤", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alertController, animated: true, completion: nil)
                return
            }
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let error = error{
                    let alertController = UIAlertController(title: "登入錯誤", message: "帳號或密碼輸入錯誤", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                self.view.endEditing(true)
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Main"){
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        }
    }
    @IBAction func imageButton(_ sender: UIButton) {
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

    @IBAction func mtTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var mySegmented: UISegmentedControl!
    @IBOutlet weak var signPasswordText: UITextField!
    @IBOutlet weak var signEmailText: UITextField!
    @IBOutlet weak var signView: UIView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mySegmented.layer.cornerRadius = 5
        goButton.layer.cornerRadius = 5
        myView.layer.cornerRadius = 5
        nameTextField.layer.cornerRadius = 5
        emailText.layer.cornerRadius = 5
        password.layer.cornerRadius = 5
        signView.layer.cornerRadius = 5
        signEmailText.layer.cornerRadius = 5
        signPasswordText.layer.cornerRadius = 5
        resetButton.layer.cornerRadius = 5
        //隱藏密碼
        password.isSecureTextEntry = true
        signPasswordText.isSecureTextEntry = true
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            myButton.setImage(image, for: .normal)
            //myButton.image = image
            myButton.contentMode = .scaleToFill
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ViewController{
            controller.imageURL = self.imageURL
            }
        }
    }


