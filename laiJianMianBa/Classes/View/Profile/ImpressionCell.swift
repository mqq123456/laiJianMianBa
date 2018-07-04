//
//  ImpressionCell.swift
//  laiJianMianBa
//
//  Created by HeQin on 17/1/7.
//  Copyright © 2017年 fundot. All rights reserved.
//

import UIKit

class ImpressionCell: UITableViewCell {
    fileprivate var tagView : ZWTagListView!
    var height: CGFloat!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupOriginal()
        height = 50
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupOriginal()  {
        self.contentView.removeSubviews()
        tagView = ZWTagListView(x: 15, y: 10, w: screenW-20, h: self.frame.size.height)
        self.contentView.addSubview(tagView)
    }
    public var titles: [ZWTagModel] = NSArray() as! [ZWTagModel] {
        didSet {
            self.tagView.setTagWithTagArray(titles)
            height = self.tagView.size.height + 10
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
