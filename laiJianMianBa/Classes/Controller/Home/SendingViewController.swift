//
//  SendingViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/21.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
class SendingViewController: RootViewController {
    @IBOutlet weak var meinv: UILabel!
    private var peopleNum: String!
    @IBOutlet weak var people: UILabel!
    init(_ peopleNum: String) {
        super.init(nibName: "SendingViewController", bundle: nil)
        self.peopleNum = peopleNum
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "发布中"
        self.people.text = peopleNum
        self.people.textColor = globalColor()
        if isBoy == false {
            meinv.text = "位帅哥"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
