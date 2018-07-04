//
//  PickerView.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/21.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit

protocol PickerViewDelegate {
    
    /// pickerView选择的回调
    ///
    /// - Parameter model: 选择的数据模型
    func selectDone(_ model: PickerModel)
}
class PickerModel {
    /** time == date 为日期类型返回 */
    var time: String!
    var frist: String!
    var second: String!
    var third: String!
    var timeInterval: TimeInterval!
}
class PickerView: UIView {
    /** 日期picker */
    @IBOutlet weak var datePicker: UIDatePicker!
    /** 普通picker */
    @IBOutlet weak var pickerView: UIPickerView!
    /** 回调 */
    public var delegate: PickerViewDelegate!
    /** 传递数据的数组 */
    fileprivate lazy var array1 : NSArray = NSArray()
    fileprivate lazy var array2 : NSArray = NSArray()
    fileprivate lazy var array3 : NSArray = NSArray()
    fileprivate lazy var array4 : NSArray = NSArray()
    fileprivate lazy var array5 : NSArray = NSArray()
    /** myRow == 8 为日期类型的弹出 */
    fileprivate var myRow: Int!
    /** 回调数据模型 */
    fileprivate lazy var model : PickerModel = PickerModel()
    
    public class func initWith(row: Int ,arr1: NSArray, arr2: NSArray, arr3: NSArray) ->  PickerView {
        /** 实力化picker */
        let picker = Bundle.main.loadNibNamed("PickerView", owner: self, options: nil)?.last as! PickerView
        picker.myRow = row
        /** 日期类型 */
        if row == 8 {
            picker.myRow = 1
            picker.array1 = ["",""]
            picker.pickerView.isHidden = true
            picker.datePicker.isHidden = false
            picker.datePicker.backgroundColor = UIColor.white
            return picker
        }
        /** 首页时间选择 */
        if row > 2 {
            
            //获取当前时间
            let now = Date()
            //当前时间的时间戳
            let timeInterval:TimeInterval = now.timeIntervalSince1970
            let timeStamp = Int(timeInterval) + 1800

            //转换为时间
            let newtimeInterval:TimeInterval = TimeInterval(timeStamp)
            let date = NSDate(timeIntervalSince1970: newtimeInterval)
            //格式话输出
            let dformatter = DateFormatter()
            dformatter.dateFormat = "HH"
            let hour: Int = Int(dformatter.string(from: date as Date))!
            let hourArray = NSMutableArray()
            picker.array2 = ["10","11","12","13","14","15","16","17","18"]
            picker.array3 = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
            
            if hour >= 19 {
                picker.array1 = ["明天"]
                picker.array5 = picker.array3
                picker.model.frist = "明天"
                picker.model.second = "10"
                picker.model.third = "00"
            }else {
                picker.array1 = ["今天","明天"]
                for i in hour..<19 {
                    hourArray.add(String(i))
                }
                picker.array4 = hourArray
                //格式话输出
                let minformatter = DateFormatter()
                minformatter.dateFormat = "mm"
                let min: Int = Int(minformatter.string(from: date as Date))!
                let minArray = NSMutableArray()
                for i in min..<60 {
                    var str = NSString(format: "%d", i)
                    if str.length == 1 {
                        str = "0\(str)" as NSString
                    }
                    minArray.add(String(str))
                }
                picker.array5 = minArray
                picker.model.frist = "今天"
                picker.model.second = picker.array4[0] as? String ?? "00"
                picker.model.third = picker.array5[0] as? String ?? "00"
            }
            //格式话输出
            if picker.model.frist == "明天" {
                picker.model.time = picker.getTomorrowDay(now as Date)
            }else{
                //格式话输出
                let timeformatter = DateFormatter()
                timeformatter.dateFormat = "yyyy-MM-dd"
                picker.model.time = timeformatter.string(from: now as Date)
            }
        }else{
            picker.array1 = arr1
            picker.array2 = arr3
            picker.array3 = arr2
            picker.model.frist = arr1[0] as! String
        }
        picker.myRow = row
        picker.frame = CGRect(x: 0, y: 0, w: screenW, h: screenH)
        if let frist = picker.array1.firstObject as? String {
            if frist.hasSuffix("cm") {
                if isBoy {
                    picker.model.frist = "175cm"
                    picker.pickerView.selectRow(35, inComponent: 0, animated: false)
                }else{
                    picker.model.frist = "160cm"
                    picker.pickerView.selectRow(20, inComponent: 0, animated: false)
                }
            }
        }
        return picker
    }
    override func awakeFromNib() {
        
        pickerView.delegate = self
        pickerView.dataSource = self
        cancleBtn.layer.cornerRadius = 5
        cancleBtn.layer.borderColor = RGBA(r: 153, g: 153, b: 153, a: 1).cgColor
        cancleBtn.layer.borderWidth = 0.5
        cancleBtn.clipsToBounds = true
        doneBtn.layer.cornerRadius = 5
        doneBtn.layer.borderColor = RGBA(r: 153, g: 153, b: 153, a: 1).cgColor
        doneBtn.layer.borderWidth = 0.5
        doneBtn.clipsToBounds = true
        self.backgroundColor = RGBA(r: 0, g: 0, b: 0, a: 0)
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
    }
    public func show(_ nav: UINavigationController) {
        frame = CGRect(x: 0, y: 266, w: screenW, h: screenH)
        nav.view.addSubview(self)
        UIView.animate(withDuration: 0.2, animations: {
            self.frame = CGRect(x: 0, y: 0, w: screenW, h: screenH)
        }) { (_) in
            self.backgroundColor = RGBA(r: 0, g: 0, b: 0, a: 0.2)
        }
    }
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @objc public func dismiss() {
        self.removeFromSuperview()
    }
    @IBAction func cacleDone(_ sender: Any) {
        dismiss()
    }
    @IBAction func doneClick(_ sender: Any) {
        dismiss()
        if self.datePicker.isHidden == false  {
            let date = datePicker.date
            let dformatter = DateFormatter()
            dformatter.dateFormat = "yyyy-MM-dd"
            let str = dformatter.string(from: date)
            model.frist = str
            model.timeInterval = date.timeIntervalSince1970
            model.time = "date"
            delegate.selectDone(model)
            return
        }
        if myRow == 3 {
            pickerView.reloadAllComponents()
        }
        delegate.selectDone(model)
    }
    
    public func getTomorrowDay(_ now: Date) -> String {
        let gregorian = NSCalendar.init(calendarIdentifier: .gregorian)
        let unitFlags = Set<Calendar.Component>([.day, .month, .year , .weekday])
        var components = NSCalendar.current.dateComponents(unitFlags, from: now)
        components.day = components.day! + 1
        let begin = gregorian?.date(from: components)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: begin!)
    }
}

// MARK: - UIPickerViewDelegate,UIPickerViewDataSource
extension PickerView: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return myRow
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return array1[row] as? String
        case 1:
            if pickerView.selectedRow(inComponent: 0) == 0 && myRow > 2 && array4.count > 0 {
                return array4[row] as? String
            }
            return array2[row] as? String
        case 2:
            if pickerView.selectedRow(inComponent: 0) == 0&&pickerView.selectedRow(inComponent: 1) == 0 && myRow > 2 && array5.count > 0 {
                return array5[row] as? String
            }
            return array3[row] as? String
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return array1.count
        case 1:
            if pickerView.selectedRow(inComponent: 0) == 0 && myRow > 2 && array4.count > 0 {
                return array4.count
            }
            return array2.count
        case 2:
            if pickerView.selectedRow(inComponent: 0) == 0&&pickerView.selectedRow(inComponent: 1) == 0 && myRow > 2 && array5.count > 0 {
                return array5.count
            }
            return array3.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
        switch component {
        case 0:
            model.frist = array1[row] as! String
            if myRow == 3 {
                model.second = "10"
                model.third = "00"
            }
            if model.frist == "明天" {
                model.time = getTomorrowDay(Date())
            }else{
                //格式话输出
                let timeformatter = DateFormatter()
                timeformatter.dateFormat = "yyyy-MM-dd"
                model.time = timeformatter.string(from: Date())
            }
            return
        case 1:
            if pickerView.selectedRow(inComponent: 0) == 0 && myRow > 2 && array4.count > 0 {
                model.second = myRow >= 2 ? array4[row] as! String : nil
                if row == 0 {
                    
                }else{
                    model.second = myRow >= 2 ? array4[row] as! String : ""
                    model.third = "00"
                }
            }else {
                model.second = myRow >= 2 ? array2[row] as! String : nil
            }
            return
        case 2:
            if pickerView.selectedRow(inComponent: 0) == 0&&pickerView.selectedRow(inComponent: 1) == 0 && myRow > 2 && array5.count > 0 {
                model.third = myRow >= 3 ? array5[row] as! String :nil
            }else{
                model.third = myRow >= 3 ? array3[row] as! String :nil
            }
            return
        default:
            return
        }
        
    }

}
