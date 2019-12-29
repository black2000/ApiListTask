//
//  UserDataModel.swift
//  Task
//
//  Created by tarek on 12/29/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import Foundation
import RealmSwift

class UserDataModel : Object {
    @objc dynamic var id = 0
    @objc dynamic var title : String?
    @objc dynamic var body : String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
