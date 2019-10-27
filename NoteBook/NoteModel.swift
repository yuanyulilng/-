//
//  NoteModel.swift
//  NoteBook
//
//  Created by 袁玉灵 on 2019/10/26.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//

import UIKit

class NoteModel: NSObject {
    var time:String?
    var title:String?
    var body:String?
    var  group:String?
    var noteId:Int?
    func toDictionary() -> Dictionary<String,Any>{
        var dic:[String:Any] = ["time":time!,"title":title!,"body":body!,"ownGroup":group!]
        if let id = noteId{
            dic["noteId"] = id
        }
        return dic
    }
    

}
