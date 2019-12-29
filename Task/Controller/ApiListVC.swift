//
//  ViewController.swift
//  Task
//
//  Created by tarek on 12/29/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit
import Alamofire
import Realm
import RealmSwift
import SwipeCellKit

class ApiListVC: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!
    var userDataArray : Results<UserDataModel>?
    
    lazy var refresher : UIRefreshControl = {
       
        let refresher = UIRefreshControl()
        refresher.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        return refresher
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refresher
        
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        loadUserData(url: API_URL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.userDataArray = Database.instance.loadUserData()
        self.tableView.reloadData()
    }
    
    
    private func loadUserData(url : String) {
        
        Api.instance.loadApiList(url: url) { (error) in
            if error != nil {
                print(error!)
            }else {
                self.userDataArray = Database.instance.loadUserData()
                self.tableView.reloadData()
            }
        }
        
        
    }
    
   
    
    @objc private func refreshData() {
        Database.instance.deleteAllDataFromDatabase()
        loadUserData(url: API_URL)
        refresher.endRefreshing()
    }
    
    
  
    
    
}


extension ApiListVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell {
            
            let user = userDataArray![indexPath.row]
            cell.configureCell(user: user)
            cell.delegate = self
            return cell
        }else {
            return UITableViewCell()
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toNewUserForEdit" {
            
            if let newUserVC = segue.destination as? NewUserVC ,
               let selectedUser = sender as? UserDataModel{
                
                newUserVC.isUpdating = true
                newUserVC.selectedUser = selectedUser
               
            }
        }
        
    }
    
}


extension ApiListVC : SwipeTableViewCellDelegate {
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            let userData = self.userDataArray![indexPath.row]
            Database.instance.deleteDataInTheDatabase(user: userData)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let editAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            let userData = self.userDataArray![indexPath.row]
            
            self.performSegue(withIdentifier: "toNewUserForEdit", sender: userData)
            
        }
        
        
        // customize the action appearance
        deleteAction.title = "Delete"
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.0734678899, blue: 0.1781892123, alpha: 1)
        editAction.title = "Edit"
        editAction.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        
        return [deleteAction , editAction]
    }
    
}
