//
//  HomeView.swift
//  NoteBook
//
//  Created by 袁玉灵 on 2019/10/26.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//

import UIKit
protocol HomeButtonDelegate {
    func homeButtonClick(title:String)
}

class HomeView: UIScrollView {
var homeButtonDelegate:HomeButtonDelegate?
let interitemSpacing  = 15
let lineSpacing = 25
    var dataArray:Array<String>?
    var itemArray:Array<UIButton> = Array<UIButton>()
    
    func updateLayout(){
        
        let itemWidth = (self.frame.size.width-CGFloat(4*interitemSpacing))/3
        
        let itemHeight = itemWidth/3*4
        
        itemArray.forEach { (element) in
            element.removeFromSuperview()
        }
        itemArray.removeAll()
        
        if dataArray != nil && dataArray!.count>0{
            for index in 0..<dataArray!.count{
                let btn = UIButton(type:.system)
                btn.setTitle(dataArray![index], for: .normal)
                btn.frame = CGRect(x: CGFloat(interitemSpacing)+CGFloat(index%3)*(itemWidth+CGFloat(interitemSpacing)), y: CGFloat(lineSpacing) + CGFloat(index/3) * (itemHeight+CGFloat(lineSpacing)), width: itemWidth, height: itemHeight)
                btn.backgroundColor = UIColor(red: 1, green: 242/255.0, blue: 216/255.0, alpha: 1)
                btn.layer.masksToBounds = true
                btn.layer.cornerRadius = 15
                btn.setTitleColor(UIColor.gray, for: .normal)
                btn.tag = index
                btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
                self.addSubview(btn)
                itemArray.append(btn)
                self.contentSize = CGSize(width: 0, height: itemArray.last!.frame.origin.y+itemArray.last!.frame.size.height+CGFloat(lineSpacing))
                
            }
            
        }
    
    }
    @objc func btnClick(btn:UIButton){
        if self.homeButtonDelegate != nil {
            self.homeButtonDelegate?.homeButtonClick(title: dataArray![btn.tag])
        }
    }

}
