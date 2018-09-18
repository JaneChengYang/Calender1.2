//
//  Service.swift
//  Calender
//
//  Created by Simon on 2018/8/29.
//  Copyright © 2018年 Simon. All rights reserved.
//

import Foundation
import Firebase

final class PostService{
    static let shared:PostService = PostService()
    private init(){}
    let BASE_DB_REF: DatabaseReference = Database.database().reference()
    let POST_DB_REF: DatabaseReference = Database.database().reference().child("posts")
    let PHOTO_STORAGE_REF: StorageReference = Storage.storage().reference().child("photos")
//    func uploadImage(image:UIImage,completionHandler: @escaping () -> Void){
//        let postDatabaseRef = POST_DB_REF.childByAutoId()
//        // 使用唯一個 key 作為圖片名稱並準備 Storage 參照
//        let imageStorageRef = PHOTO_STORAGE_REF.child("\(postDatabaseRef.key).jpg")
//        // 調整圖片大小
//        let scaledImage = image.scale(newWidth: 640.0)
//        guard let imageData = UIImageJPEGRepresentation(scaledImage, 0.9) else {return}
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpg"
//        // 準備上傳任務
//        let uploadTask = imageStorageRef.putData(imageData, metadata: metadata)
//        // 觀察上傳狀態
//        uploadTask.observe(.success) { (snapshot) in
//            guard let displayName = Auth.auth().currentUser?.displayName else {return}
//            // 在資料庫中加上一個參照
//            let timestamp = Int(NSDate().timeIntervalSince1970 * 1000)
//            // 在資料庫加上一個參照
//            let url = imageStorageRef.downloadURL(completion: { (url, error) in
//                if let error = error{
//                    print(error.localizedDescription)
//                }
//                if let url = url{
//                    let post:[String:Any] = [Post.PostInfoKey.imageFileURL:imageFileURL,Post.PostInfoKey.user:user,Post.PostInfoKey.diary:diary,Post.PostInfoKey.diaryText:diaryText,Post.PostInfoKey.mood:mood,Post.PostInfoKey.weather:weather,Post.PostInfoKey.timestamp:timestamp]
//                    postDatabaseRef.setValue(post)
//                }
//            })
//            completionHandler()
//        }
//        uploadTask.observe(.progress) { (snapshot) in
//            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
//            print("Uploading... \(percentComplete)% complete")
//        }
//        uploadTask.observe(.failure) { (snapshot) in
//            if let error = snapshot.error {
//                print(error.localizedDescription)
//            }
//        }
//    }
}
