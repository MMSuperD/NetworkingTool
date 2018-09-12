//
//  ViewController.swift
//  NetworkUsering
//
//  Created by sh-lx on 2018/9/6.
//  Copyright © 2018年 sh-lx. All rights reserved.
//

import UIKit

class ViewController: UIViewController,URLSessionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // demo1()
        
      //  demo2()
       // demo3()
        demo4()
    }

    func demo1() -> () {
    let urlSession = URLSession.shared
    let url = URL.init(string: "https://www.baidu.com/")
        
        
    let task = urlSession.dataTask(with: url!) { (data, response, error) in
        
        }
        
        task.resume()
        
        
    }
    
    //测试get
    func demo2() -> () {
        WDHttpSessionManager.shared().wd_request(way: RequestWay.get, urlString: "v1/dish/info", params: ["code":84758768], success: { (data, response) -> (Void) in
            
            print(response!)
            print(data!)
            
        }) { (error) -> (Void) in
            
            print(error!)
        }
    }
    
    //测试post
    func demo3() -> () {
        
        WDHttpSessionManager.shared().wd_request(way: RequestWay.post, urlString: String("/v1/dish/info"), params: [
            "deviceType" : 2,
            "sign" : "D850556EE632E270ACEC2714BA07C69EFED6406E1FB8E8264EBCECD8958A9B289C0CAE35AA5C2BAE",
            "timestamp" : 1486286686332,
            "uid" : "oW2wBwStFjhB_6oAWRDC2ocW2sSs",
            "versionCode" : "2.0.6",
            "zbid" : 162120
            ], success: { (data, response) -> (Void) in
                
                print(response!)
                print(data!)
                
        }) { (error) -> (Void) in
            
            print(error!)
        }
        
    }
    
    //MARK: 结构体回调测试
    func demo4() -> () {
        
        WDHttpSessionManager.shared().wd_request(way: .get, urlString: "v1/dish/info", params: ["code":84758768], result: Result(success: { (task, data) in
            
            print(data)
            
        }, failure: { (task, error) in
            
            print(error)
            
        }))
        
    }

}

extension UIViewController {
    
    
}

