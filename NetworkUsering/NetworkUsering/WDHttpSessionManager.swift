//
//  WDHttpSessionManager.swift
//  NetworkUsering
//
//  Created by sh-lx on 2018/9/10.
//  Copyright © 2018年 sh-lx. All rights reserved.
//

import UIKit

enum RequestWay {
    case post
    case get
}

enum URLRequesteSerializationError: Error {
    case none //没有错误
    case requestSerializationNoValueForKey //没有key 对应的Value 值
}

struct Result {
    var success:(URLSessionDataTask?,Any?)->() = { (task,data) in
    }
    
    var failure:(URLSessionDataTask?,Any?)->() = {(task,data) in
    }
    
}

enum Response {
    case success(URLSessionDataTask,Any),failure(URLSessionDataTask,Any)
}

//声明一个闭包类型
typealias Success = ((Any?, URLResponse?)->(Void))
typealias Fairule = ((Error?)->(Void))
typealias ISSuccess = ((Bool)->(Void))
typealias Finish = ((Data?, URLResponse?,Error?)->(Void))
typealias Params = (Dictionary<String,Any>)

class WDHttpSessionManager: NSObject,URLSessionDelegate {
    
    var p_session:URLSession?
    var p_baseUrl:String?
    
    //创建单利请求对象
    static let instance = WDHttpSessionManager()
    class func shared()->(WDHttpSessionManager)  {
        return instance
    }
    
    //必要参数设置,一次设置终身使用
    func startValue(baseUrl:String?,session:URLSession?,finish:((_ isSuccess:Bool)->())?) -> (Void) {
        
        guard let _ = session,let _ = baseUrl else {
            finish?(false)
            return
        }
        
        if (baseUrl!.hasPrefix("https://")) || (baseUrl!.hasPrefix("http://")) {
             self.p_baseUrl = baseUrl
        } else {
            //基地址后面的/是否有,没有的话就添加上
            if baseUrl!.hasSuffix("/") {
                self.p_baseUrl = baseUrl
            } else {
                self.p_baseUrl =  "http://" + baseUrl! + "/"
            }
        }
        self.p_session = session
        finish?(true)
    }
    
    

}

//MARK: URLSessionDelegate 代理
extension WDHttpSessionManager {
    
    
    
}

//MARK: 闭包请求回调
extension WDHttpSessionManager {

   private func wd_createDataTask(urlString:String,way:RequestWay,params:Params?,success:Success?,fairule:Fairule?) -> (URLSessionDataTask?) {
        
        //现在是创建Request
        var request:URLRequest?
        
        var requestError:Error?
        
        do {
            
            request = try WDURLRequestSerialization().wd_request(way: way, baseUrl: self.p_baseUrl, urlString: urlString, params: params)
           // request = try wd_createRequest(way: way, urlString: tempUrl, params: params)
            
        }catch {
            
            requestError = error
            fairule?(requestError)
            //创建请求出现错误之后,我们就需要返回了,不能继续往下走了
            return nil
            
        }
        
        let dataTask = self.p_session?.dataTask(with: request!, completionHandler: { (data, response, error) in
          
            DispatchQueue.main.async {
                
                if error != nil {
                    
                    fairule?(error)
                } else {
                  
                    let hh =  try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    print(hh ?? "数据解析错误,返回来的数据是没有解析了,还是json 字符串数据")
                    success?(hh,response)
                }
                
                }
        })
        dataTask?.resume()
        return dataTask
    }
    
   private func wd_dataTask(urlString:String,way:RequestWay,params:Params? ,success:Success?,fairule:Fairule?) -> (Void) {
        
        _ = wd_createDataTask(urlString: urlString, way: way, params: params, success: success, fairule: fairule)
        
    }
    
    func wd_request(way:RequestWay,urlString:String,params:Params?,success:Success?,fairule:Fairule?) -> (Void) {
        self.wd_dataTask(urlString: urlString, way: way, params: params, success: success, fairule: fairule)
    }
    
   
    
}

//MARK: 结构体请求回调
extension WDHttpSessionManager {
    
   public func wd_request(way:RequestWay,urlString:String,params:Params?,result:Result?) -> (Void) {
        self.wd_dataTask(urlString: urlString, way: way, params: params, result:result)
    }
    
   private  func wd_dataTask(urlString:String,way:RequestWay,params:Params? ,result:Result?) -> (Void) {
        
        _ = wd_createDataTask(urlString: urlString, way: way, params: params, result:result)
        
    }
    
   private func wd_createDataTask(urlString:String,way:RequestWay,params:Params?,result:Result?) -> (URLSessionDataTask?) {
        
        //现在是创建Request
        var request:URLRequest?
        
        var requestError:Error?
        
        do {
            
            request = try WDURLRequestSerialization().wd_request(way: way, baseUrl: self.p_baseUrl, urlString: urlString, params: params)
            
        }catch {
            
            requestError = error
            
            result?.failure(nil,requestError)
            //创建请求出现错误之后,我们就需要返回了,不能继续往下走了
            return nil
            
        }
        
        let dataTask = self.p_session?.dataTask(with: request!, completionHandler: { (data, response, error) in
            
            DispatchQueue.main.async {
                
                if error != nil {
                    
                    result?.failure(nil,error)
                   
                } else {
                    
                    let hh =  try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    print(hh ?? "数据解析错误,返回来的数据是没有解析了,还是json 字符串数据")
                    
                    result?.success(nil,hh)
                    
                }
                
            }
        })
        dataTask?.resume()
        return dataTask
    }
    
}

//MARK: 枚举请求回调
extension WDHttpSessionManager {
    
    
}



class WDURLRequestSerialization:NSObject {
    
    /*
     *  @author gitkong
     *
     *  超时时间
     */
 private var timeoutInterval:TimeInterval = 5.0
    
    /*
     *  @author gitkong
     *
     *  请求头
     */
  private  var mutableHTTPRequestHeaders:Dictionary<String, Any> = Dictionary<String,Any>()
    
    /*
     *  @author gitkong
     *
     *  缓存策略
     */
  private  var cachePolicy:URLRequest.CachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
    
    override init() {
        super.init()
        
        initRequesetHeader()
        
    }
    
    private func wd_setValue(value:String,forHTTPHeaderField field:String)->() {
        self.mutableHTTPRequestHeaders[field] = value
    }
    
    //MARK:初始化必要的请求头
    //初始化请求头,看起来比较清楚
    public func initRequesetHeader() -> (Void){
        
        //1.语言设置
        var acceptLanguagesComponents = Array<Any>()
        for idx in 0...Locale.preferredLanguages.count - 1 {
            
            let obj = Locale.preferredLanguages[idx]
            
            let q = 1.0 - Double(idx) * 0.1
            
            acceptLanguagesComponents.append("".appendingFormat("%@;q=%0.1g", obj,q))
            
            if q <= 0.5 {
                
                break
            }
        }
        
        self.wd_setValue(value:acceptLanguagesComponents.componentsJoined(by: ","), forHTTPHeaderField: "Accept-Language")
        
        //第二部分系统信息设置
        var infoDict = Bundle.main.infoDictionary! as [String : Any]
        
        var userAgent:String = "".appendingFormat("%@/%@ (%@; iOS %@; Scale/%0.2f)", infoDict[kCFBundleExecutableKey as String] as! CVarArg? ?? infoDict[kCFBundleIdentifierKey as String] as! CVarArg,infoDict["CFBundleShortVersionString"] as! CVarArg? ?? infoDict[kCFBundleVersionKey as String] as! CVarArg,UIDevice.current.model,UIDevice.current.systemVersion,UIScreen.main.scale)
        
        if userAgent.canBeConverted(to: String.Encoding.ascii) {
            
            if CFStringTransform(userAgent as! CFMutableString, nil, "Any-Latin; Latin-ASCII;[:^ASCII:] Remove" as CFString, false) {
                userAgent = userAgent as String
            }
        }
        
        self.wd_setValue(value: userAgent, forHTTPHeaderField: "User-Agent")
        
    }
    
    func wd_request(way:RequestWay,baseUrl:String?, urlString:String?,params:Dictionary<String, Any>?) throws -> (URLRequest?) {
        //创建请求
        
        var tempUrl: String?
        
        if urlString!.hasPrefix("http://") || urlString!.hasPrefix("https://") {
            tempUrl = urlString
        } else {
            
            //这里需要判断接口前面是否存在"/",如果存在,就需要删除这个斜杠,如果没有就最好直接用
            if urlString!.hasPrefix("/") {
                var tempStr = urlString
                _ = tempStr!.remove(at: (urlString?.startIndex)!)
                tempUrl = baseUrl! + tempStr!
                
            } else {
                
                tempUrl = baseUrl! + urlString!
            }
            
        }
        // 判断url是否有效
        assert(tempUrl != "", "url 不能为空")
        
        let url:URL = URL(string: tempUrl!)!
        
        var request:URLRequest = URLRequest(url: url, cachePolicy: self.cachePolicy, timeoutInterval: self.timeoutInterval)
        //这里是请求头
        for key in self.mutableHTTPRequestHeaders.keys {
            request.setValue(self.mutableHTTPRequestHeaders[key] as? String, forHTTPHeaderField: key)
        }
        
        var bodyStr:String?
        
        do {
            bodyStr = try wd_httpBodyString(params: params!)
            
        } catch  {
            throw error
        }
        
        
        switch way {
        case .get:
            
            request.url = URL.init(string: tempUrl! + "?" + bodyStr!)
            request.httpMethod = "GET"
            break
        case .post:
            
             request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
             request.httpBody = bodyStr?.data(using: String.Encoding.utf8)
             request.httpMethod = "POST"

            break
        }
        
        
        return request
    }
    
   public func wd_httpBodyString(params:Dictionary<String, Any>) throws ->(String) {
        
        var mulString = String()
        for key in params.keys {
            
            // 解包去掉optional
            guard params[key] != nil else {
                throw URLRequesteSerializationError.requestSerializationNoValueForKey
            }
            
            let value = params[key]!
            print("------------\(key) = \(value)")
            let keyValue = "\(key)=\(value)&"
            mulString.append(keyValue)
        }
        _ = mulString.remove(at: mulString.index(before: mulString.endIndex))
        print(mulString)
        return mulString
        
    }
    
}
