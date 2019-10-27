//
//  ViewController.swift
//  NoteBook
//
//  Created by 袁玉灵 on 2019/10/26.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//

import UIKit

class ViewController: UIViewController,HomeButtonDelegate {
    var homeView:HomeView?
    var dataArray:Array<String>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "备忘录"
        self.edgesForExtendedLayout = UIRectEdge()
        //dataArray = DataManager.getGroupData()
        self.installUI()
        
        
    }
    func installUI(){
        homeView = HomeView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-64))
        self.view.addSubview(homeView!)
        homeView?.homeButtonDelegate = self
        homeView?.dataArray = dataArray
        homeView?.updateLayout()
        installNavigationItem()
    }
    func installNavigationItem(){
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGroup))
        self.navigationItem.rightBarButtonItem = barButtonItem
        
    }
    @objc func addGroup(){
        let alertController = UIAlertController(title: "添加记事分组", message: "添加的分组名不能与已有的分组重复或为空", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "请输入记事分组名称"
        }
        let alertItem = UIAlertAction(title: "取消", style: .cancel) { (UIAlertAction) in
            return
        }
        let alertItemAdd = UIAlertAction(title: "确定", style: .default) { (UIAlertAction)-> Void in
            var exist = false
            self.dataArray?.forEach({ (element) in
                if element == alertController.textFields?.first!.text || alertController.textFields?.first!.text?.characters.count == 0
                {
                    exist = true
                }
                
            })
            if exist {
                return
            }
            self.dataArray?.append(alertController.textFields!.first!.text!)
            self.homeView?.dataArray = self.dataArray
            self.homeView?.updateLayout()
            DataManager.saveGroup(name: alertController.textFields!.first!.text!)
        }
        alertController.addAction(alertItem)
        alertController.addAction(alertItemAdd)
        self.present(alertController, animated: true, completion: nil)
    }
    func homeButtonClick(title: String) {
        let controller = NoteListTableViewController()
        controller.name = title
        self.navigationController?.pushViewController(controller, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataArray = DataManager.getGroupData()
        self.homeView?.dataArray = dataArray
        self.homeView?.updateLayout()
    }
    

}

