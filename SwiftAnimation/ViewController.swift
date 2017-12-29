//
//  ViewController.swift
//  SwiftAnimation
//
//  Created by 阮沧晖 on 2017/12/26.
//  Copyright © 2017年 阮沧晖. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var myTableView: UITableView!
    var vcList: NSArray = ["BaseAnimationVC","KeyFrameAnimationVC","GroupAnimtaionVC","TransitionAnimationVC","AffineAnimationVC","MixAnimationVC"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "swift动画学习"
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // 每个节点返回的row的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    // 返回每行的cell的视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "cell1")!
        }else if indexPath.row == 1{
            return tableView.dequeueReusableCell(withIdentifier: "cell2")!
        }else if indexPath.row == 2{
            return tableView.dequeueReusableCell(withIdentifier: "cell3")!
        }else if indexPath.row == 3{
            return tableView.dequeueReusableCell(withIdentifier: "cell4")!
        }else if indexPath.row == 4{
            return tableView.dequeueReusableCell(withIdentifier: "cell5")!
        }else if indexPath.row == 5{
            return tableView.dequeueReusableCell(withIdentifier: "cell6")!
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
    
    // 点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let baseVC = BaseAnimationVC()
        
//        let cls: AnyClass? = NSClassFromString(self.vcList[indexPath.row] as! String)
//        // swift 中通过Class创建一个对象,必须告诉系统Class的类型
//        guard let clsType = cls as? UIViewController.Type else {
//                print("无法转换成UIViewController")
//                return
//        }
//        //let clsType = cls as? UIViewController.Type
//        let vc = clsType.init()
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(BaseAnimationVC(), animated: true)
        }else if indexPath.row == 1{
            self.navigationController?.pushViewController(KeyFrameAnimationVC(), animated: true)
        }else if indexPath.row == 2{
            self.navigationController?.pushViewController(GroupAnimationVC(), animated: true)
        }else if indexPath.row == 3{
            self.navigationController?.pushViewController(TransitionAnimationVC(), animated: true)
        }else if indexPath.row == 4{
            //self.navigationController?.pushViewController(AffineAnimationVC(), animated: true)
        }else if indexPath.row == 5{
            self.navigationController?.pushViewController(ComprehensiveCaseVC(), animated: true)
        }

        
        
    }
    
}

