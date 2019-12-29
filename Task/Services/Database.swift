//
//  Database.swift
//  Task
//
//  Created by tarek on 12/29/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import Foundation
import RealmSwift
import Realm


class Database {
    
    static let instance = Database()
    
    func saveUserDataInDataBase(user : UserDataModel ) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(user , update: .all)
        }
    }
    
    func loadUserData() -> Results<UserDataModel> {
        let realm = try! Realm()
        let userDataArray = realm.objects(UserDataModel.self).sorted(byKeyPath: "id", ascending: true)
        
        return userDataArray
    }
    
    
    func addDataToDatabase(user : UserDataModel) {
        
        let realm = try! Realm()
        
        let lastUser = loadUserData().sorted(byKeyPath: "id", ascending: true).last
        user.id = lastUser!.id + 1
        
       try! realm.write {
           realm.add(user)
        }
    }
    
    
    func editDataInTheDatabase(user : UserDataModel ,title : String , body :String) {
        
        let realm = try! Realm()
        let user = loadUserData().filter("id = \(user.id)").first
        
        try! realm.write {
            user?.title = title
            user?.body = body
        }
    }
    
    func deleteDataInTheDatabase(user : UserDataModel) {
        let realm = try! Realm()
        let user = loadUserData().filter("id = \(user.id)").first
        
        try! realm.write {
           realm.delete(user!)
        }
        
    }
    
    
    
    
    
    func deleteAllDataFromDatabase() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    
    
    
}
