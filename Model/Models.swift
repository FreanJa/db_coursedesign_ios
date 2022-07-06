//
//  Models.swift
//  testMysql
//
//  Created by FreanJa L on 2022/5/19.
//

import Foundation
import SwiftUI

//struct DataModel: Decodable {
//    let data: [PostModel]
//    let error: Bool
//    let message: String
//}
//
//struct PostModel: Decodable {
//    let name: String
//    let password: String
//    let phone: Int
//}


// Login Opr
struct LoginModel: Decodable {
    let info: [ResponseModel]
    let account: [AccountModel]
}

struct AccountModel: Decodable {
    let email: String
    let password: String
    let photo: String
    let userName: String
    let userId: Int
}

struct ResponseModel: Decodable {
    let desc: String
    let error: Bool
}

// Post Opr
struct PostModel: Decodable {
    let info: [ResponseModel]
    let count: Int
    let postList: [Post]
}

struct Post: Decodable {
    let postId: Int
    let text: String
    let subTitle: String
    let time: String
    let title: String
    let writerId: Int
    let writerName: String
    let writerPhoto: String
    let imgCount: Int
    let comments: Int
}

var posts = [
    Post(postId: 3, text: "sdhadoaufashfpafhsapfhaspfsaf", subTitle: "让游戏成为友谊的桥梁。", time: "2022-06-09 10:05:00", title: "电子游戏，疫情时代学生们的新社交工具", writerId: 13, writerName: "柯泽林雾", writerPhoto: "42", imgCount: 6, comments: 8),
    Post(postId: 8, text: "粉色小恶魔传：星之卡比三十年", subTitle: "让游戏成为友谊的桥梁。", time: "2022-06-09 10:05:00", title: "粉色小恶魔传：星之卡比三十年", writerId: 13, writerName: "80后写稿佬", writerPhoto: "82", imgCount: 9, comments: 5),
]

// Comment Opr
struct CommentModel: Decodable {
    let info: [ResponseModel]
    let count: Int
    let comments: [Comment]
}

struct Comment: Decodable {
    let commentsId: Int
    let postId: Int
    let userId: Int
    let time: String
    let text: String
    let userName: String
    let userPhoto: String
}

struct sendComment: Decodable {
    
}


struct TypeTag: Identifiable {
    let id: Int
    let tag: String
    var checked: Bool
}

var staticTags = [
//    TypeTag(id: 0, tag: "All", checked: true),
    TypeTag(id: 3, tag: "Role Playing Games", checked: true),
    TypeTag(id: 1, tag: "Sport", checked: false),
    TypeTag(id: 2, tag: "Action", checked: false),
    TypeTag(id: 4, tag: "Shooter", checked: false),
    TypeTag(id: 5, tag: "Adventure", checked: false),
]

struct GameModel: Identifiable {
    let id: Int
}


// comment
struct CommentModelTmp: Identifiable {
    let id = UUID()
    let userName: String
    let userPhoto: String
    let time: String
    let comment: String
}

var Comments = [
    CommentModelTmp(userName: "ColaV", userPhoto: "1", time: "2022-06-02 15:44:00", comment: "这速度 天堂一年 人间一天"),
    CommentModelTmp(userName: "肌不可失", userPhoto: "8", time: "2022-06-05 19:36:24", comment: "这游戏真得好好感谢一堆人免费给它做宣传"),
    CommentModelTmp(userName: "高大威猛俊男", userPhoto: "14", time: "2022-06-03 06:34:44", comment: "这作有右摇杆控制视角的高新技术吗"),
    CommentModelTmp(userName: "汪酱", userPhoto: "53", time: "2022-06-02 17:13:06", comment: "我可以一边炒女博士一边被男博士炒"),
    CommentModelTmp(userName: "九十玖", userPhoto: "62", time: "2022-06-02 16:49:51", comment: "昨天一整天我心情都巨差，但你们一定想象不到我追着FJ和柯泽按头强迫他们品鉴新神兽涩图的时候笑得有多混沌放肆。"),
    CommentModelTmp(userName: "梵蒂冈大教皇", userPhoto: "59", time: "2022-06-07 04:21:24", comment: "意大利人 披萨 菠萝 .jpg"),
    CommentModelTmp(userName: "iostream", userPhoto: "92", time: "2022-06-05 22:53:00", comment: "p站sandwich或者train视频看多了吧？"),
    CommentModelTmp(userName: "Zack1stSoldier", userPhoto: "51", time: "2022-06-02 23:55:53", comment: "位更寄"),
    CommentModelTmp(userName: "黄源大酱", userPhoto: "41", time: "2022-06-02 23:37:25", comment: "明天端午，准备好艾草了吗"),
    CommentModelTmp(userName: "老麻雀", userPhoto: "59", time: "2022-06-06 16:51:21", comment: "萌新弱弱的问一下和之前两部有区别么？"),
]







