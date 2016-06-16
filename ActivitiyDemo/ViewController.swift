//
//  ViewController.swift
//  ActivitiyDemo
//
//  Created by sherry on 16/6/16.
//  Copyright © 2016年 sherry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //点击按钮弹出分享视图
    @IBAction func shareBtn(sender: AnyObject) {
        
        //设置分享内容
        let items = ["曙光", UIImage.init(named: "曙光-白底")!, NSURL.init(fileURLWithPath: "http://www.baidu.com")]
        
        //新建自定义的分享对象数组
        let acts = [WXActivity(), SGActivity()]
        
        //根据分享内容和自定义的分享按钮调用分享视图
        let activityView = UIActivityViewController(activityItems: items, applicationActivities: acts)
        
        //要排除的分享按钮，不显示在分享框里
        activityView.excludedActivityTypes = [UIActivityTypeMail, UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll]

        //显示分享视图
        self.presentViewController(activityView, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class SGActivity: UIActivity {
    
    //用于保存传递过来的要分享的数据
    var text: String!
    var url: NSURL!
    var image: UIImage!
    
    //显示在分享框里的名称
    override func activityTitle() -> String? {
        return "曙光"
    }
    
    //分享框的图片
    override func activityImage() -> UIImage? {
        return UIImage(named: "曙光-白底")
    }
    
    //分享类型，在UIActivityViewController.completionHandler回调里可以用于判断，一般取当前类名
    override func activityType() -> String? {
        return SGActivity.self.description()
    }
    
    //按钮类型（分享按钮：在第一行，彩色；动作按钮：在第二行，黑白）
    override class func activityCategory() -> UIActivityCategory {
    
        return UIActivityCategory.Action
    
    }
    
    //是否显示分享按钮，这里一般根据用户是否授权或分享内容是否正确来决定是否要隐藏分享按钮
    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        for item in activityItems {
            
            if item is UIImage {
                return true
            }
            
            if item is String {
                return true
            }
            
            if item is NSURL {
                return true
            }
        }
        return false
    }
    
    //解析分享数据时调用，可以进行一定的处理
    override func prepareWithActivityItems(activityItems: [AnyObject]) {
        print("prepareWithActivityItems")
        
        for item in activityItems {
            
            if item is UIImage {
                image = item as! UIImage
            }
            
            if item is String {
                text = item as! String
            }
            
            if item is NSURL {
                url = item as! NSURL
            }
        }

    }
    
    //执行分享行为，这里根据自己的应用做相应的处理
    //例如你可以分享到另外的app例如微信分享，也可以保存数据到照片或者其他地方，甚至是分享到网络
    override func performActivity() {
        print("performActivity")
        //具体的执行代码这边先省略
    }
    
    //分享时调用
    override func activityViewController() -> UIViewController? {
        print("activityViewController")
        return nil
    }
    
    //完成分享后调用
    override func activityDidFinish(completed: Bool) {
        print("activityDidFinish")
    }

}

class WXActivity: SGActivity {
    
    //显示在分享框里的名称
    override func activityTitle() -> String? {
        return "微信"
    }
    
    //分享框的图片
    override func activityImage() -> UIImage? {
        return UIImage(named: "wx.jpg")
    }
    
    //分享类型，在UIActivityViewController.completionHandler回调里可以用于判断，一般取当前类名
    override func activityType() -> String? {
        return WXActivity.self.description()
    }
    
    //按钮类型（分享按钮：在第一行，彩色；动作按钮：在第二行，黑白）
    override class func activityCategory() -> UIActivityCategory {
        
        return UIActivityCategory.Share
        
    }

}
