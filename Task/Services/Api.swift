//
//  Api.swift
//  Task
//
//  Created by tarek on 12/29/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import Foundation
import Alamofire


class Api {
    
    static let instance = Api()
    
    func loadApiList(url : String , completion : @escaping (_ error : Error?) -> ()) {
        
        Alamofire.request(url).responseJSON { (data) in
            
            
            if data.result.error != nil {
                completion(data.result.error!)
            }else {
                let userArray = data.result.value as? [[String : Any]]
                
                for user in userArray! {
                    
                    let userData = UserDataModel()
                    
                    userData.id = user["id"] as? Int ?? 0
                    userData.title = user["title"] as? String ?? "no title"
                    userData.body = user["body"] as? String ?? "no body"
                    
                    Database.instance.saveUserDataInDataBase(user: userData)
                    
                }
                completion(nil)
            }
            
        }
        
    }
    

}
