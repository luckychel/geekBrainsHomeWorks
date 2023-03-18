//
//  FireBaseService.swift
//  authSwiftKukobaProject
//
//  Created by Александр Кукоба on 30.10.2022.
//

import Foundation
import Firebase

class FireBaseService {
    
    static let shared = FireBaseService()
    
    private init() {}
    
    //MARK: Регистрация нового пользователя
    func regNewUser(email: String, password: String, completion: @escaping (FireBaseResponce)->()) {
        
        Auth.auth().createUser(withEmail: email, password: password) {res, err in
            var response: FireBaseResponce! = FireBaseResponce()
            if err == nil {
                if let res = res {
                    res.user.sendEmailVerification()
                    self.saveNewUser(user: res.user, password: password) { res in
                        if !res {
                            response.isSuccess = false
                            response.result = FireBaseErrors.unableToSaveUser.rawValue
                            completion(response)
                        }
                    }
                }
            }
            else {
                response.isSuccess = false
                let err = err as? NSError
                switch err!.code {
                    case AuthErrorCode.emailAlreadyInUse.rawValue:
                        response.result = FireBaseErrors.emailAlreadyInUse.rawValue
                        completion(response)
                    case AuthErrorCode.weakPassword.rawValue:
                        response.result = FireBaseErrors.weakPassword.rawValue
                        completion(response)
                    default:
                        response.result = FireBaseErrors.unexpectedError.rawValue
                        completion(response)
                }
            }
        }
    }
    
    //MARK: Сохранения пользователя в FileStore
    func saveNewUser(user: User, password: String, completion: @escaping(Bool)->()){
        let userData: [String: Any] = [
            "email": user.email as Any,
            "password": password,
            "avatar": "",
            "regDate": Date.now,
            "isVerify": false
        ]
        
        Firestore.firestore().collection("users")
            .document(user.uid)
            .setData(userData) { err in
                if err == nil {
                    completion(true)
                }
                else
                {
                    completion(false)
                }
            }
    }
    
    //MARK: Регистрация нового пользователя
    func signUser(email: String, password: String, completion: @escaping (FireBaseResponce)->()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { res, err in
            var response: FireBaseResponce! = FireBaseResponce()
            if err == nil {
                if let res = res {
                    if (res.user.isEmailVerified) {
                        completion(response)
                    }
                    else {
                        response.isSuccess = false
                        response.result = FireBaseErrors.userIsNotVerified.rawValue
                        completion(response)
                    }
                }
            }
            else {
                response.isSuccess = false
                let err = err as? NSError
                switch err!.code {
                    case AuthErrorCode.userNotFound.rawValue:
                        response.result = FireBaseErrors.userNotFound.rawValue
                        completion(response)
                    case AuthErrorCode.invalidEmail.rawValue:
                        response.result = FireBaseErrors.emailBadFormat.rawValue
                        completion(response)
                    case AuthErrorCode.wrongPassword.rawValue:
                        response.result = FireBaseErrors.passwordIsIncorrect.rawValue
                        completion(response)
                    default:
                        response.result = FireBaseErrors.unexpectedError.rawValue
                        completion(response)
                }
            }
        }
    }
    
    //MARK: Добавление заметки пользователя
    func addUserPost(uid: String, title: String, description: String, completion: @escaping(Bool)->()) {
        let postData: [String: Any] = [
            "title":  title,
            "description": description,
            "uid": uid,
        ]
        
        Firestore.firestore().collection("posts")
            .document(uid)
            .collection("userposts")
            .document(UUID().uuidString)
            .setData(postData) { err in
                if err == nil {
                    completion(true)
                }
                else
                {
                    completion(false)
                }
            }
    }
    
    //MARK: Получение все заметок пользователя
    func getUserPosts(uid: String, completion: @escaping([Post])->()) {
        var posts: [Post] = []
        Firestore.firestore().collection("posts")
            //.whereField("capital", isEqualTo: true)
            .addSnapshotListener({ data, err in
                if err == nil {
                    if let docs = data?.documents {
                        for doc in docs {
                            posts.append(Post(title: doc["title"] as! String, description: doc["description"] as! String))
                        }
                    }
                }
                else {
                    completion([])
                }
            })
    }
}

//MARK: Возвращаемая структура ответа из FireBase
struct FireBaseResponce {
    var result: String?
    var isSuccess: Bool = true
    
}
//MARK: Ошибки регистрации в FireBase
enum FireBaseErrors: String {
    case emailAlreadyInUse = "Пользователь с таким Email уже зарегистрирован!"
    case weakPassword = "Пароль должен быть не менее 6 символов!"
    case unableToSaveUser = "Не удалось сохранить пользователя в базу данных!"
    case userIsNotVerified = "Email не верифицирован. Проверьте почту и подтвердите ваш Email!"
    case emailBadFormat = "Email адрес имеет не подходящий формат!"
    case passwordIsIncorrect = "Пароль не верный!"
    case userNotFound = "Пользователь не найден!"
    case incorrentLoginOrPassowrd = "Не правильный логин или пароль пользователя!"
    case unexpectedError = "Произошла непредвиденная ошибка, обратитесь к разработчику!"
}
