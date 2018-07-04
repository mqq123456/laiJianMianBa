//
//  EvaluateCell.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/22.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
protocol EvaluateCellDelegate {
    func selected(_ imp:[ImpressModel])
    func similar(_ similar:Int)
}

class EvaluateCell: UITableViewCell {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    public var delegate: EvaluateCellDelegate!
    public var dataArray: [ImpressModel] = [ImpressModel]() {
        didSet{
            myCollectionView.reloadData()
        }
    }
    @IBAction func yesBtnDone(_ sender: Any) {
        yesBtn.isSelected = true
        noBtn.isSelected = false
        delegate.similar(1)
    }
    @IBAction func noBtnDone(_ sender: Any) {
        yesBtn.isSelected = false
        noBtn.isSelected = true
        delegate.similar(0)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        yesBtn.layer.cornerRadius = 3
        yesBtn.clipsToBounds = true
        noBtn.layer.cornerRadius = 3
        noBtn.clipsToBounds = true
        yesBtn.isSelected = true
        noBtn.isSelected = false
        yesBtn.setBackgroundColor(color: UIColor.init("cacaca")!, forState: .normal)
        noBtn.setBackgroundColor(color: UIColor.init("cacaca")!, forState: .normal)
        yesBtn.setBackgroundColor(color: UIColor.init("04bec2")!, forState: .selected)
        noBtn.setBackgroundColor(color: UIColor.init("04bec2")!, forState: .selected)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        myCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        myCollectionView?.delegate = self
        myCollectionView?.dataSource = self
        flowLayout.itemSize = CGSize(width: 375, height: 300)
        myCollectionView.reloadData()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension EvaluateCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model:ImpressModel = self.dataArray[indexPath.row] ;
        let width = widthForLabel(model.impress as NSString, font: 16)
        return CGSize(width: width+3, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let model:ImpressModel = self.dataArray[indexPath.row]
        cell.contentView.removeSubviews()
        let label = UILabel()
        label.text = model.impress
        label.font = UIFont.systemFont(ofSize: 16)
        label.frame = CGRect(x: 0, y: 0, w: widthForLabel(model.impress as NSString, font: 14), h: 30)
        label.layer.cornerRadius = 3.0
        label.layer.masksToBounds = true
        label.layer.borderWidth = 0.5
        label.textAlignment = .center;
        //label.textColor = UIColor.init(hexString: model.impress_color)
        label.textColor = UIColor("a8a8a8")
        label.layer.borderColor = UIColor.init("a8a8a8")?.cgColor
        if model.isSelected == true {
            label.textColor = UIColor.white
            label.backgroundColor = UIColor.init(model.selected_color)
            label.layer.borderWidth = 0
        }else{
            label.textColor = UIColor("a8a8a8")
            label.layer.borderWidth = 0.5
            label.backgroundColor = UIColor.white
        }
        cell.contentView.addSubview(label)
        return cell;
    }
    func widthForLabel(_ text: NSString, font: CGFloat) -> CGFloat {
        let size:CGSize = text.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: font)])
        return size.width + 30
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model:ImpressModel = self.dataArray[indexPath.row]
        model.isSelected = !model.isSelected
        myCollectionView.reloadData()
        var selectedArray = [ImpressModel]()
        for abc in self.dataArray {
            if abc.isSelected == true {
                selectedArray.append(abc)
            }
        }
        delegate.selected(selectedArray)
    }
    ///mark － 设置了半天，最后发现还是这个好是
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
