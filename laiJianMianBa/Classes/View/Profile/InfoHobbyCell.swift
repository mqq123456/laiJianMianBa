//
//  InfoHobbyCell.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/28.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit

class InfoHobbyCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var tagView: ZWTagListView!
    @IBOutlet weak var placeHorder: UILabel!
    
    var height: CGFloat!
    
    
    public var titles: [ZWTagModel] = NSArray() as! [ZWTagModel] {
        didSet {
            if titles.count == 0 {
                self.placeHorder.isHidden = false
                self.tagView.isHidden = true
                height = 50
            }else{
                self.tagView.isHidden = false
                self.placeHorder.isHidden = true
                self.tagView.setTagWithTagArray(titles)
                height = self.tagView.size.height + 10
            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        height = 50
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
