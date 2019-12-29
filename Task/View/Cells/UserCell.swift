//
//  UserCell.swift
//  Task
//
//  Created by tarek on 12/29/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit
import SwipeCellKit

class UserCell: SwipeTableViewCell {
    
    @IBOutlet weak var IdLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!

    override func awakeFromNib() {
        self.layer.borderWidth = 10
        self.layer.cornerRadius = 10
        self.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    
    func configureCell(user : UserDataModel) {
        IdLbl.text = "Id : \(user.id)"
        titleLbl.text = "Title : \(user.title!)"
        descriptionLbl.text = "Description : \(user.body!)"
    }
    
}
