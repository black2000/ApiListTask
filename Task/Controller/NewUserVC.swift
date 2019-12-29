//
//  NewItemVC.swift
//  Task
//
//  Created by tarek on 12/29/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit

class NewUserVC: UIViewController {

    
    @IBOutlet weak var editBtn: UIBarButtonItem!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    
    var selectedUser : UserDataModel?
    var isUpdating : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }
    
    private func configureViews() {
        
       if  isUpdating {
        
            editBtn.title = "Edit"
            editBtn.isEnabled = true
            addBtn.title = ""
            addBtn.isEnabled = false
        
            if let user = selectedUser {
                titleTextField.text = user.title
                descriptionTextField.text = user.body
            }
       }
       else {
            editBtn.title = ""
            editBtn.isEnabled = false
            addBtn.title = "Add"
            addBtn.isEnabled = true
        }
    }
    
    
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddBtnPressed(_ sender: Any) {
        
        guard  titleTextField.text != "" && descriptionTextField.text != "" else {return}
        
        
        let user = UserDataModel()
        user.title = titleTextField.text!
        user.body = descriptionTextField.text!
        Database.instance.addDataToDatabase(user: user)
        dismiss(animated: true, completion: nil)
    }
    

    
    
    @IBAction func editBtnPressed(_ sender: Any) {
        
     guard  titleTextField.text != "" && descriptionTextField.text != "" else {return}
     
        Database.instance.editDataInTheDatabase(user: selectedUser!, title: titleTextField.text!, body: descriptionTextField.text!)
        dismiss(animated: true, completion: nil)
        
    }
    
    

}
