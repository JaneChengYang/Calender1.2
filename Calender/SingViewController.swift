//
//  SingViewController.swift
//  Calender
//
//  Created by Simon on 2018/8/20.
//  Copyright © 2018年 Simon. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class SingViewController: UIViewController, GIDSignInDelegate,GIDSignInUIDelegate{
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil{
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Main"){
                UIApplication.shared.keyWindow?.rootViewController = viewController
               // self.dismiss(animated: true, completion: nil)
            }
        }
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            return
        }
        guard let authentication = user.authentication else{
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error{
                print("Login error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "登入錯誤", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Main"){
                UIApplication.shared.keyWindow?.rootViewController = viewController
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    @IBAction func googleLogin(serend:UIButton){
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func facebookLogin(sender:UIButton){
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error{
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            guard let accessTask = FBSDKAccessToken.current()
                else{
                    print("Failed to get access token")
                    return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessTask.tokenString)
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error{
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "登入錯誤", message: error.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Main"){
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        if let currentUser = Auth.auth().currentUser{
           
        }
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
