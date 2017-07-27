//
//  MoyaExtension.swift
//  Customer
//
//  Created by ucredit-XiaoYang on 2017/7/26.
//  Copyright © 2017年 XiaoYang. All rights reserved.
//

import Foundation
import RxSwift
import HandyJSON


fileprivate let RESULT_CODE = "ret"
fileprivate let RESULT_DATA = "items"
fileprivate let RESULT_MESSAGE = "message"


// 自定义扩展，这里实现一个error情况下toast弹出
extension Observable {
    
    func showErrorToast() -> Observable<Element> {
        return self.do(onNext: { response in
            
            let json = response as! [String : Any]
            if let c = json[RESULT_CODE] as? Int, c != 0 {
                // 错误信息，弹出Toast
                UIViewController.showStatus(title: json[RESULT_MESSAGE] as! String)
            }
            
        }, onError: { error in
            // 错误信息，弹出Toast
            UIViewController.showStatus(title: error.localizedDescription)
        })
    }
    
}


// 扩展一个error类型
enum RxSwiftMoyaError : Swift.Error {
    case parseJSONError
    case noRepresentor
    case notSuccessfulHTTP
    case noData
    case couldNotMakeObjectError
    case customError(resultCode: String, resultMsg: String)
}


extension RxSwiftMoyaError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .parseJSONError:
            return "数据解析失败"
        case .noRepresentor:
            return "NoRepresentor."
        case .notSuccessfulHTTP:
            return "NotSuccessfulHTTP."
        case .noData:
            return "NoData."
        case .couldNotMakeObjectError:
            return "CouldNotMakeObjectError."
        case .customError(resultCode: let resultCode, resultMsg: let resultMsg):
            return "错误码: \(resultCode), 错误信息: \(resultMsg)"
        }
    }
}



// 下面的扩展，只是针对 HandyJSON 
// 可以根据自己的实际情况扩展 ObjectMapper 和 SwiftyJSON
// 为什么使用 HandyJSON ，因为他比较接近swift4.0之后，swift自带的json解析器
extension Observable {
    
    /// HandyJSON To Object
    // 从json data中获取Object数据
    func mapObjectFromData<T: HandyJSON>(type: T.Type) -> Observable<T> {
        
        return mapObject(type: type, designatedPath: RESULT_DATA)
        
    }
    
    // 从指定json位置获取Object数据
    func mapObject<T: HandyJSON>(type: T.Type, designatedPath: String? = nil) -> Observable<T> {
        
        return self.map { response in
            
            guard let dict = response as? [String : Any] else {
                throw RxSwiftMoyaError.parseJSONError
            }
            
            if dict["code"] != nil, let code = dict[RESULT_CODE] as? Int, code != 0 {
                throw RxSwiftMoyaError.noData
            }
            
            guard let data = try? JSONSerialization.data(withJSONObject: dict) else {
                throw RxSwiftMoyaError.parseJSONError
            }
            
            let jsonString = String(data: data, encoding: .utf8)
            
            guard let object = JSONDeserializer<T>.deserializeFrom(json: jsonString, designatedPath: designatedPath) else {
                throw RxSwiftMoyaError.parseJSONError
            }
            
            return object
        }
        
    }
    
    
    
    /// HandyJSON To Array
    func mapArrayFromData<T: HandyJSON>(type: T.Type) -> Observable<[T]> {
        return mapArray(type: type, designatedPath: RESULT_DATA)
    }
    
    func mapArray<T: HandyJSON>(type: T.Type, designatedPath: String? = nil) -> Observable<[T]> {
        
        return self.map { response in
            
            guard let dict = response as? [String : Any] else {
                throw RxSwiftMoyaError.parseJSONError
            }
            
            if dict["code"] != nil, let code = dict[RESULT_CODE] as? Int, code != 0 {
                throw RxSwiftMoyaError.noData
            }
            
            guard let data = try? JSONSerialization.data(withJSONObject: dict) else {
                throw RxSwiftMoyaError.parseJSONError
            }
            
            let jsonString = String(data: data, encoding: .utf8)

            guard let array = JSONDeserializer<T>.deserializeModelArrayFrom(json: jsonString, designatedPath: designatedPath) as? [T] else {
                throw RxSwiftMoyaError.parseJSONError
            }
            
            return array
        }
        
    }
    
}
