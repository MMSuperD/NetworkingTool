//
//  SuperD+extentsion.swift
//  NetworkUsering
//
//  Created by sh-lx on 2018/9/12.
//  Copyright © 2018年 sh-lx. All rights reserved.
//

import Foundation
import UIKit

//MARK:⚠️当我们在大数转小数的时候,可能出现越界问题导致程序奔溃
//MARK:例如:12333333333333333333333333333333.33  转 Int8 就会奔溃
extension Double {
    
    var wd_Double: Double {
        return Double.init(self)
    }
    
    var wd_Int: Int {
        
        return Int.init(self)
    }
    
    var wd_Float:Float {
        
        return Float.init(self)
    }
    
    var wd_CGFloat:CGFloat {
        
        return CGFloat.init(self)
        
    }
    
    var wd_Int8:Int8 {
        
        return Int8.init(self)
    }
    
    var wd_Int16:Int16 {
        
        return Int16.init(self)
    }
    
    var wd_Int32:Int32 {
        
        return Int32.init(self)
    }
    
    var wd_Int64:Int64 {
        
        return Int64.init(self)
    }
    
    
}

extension Float {
    
    var wd_Double: Double {
        return Double.init(self)
    }
    
    var wd_Int: Int {
        return Int.init(self)
    }
    
    var wd_Float:Float {
        
        return Float.init(self)
    }
    
    var wd_CGFloat:CGFloat {
        
        return CGFloat.init(self)
        
    }
    
    var wd_Int8:Int8 {
        
        return Int8.init(self)
    }
    
    var wd_Int16:Int16 {
        
        return Int16.init(self)
    }
    
    var wd_Int32:Int32 {
        
        return Int32.init(self)
    }
    
    var wd_Int64:Int64 {
        
        return Int64.init(self)
    }
}

extension Int {
    
    var wd_Double: Double {
        return Double.init(self)
    }
    
    var wd_Int: Int {
        return Int.init(self)
    }
    
    var wd_Float:Float {
        
        return Float.init(self)
    }
    
    var wd_CGFloat:CGFloat {
        
        return CGFloat.init(self)
        
    }
    
    var wd_Int8:Int8 {
        
        return Int8.init(self)
    }
    
    var wd_Int16:Int16 {
        
        return Int16.init(self)
    }
    
    var wd_Int32:Int32 {
        
        return Int32.init(self)
    }
    
    var wd_Int64:Int64 {
        
        return Int64.init(self)
    }
}

extension Int8 {
    
    var wd_Double: Double {
        return Double.init(self)
    }
    
    var wd_Int: Int {
        return Int.init(self)
    }
    
    var wd_Float:Float {
        
        return Float.init(self)
    }
    
    var wd_CGFloat:CGFloat {
        
        return CGFloat.init(self)
        
    }
    
    var wd_Int8:Int8 {
        
        return Int8.init(self)
    }
    
    var wd_Int16:Int16 {
        
        return Int16.init(self)
    }
    
    var wd_Int32:Int32 {
        
        return Int32.init(self)
    }
    
    var wd_Int64:Int64 {
        
        return Int64.init(self)
    }
}

extension Int16 {
    
    var wd_Double: Double {
        return Double.init(self)
    }
    
    var wd_Int: Int {
        return Int.init(self)
    }
    
    var wd_Float:Float {
        
        return Float.init(self)
    }
    
    var wd_CGFloat:CGFloat {
        
        return CGFloat.init(self)
        
    }
    
    var wd_Int8:Int8 {
        
        return Int8.init(self)
    }
    
    var wd_Int16:Int16 {
        
        return Int16.init(self)
    }
    
    var wd_Int32:Int32 {
        
        return Int32.init(self)
    }
    
    var wd_Int64:Int64 {
        
        return Int64.init(self)
    }
}

extension Int32 {
    
    var wd_Double: Double {
        return Double.init(self)
    }
    
    var wd_Int: Int {
        return Int.init(self)
    }
    
    var wd_Float:Float {
        
        return Float.init(self)
    }
    
    var wd_CGFloat:CGFloat {
        
        return CGFloat.init(self)
        
    }
    
    var wd_Int8:Int8 {
        
        return Int8.init(self)
    }
    
    var wd_Int16:Int16 {
        
        return Int16.init(self)
    }
    
    var wd_Int32:Int32 {
        
        return Int32.init(self)
    }
    
    var wd_Int64:Int64 {
        
        return Int64.init(self)
    }
}

extension Int64 {
    
    var wd_Double: Double {
        return Double.init(self)
    }
    
    var wd_Int: Int {
        return Int.init(self)
    }
    
    var wd_Float:Float {
        
        return Float.init(self)
    }
    
    var wd_CGFloat:CGFloat {
        
        return CGFloat.init(self)
        
    }
    
    var wd_Int8:Int8 {
        
        return Int8.init(self)
    }
    
    var wd_Int16:Int16 {
        
        return Int16.init(self)
    }
    
    var wd_Int32:Int32 {
        
        return Int32.init(self)
    }
    
    var wd_Int64:Int64 {
        
        return Int64.init(self)
    }
}

extension CGRect {
    
    
    /// 这个任意类型只支持 CGFloat,String,Float,Int,Double,如果不是以上类型,x,y,width,height 的值都为 0
    ///
    /// - Parameters:
    ///   - x: 坐标x
    ///   - y: 坐标y
    ///   - width: 宽度
    ///   - height: 高度
    init(x: Any, y: Any, width: Any, height: Any) {
        self.init()
        
        func isInt(temp:Any) -> (Bool) {
            return temp is Int
        }
        
        func isDouble(temp:Any) -> (Bool) {
            return temp is Double
        }
        
        func isFloat(temp:Any) -> (Bool) {
            return temp is Float
        }
        
        func isCGFloat(temp:Any) -> (Bool) {
            
            return temp is CGFloat
        }
        
        func isString(temp:Any) -> (Bool) {
            return temp is String
        }
        
        var endX:Double = 0
        var endY:Double = 0
        var endWidth:Double = 0
        var endHeight:Double = 0
        
        if isString(temp: x) {
            
            let strX = x as! String
            endX = Double(strX)!
        } else if isDouble(temp: x) {
            
            let doubleX = x as! Double
            
            endX = Double.init(doubleX)
            
        } else if isFloat(temp: x) {
            
            let floatX = x as! Float
            
            endX = Double.init(floatX)
            
        } else if isCGFloat(temp: x) {
            
            let cgfloatX = x as! CGFloat
            endX = Double.init(cgfloatX)
            
        } else if isInt(temp: x) {
            
            let intX = x as! Int
            endX = Double.init(intX)
            
        } else {
            
            
        }
        
        if isString(temp: y) {
            
            let strY = y as! String
            endY = Double(strY)!
        } else if isDouble(temp: y) {
            
            let doubleY = y as! Double
            
            endY = Double.init(doubleY)
            
        } else if isFloat(temp: y) {
            
            let floatY = y as! Float
            
            endY = Double.init(floatY)
            
        } else if isCGFloat(temp: y) {
            
            let cgfloatY = y as! CGFloat
            endY = Double.init(cgfloatY)
            
        } else if isInt(temp: y) {
            
            let intY = y as! Int
            endY = Double.init(intY)
            
        } else {
            
            
        }
        
        if isString(temp: height) {
            
            let strH = height as! String
            endHeight = Double(strH)!
        } else if isDouble(temp: height) {
            
            let doubleH = height as! Double
            
            endHeight = Double.init(doubleH)
            
        } else if isFloat(temp: height) {
            
            let floatH = height as! Float
            
            endHeight = Double.init(floatH)
            
        } else if isCGFloat(temp: height) {
            
            let cgfloatH = height as! CGFloat
            endHeight = Double.init(cgfloatH)
            
        } else if isInt(temp: height) {
            
            let intH = height as! Int
            endHeight = Double.init(intH)
            
        } else {
            
            
        }
        
        if isString(temp: width) {
            
            let strW = width as! String
            endWidth = Double(strW)!
        } else if isDouble(temp: width) {
            
            let doubleW = width as! Double
            
            endWidth = Double.init(doubleW)
            
        } else if isFloat(temp: width) {
            
            let floatW = width as! Float
            
            endWidth = Double.init(floatW)
            
        } else if isCGFloat(temp: width) {
            
            let cgfloatW = width as! CGFloat
            endWidth = Double.init(cgfloatW)
            
        } else if isInt(temp: width) {
            
            let intW = width as! Int
            endWidth = Double.init(intW)
            
        } else {
            
        }
        
        self.init(x: endX, y: endY, width: endWidth, height: endHeight)
    }
    
}

extension Array {
    
    func componentsJoined(by separator: String) -> String {
        
        var mulString = String()
        for i in 0...self.count - 1 {
            mulString.append("\(self[i])\(separator)")
        }
        _ = mulString.remove(at: mulString.index(before: mulString.endIndex))
        return mulString
    }
    
}

//MARK: 常用函数集合

/// Device is Ipad
///
/// - Returns: Bool
func isIpad() -> (Bool) {
    return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? false:true
}

/// Device is Iphone
///
/// - Returns: Bool
func isIphone() -> (Bool) {
     return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? false:true
}


/// current Device is iphoneX
///
/// - Returns: Bool
func isIphoneX() -> (Bool) {
    return UIScreen.main.bounds.size.height == 812 ? true : false
}

///全局打印函数
func WDLog<T>(_ message:T,file:String = #file,funcName:String = #function,lineNum:Int = #line){
    
    #if DEBUG
    
    let file = (file as NSString).lastPathComponent;
    
    print("\(file)--lineNum:\(lineNum)--\(message)");
    
    #endif
}


//MARK: 常用常量集合
/// 屏幕的宽度
let SCREEN_WIDTH  = UIScreen.main.bounds.size.width

/// 屏幕的高度
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

/// navigationBar 的高度
let HEIGHT_NAVCONTENTBAR = 44.0

/// statusBar 状态栏的高度
let HEIGHT_STATUSBAR = isIphoneX() ? 44.0:20.0

/// navigationBar 的高度
let HEIGHT_NAVBAR = isIphoneX() ? 88.0:64.0

///TabBar 的高度
let HEIGHT_TABBAR = isIphoneX() ? 83.0:49.0



