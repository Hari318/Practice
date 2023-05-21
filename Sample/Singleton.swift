//
//  Singleton.swift
//  Sample
//
//  Created by Hari on 10/05/23.
//

import Foundation
import UIKit

//Api module
class ApiClient{
    static let shared = ApiClient()
    private init() {}
    func makeNetworkingCall(_ : URLRequest, completion:(Data)->Void){}
}


//Login module
struct User{}
extension ApiClient{
    func loadUser(completion: (User)->Void){
        makeNetworkingCall(URLRequest(url: URL(fileURLWithPath: ""))) { data in
            completion(User())
        }
    }
}
class LoginVC: UIViewController{
    var login: (((User)->Void)->Void)?
    func logInUser() {
        login? { user in
            // Move to Feed screen
        }
    }
}

class Login{
    func login(){
        let loginvc = LoginVC()
        let user = User()
        loginvc.login = { completion in
            completion(user)
        }
        loginvc.logInUser()
    }
}


//Feed module
struct Feed{}
extension ApiClient{
    func loadFeed(completion: ([Feed])->Void){
        makeNetworkingCall(URLRequest(url: URL(fileURLWithPath: ""))) { data in
            completion([Feed()])
        }
    }
}
class FeedVC: UIViewController{
    var api = ApiClient.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        api.loadFeed { feeds in
            //Update UI with new feeds
        }
        
        
    }
}
