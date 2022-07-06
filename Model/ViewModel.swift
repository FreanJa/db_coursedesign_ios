//
//  ViewModel.swift
//  testMysql
//
//  Created by FreanJa L on 2022/5/19.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var items = [PostModel]()
    @Published var account = [AccountModel]()
    @Published var info = [ResponseModel]()
    
    @Published var post = [Post]()
    @Published var comments = [Comment]()
    @Published var commentCount = 0
    
    // Tab Bar
    @Published var showTab: Bool = true
    
    // Navigation Bar
    @Published var showNav: Bool = true
    
    // Modal
    @Published var selectedModel: Modal = .signIn
    @Published var showModal: Bool = false
    @Published var dismissModal: Bool = false
    
    let prefixUrl = "http://127.0.0.1:5000"
    
    init() {
//        fetchPopular()
        fetchPosts()
    }
    
    // MARK: - Retrieve data
//    func fetchPosts() {
//        guard let url = URL(string: "\(prefixUrl)") else {
//            print("Not found url")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, res, error in
//            if error != nil {
//                print("ERROR: ", error?.localizedDescription ?? "")
//                return
//            }
//
//            do {
//                if let data = data {
//                    print(data)
//                    let result = try JSONDecoder().decode(DataModel.self, from: data)
//                    DispatchQueue.main.async {
//                        self.items = result.data
//                        print(self.items)
//                    }
//                }
//                else {
//                    print("No Data!")
//                }
//            } catch let JsonError {
//                print("fetch json error:", JsonError.localizedDescription)
//            }
//        }.resume()
//    }
    
    // MARK: - Create data
//    func createPost(parameters: [String: Any]) {
//        guard let url = URL(string: "\(prefixUrl)/create") else {
//            print("Not found url")
//            return
//        }
//
//        let data = try! JSONSerialization.data(withJSONObject: parameters)
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = data
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        URLSession.shared.dataTask(with: request) { data, res, error in
//            if error != nil {
//                print("ERROR: ", error?.localizedDescription ?? "")
//                return
//            }
//
//            do {
//                if let data = data {
//                    print(data)
//                    let result = try JSONDecoder().decode(LoginModel.self, from: data)
//                    DispatchQueue.main.async {
////                        self.items = result.data
////                        print(self.items)
//                        print(result)
//                    }
//                }
//                else {
//                    print("No Data!")
//                }
//            } catch let JsonError {
//                print("fetch json error:", JsonError.localizedDescription)
//            }
//        }.resume()
//    }
    
    // MARK: - Update data
//    func updatePost(parameters: [String: Any]) {
//        guard let url = URL(string: "\(prefixUrl)/updatePost") else {
//            print("Not found url")
//            return
//        }
//
//        let data = try! JSONSerialization.data(withJSONObject: parameters)
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT"
//        request.httpBody = data
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        URLSession.shared.dataTask(with: request) { data, res, error in
//            if error != nil {
//                print("ERROR: ", error?.localizedDescription ?? "")
//                return
//            }
//
//            do {
//                if let data = data {
//                    let result = try JSONDecoder().decode(DataModel.self, from: data)
//                    DispatchQueue.main.async {
////                        self.items = result.data
//                        print(result)
//                    }
//                }
//                else {
//                    print("No Data!")
//                }
//            } catch let JsonError {
//                print("fetch json error:", JsonError.localizedDescription)
//            }
//        }.resume()
//    }
    
    // MARK: - Delete data
//    func deletePost(parameters: [String: Any]) {
//        guard let url = URL(string: "\(prefixUrl)/deletePost") else {
//            print("Not found url")
//            return
//        }
//
//        let data = try! JSONSerialization.data(withJSONObject: parameters)
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "DELETE"
//        request.httpBody = data
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        URLSession.shared.dataTask(with: request) { data, res, error in
//            if error != nil {
//                print("ERROR: ", error?.localizedDescription ?? "")
//                return
//            }
//
//            do {
//                if let data = data {
//                    let result = try JSONDecoder().decode(DataModel.self, from: data)
//                    DispatchQueue.main.async {
////                        self.items = result.data
//                        print(result)
//                    }
//                }
//                else {
//                    print("No Data!")
//                }
//            } catch let JsonError {
//                print("fetch json error:", JsonError.localizedDescription)
//            }
//        }.resume()
//    }
    
    
    
    // MARK: - Account Operation
    // state:   account(username/emailAdd):   password:
    func accountOpr(parameters: [String: Any], completion: ((Bool) -> Void)? = nil) {
        guard let url = URL(string: "\(prefixUrl)/user") else {
            print("Not found url")
            return
        }
        
        print(parameters)
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, res, error in
            if error != nil {
                print("ERROR: ", error?.localizedDescription ?? "")
                completion?(false)
                return
            }
            
            do {
                if let data = data {
                    print(data)
                    let result = try JSONDecoder().decode(LoginModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                        self.account = result.account
                        self.info = result.info
                        completion?(true)
                    }
                    
                }
                else {
                    completion?(false)
                    print("No Data!")
                }
            } catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
            }
        }
        
        task.resume()
        
    }
    
    
    // MARK: - FETCH POPULAR SECTION INFO
    func fetchPopular() {

    }
    
    // MARK: - FETCH POSTS SECTION INFO
    func fetchPosts() {
        guard let url = URL(string: "\(prefixUrl)/fetchPosts") else {
            print("Not found url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, res, error in
            if error != nil {
                print("ERROR: ", error?.localizedDescription ?? "")
                return
            }

            do {
                if let data = data {

                    let result = try JSONDecoder().decode(PostModel.self, from: data)
                    DispatchQueue.main.async {
                        self.post = result.postList
                        self.info = result.info
                        print(self.post)
                    }
                }
                else {
                    print("No Data!")
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }.resume()
    }
    
    // MARK: - FETCH POST's COMMENTS
    func fetchComments(parameters: [String: Any], completion: ((Bool) -> Void)? = nil) {
        guard let url = URL(string: "\(prefixUrl)/fetchComments") else {
            print("Not found url")
            return
        }
        
        print(parameters)
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, res, error in
            if error != nil {
                print("ERROR: ", error?.localizedDescription ?? "")
                completion?(false)
                return
            }
            
            do {
                if let data = data {
                    print(data)
                    let result = try JSONDecoder().decode(CommentModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                        self.comments = result.comments
                        self.commentCount = result.count
                        self.info = result.info
                        completion?(true)
                    }
                    
                }
                else {
                    completion?(false)
                    print("No Comment!")
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
        task.resume()
    }
    
    // MARK: - ADD A COMMENT
    func createComment(parameters: [String: Any], completion: ((Bool) -> Void)? = nil) {
        guard let url = URL(string: "\(prefixUrl)/createComment") else {
            print("Not found url")
            return
        }
        
        print(parameters)
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, res, error in
            if error != nil {
                print("ERROR: ", error?.localizedDescription ?? "")
                completion?(false)
                return
            }
            
            do {
                if let data = data {
                    print(data)
                    let result = try JSONDecoder().decode(CommentModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                        self.comments = result.comments
                        self.commentCount = result.count
                        self.info = result.info
                        completion?(true)
                    }
                    
                }
                else {
                    completion?(false)
                    print("No Comment!")
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
        task.resume()
    }
    
    // MARK: - Modify ACCOUNT
    func modifyAccount(parameters: [String: Any], completion: ((Bool) -> Void)? = nil) {
        guard let url = URL(string: "\(prefixUrl)/modifyAccount") else {
            print("Not found url")
            return
        }
        
        print(parameters)
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, res, error in
            if error != nil {
                print("ERROR: ", error?.localizedDescription ?? "")
                completion?(false)
                return
            }
            
            do {
                if let data = data {
                    print(data)
                    let result = try JSONDecoder().decode(ResponseModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
//                        self.info = result.
                        completion?(true)
                    }
                    
                }
                else {
                    completion?(false)
                    print("No Data!")
                }
            } catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
            }
        }
        
        task.resume()
    }
}

enum Modal: String {
    case signUp
    case signIn
}

