//
//  UserCell.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/21.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    fileprivate var type: Int!
    fileprivate var leftLabel: UILabel!
    fileprivate var rightLabel: UILabel!
    fileprivate var line: UIView!
    fileprivate var bottonLine: UIView!
    fileprivate var roundView: UIView!
    fileprivate var tagView : ZWTagListView!
    fileprivate var descArray: [ZWTagModel] = {
       return [ZWTagModel]()
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupOriginal()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupOriginal() {
        
        let leftLabel = UILabel()
        leftLabel.textColor = RGBA(r: 51, g: 51, b: 51, a: 1)
        leftLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(leftLabel)
        self.leftLabel = leftLabel
        
        let rightLabel = UILabel()
        rightLabel.textColor = RGBA(r: 51, g: 51, b: 51, a: 1)
        rightLabel.font = UIFont.systemFont(ofSize: 14)
        rightLabel.textAlignment = .right
        contentView.addSubview(rightLabel)
        self.rightLabel = rightLabel

        let line = UIView()
        line.backgroundColor = UIColor("ececec")
        contentView.addSubview(line)
        self.line = line
        
        let bottonLine = UIView()
        bottonLine.backgroundColor = UIColor("ececec")
        contentView.addSubview(bottonLine)
        self.bottonLine = bottonLine
        
        let roundView = UIView()
        roundView.backgroundColor = UIColor("ececec")
        contentView.addSubview(roundView)
        self.roundView = roundView
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        tagView = ZWTagListView(x: 0, y: 0, w: 0, h: 0)
        self.contentView.addSubview(tagView)
    }
    
    var statusFrame : UserFrame = UserFrame(){
        didSet {
            let statusM = statusFrame.status
            
            self.setupFrame()
            /// 给控件赋值
            leftLabel.text = statusM.title
            rightLabel.text = statusM.detail
            if (statusM.detailColor != nil) {
                rightLabel.textColor = UIColor(statusM.detailColor)
            }else{
                rightLabel.textColor = RGBA(r: 51, g: 51, b: 51, a: 1)
            }
            roundView.roundView()
            if statusM.tags != nil {
                //self.descArray = statusM.tags
                self.tagView.setTagWithTagArray(statusM.tags)
            }
        }
    }
    
    func setupFrame() {
        self.leftLabel.frame = self.statusFrame.leftLabelF
        self.rightLabel.frame = self.statusFrame.rightLabelF
        self.line.frame = self.statusFrame.lineF
        self.bottonLine.frame = self.statusFrame.bottonLineF
        self.roundView.frame = self.statusFrame.roundViewF
        self.tagView.frame = self.statusFrame.descF
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
// MARK: - SendReleaseFrame
class UserFrame: NSObject {
    
    var leftLabelF: CGRect!
    var rightLabelF: CGRect!
    var lineF: CGRect!
    var bottonLineF: CGRect!
    var descF: CGRect!
    var roundViewF: CGRect!
    /** cell的高度 */
    var cellHeight : CGFloat!
    
    var status : UserModel = UserModel() {
        didSet {
            /// 设置frame
            lineF = CGRect(x: 20, y: 0, w: 2, h: 100)
            leftLabelF = CGRect(x: lineF.maxX+10, y: 20, w: screenW-100, h: 20)
            rightLabelF = CGRect(x: 190, y: 20, w: screenW-210, h: 20)
            roundViewF = CGRect(x: 16, y: 25, w: 10, h: 10)
            if status.tags != nil {
                descF = CGRect(x: leftLabelF.minX, y: leftLabelF.maxY + 5, w: screenW-leftLabelF.minX-20, h: ZWTagListView.getHeightWith(status.tags)/2)
            }else{
                descF = CGRect(x: leftLabelF.minX, y: leftLabelF.maxY + 5, w: screenW-leftLabelF.minX-20, h: 0)
            }
            
            bottonLineF = CGRect(x: leftLabelF.minX, y: descF.maxY+15, w: screenW-leftLabelF.minX-20, h: 0.7)
            lineF = CGRect(x: 20, y: 0, w: 2, h: bottonLineF.maxY)
            cellHeight = bottonLineF.maxY
            
        }
    }
    
    
}
// MARK: - SendReleaseModel
class UserModel: NSObject {
    ///用户唯一标识
    var type : Int!
    var kid : String!
    var title : String!
    var detail : String!
    var tags : [ZWTagModel]!
    var detailColor : String!
}

