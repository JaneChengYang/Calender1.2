//
//  CurrentUser.swift
//  Calender
//
//  Created by Simon on 2018/8/22.
//  Copyright © 2018年 Simon. All rights reserved.
//

import Foundation
import UIKit
struct CurrentUser {
    let uid:String
    let name:String
    let email:String
    let profileImageURL:String
    init(uid:String,dictionary:[String:Any]) {
        self.uid = uid
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
    }
}
struct Post {
    var postId:String
    var imageFileURL:String
    var user:String
    var diary:String
    var diaryText:String
    var weather:String
    var mood:String
    var timestamp:Int
    enum PostInfoKey {
        static let imageFileURL = "imageFileURL"
        static let user = "user"
        static let diary = "diary"
        static let diaryText = "diaryText"
        static let weather = "weather"
        static let mood = "mood"
        static let timestamp = "timpestamp"
    }
    init(postId:String,imageFileURL:String,user:String,diary:String,diaryText:String,weather:String,mood:String,timestamp: Int = Int(NSDate().timeIntervalSince1970 * 1000)) {
        self.postId = postId
        self.imageFileURL = imageFileURL
        self.user = user
        self.diary = diary
        self.diaryText = diaryText
        self.weather = weather
        self.mood = mood
        self.timestamp = timestamp
    }
    init?(postId:String, postInfo:[String:Any]) {
        guard let imageFileURL = postInfo[PostInfoKey.imageFileURL] as? String,let user = postInfo[PostInfoKey.user] as? String, let diary = postInfo[PostInfoKey.diary] as? String,let diaryText = postInfo[PostInfoKey.diaryText] as? String,let weather = postInfo[PostInfoKey.weather] as? String,let mood = postInfo[PostInfoKey.mood] as? String,let timestamp = postInfo[PostInfoKey.timestamp] as? Int
            else{
                return nil
        }
        self = Post(postId: postId, imageFileURL: imageFileURL, user: user, diary: diary, diaryText: diaryText, weather: weather, mood: mood, timestamp: timestamp)
    }
}

