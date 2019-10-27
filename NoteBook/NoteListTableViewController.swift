//
//  NoteListTableViewController.swift
//  NoteBook
//
//  Created by 袁玉灵 on 2019/10/26.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//

import UIKit

class NoteListTableViewController: UITableViewController {
   var dataArray = Array<NoteModel>()
    var name:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name

        installNavigationItem()
        //dataArray = DataManager.getNote(group: name!)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func installNavigationItem(){
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteGroup))
        self.navigationItem.rightBarButtonItems = [addItem,deleteItem]
        
    }
    @objc func addNote(){
        let infoViewController = NoteInfoViewController()
        infoViewController.group = name!
        infoViewController.isNew = true
        self.navigationController?.pushViewController(infoViewController, animated: true)
        
    }
    @objc func deleteGroup(){
        let alerController = UIAlertController(title: "警告", message: "您确定要删除此分组下所有记事么", preferredStyle: .alert)
        let action = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let action2 = UIAlertAction(title: "删除", style: .destructive, handler:{(UIAlertAction) -> Void in
            DataManager.deleteGroup(name: self.name!)
            self.navigationController!.popViewController(animated: true)
        })
        alerController.addAction(action)
        alerController.addAction(action2)
        self.present(alerController,animated: true,completion: nil)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "noteListCellID"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
        }
        let model = dataArray[indexPath.row]
        cell?.textLabel?.text = model.title
        cell?.detailTextLabel?.text = model.time
        cell?.accessoryType = .disclosureIndicator
        return cell!

        // Configure the cell...

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dataArray = DataManager.getNote(group: name!)
        self.tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let infoViewController = NoteInfoViewController()
        infoViewController.group = name!
        infoViewController.isNew = false
        infoViewController.noteModel = dataArray[indexPath.row]
        self.navigationController?.pushViewController(infoViewController, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
