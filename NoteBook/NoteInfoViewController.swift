//
//  NoteInfoViewController.swift
//  NoteBook
//
//  Created by 袁玉灵 on 2019/10/27.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//


import UIKit
import SnapKit

class NoteInfoViewController: UIViewController {
    var noteModel:NoteModel?
    var titleTextField:UITextField?
    var bodyTextView:UITextView?
    var group:String?
    var isNew = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge()
        self.view.backgroundColor = UIColor.white
        self.title = "记事"

        //通知中心使用失败,
        NotificationCenter.default.addObserver(self, selector: #selector(keBoardBeShow), name: Notification.Name(rawValue: "UIKeyboardWillShow"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardBehidden), name: Notification.Name(rawValue: "UIKeyboardWillHide"), object: nil)
        installUI()
        installNavigationItem()
       
        

        // Do any additional setup after loading the view.
    }
    func installNavigationItem(){
        let itemSave = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addNote))
        let itemDelete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        self.navigationItem.rightBarButtonItems = [itemSave,itemDelete]
        
    }
    @objc func addNote(){
        if isNew{
            if titleTextField?.text != nil && titleTextField!.text!.characters.count > 0  {
                noteModel = NoteModel()
                noteModel?.title = titleTextField?.text!
                noteModel?.body = bodyTextView?.text
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                noteModel?.time = dateFormatter.string(from: Date())
                noteModel?.group = group
                DataManager.addNote(note: noteModel!)
                self.navigationController!.popViewController(animated: true)
                
            }
        }else{
            if titleTextField?.text != nil && titleTextField!.text!.characters.count > 0{
                noteModel?.title = titleTextField?.text!
                noteModel?.body = bodyTextView?.text
                let dataFormatter = DateFormatter()
                dataFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                noteModel?.time = dataFormatter.string(from: Date())
                DataManager.updateNote(note: noteModel!)
                self.navigationController!.popViewController(animated: true)
                
            }
        }
       
    }
    @objc func deleteNote(){
        let alertController = UIAlertController(title: "警告", message: "您确定要删除此条记事么?", preferredStyle: .alert)
        let action = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let action2 = UIAlertAction(title: "删除", style: .destructive,handler: {(UIAlertAction) -> Void in
            if !self.isNew {
                DataManager.deleteNote(note: self.noteModel!)
                self.navigationController!.popViewController(animated: true)
            }
        })
        alertController.addAction(action)
        alertController.addAction(action2)
        self.present(alertController,animated: true,completion: nil)
        
        
        
        
    }
    // 键盘监听的这两个方法不运行
    @objc func keBoardBeShow(notification:Notification){
        let userInfo = notification.userInfo!
        let frameInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject
        let height = frameInfo.cgRectValue?.size.height
        bodyTextView?.snp.updateConstraints({ (maker) in
            maker.bottom.equalTo(-30 - height!)
        })
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyBoardBehidden(notification:Notification){
        bodyTextView?.snp.updateConstraints({ (maker) in
            maker.bottom.equalTo(-30)
        })
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        bodyTextView?.resignFirstResponder()
        titleTextField?.resignFirstResponder()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func installUI(){
      
        titleTextField = UITextField()
        self.view.addSubview(titleTextField!)
        titleTextField?.borderStyle = .none
        titleTextField?.placeholder = "请输入记事标题"
        titleTextField?.snp.makeConstraints({ (maker) in
            maker.top.equalTo(30)
            maker.left.equalTo(30)
            maker.right.equalTo(-30)
            maker.height.equalTo(30)

        })
        let line = UIView()
        self.view.addSubview(line)
        line.snp.makeConstraints { (maker) in
            maker.left.equalTo(15)
            maker.top.equalTo(titleTextField!.snp.bottom).offset(5)
            maker.right.equalTo(-15)
            maker.height.equalTo(0.5)
        }
        bodyTextView = UITextView()
        bodyTextView?.layer.borderColor = UIColor.gray.cgColor
        bodyTextView?.layer.borderWidth = 05
        self.view.addSubview(bodyTextView!)
        bodyTextView?.snp.makeConstraints({ (maker) in
            maker.left.equalTo(30)
            maker.right.equalTo(-30)
            maker.top.equalTo(line.snp.bottom).offset(10)
            maker.bottom.equalTo(-30)
        })
        
        if !isNew{
            titleTextField?.text = noteModel?.title
            bodyTextView?.text = noteModel?.body
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
