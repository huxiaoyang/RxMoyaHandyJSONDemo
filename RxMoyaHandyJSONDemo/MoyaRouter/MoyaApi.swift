//
//  MoyaApi.swift
//  Customer
//
//  Created by ucredit-XiaoYang on 2017/7/26.
//  Copyright © 2017年 XiaoYang. All rights reserved.
//

import Foundation
import Moya


enum MoyaApi {
    case threadList(mod: String, page: String)
}


extension MoyaApi: TargetType {
    
    var baseURL: URL {
        return URL(string: Moya_baseURL)!
    }
    
    /// 要附加到`baseURL'后以形成完整的URL的路径
    var path: String {
        switch self {
        case .threadList:
            return "/api.php"
        }
    }
    
    
    /// 请求中使用的HTTP方法
    var method: Moya.Method {
        return .get
    }
    
    
    /// 请求中要编码的参数
    var parameters: [String : Any]? {
        switch self {
        case .threadList(let mod, let page):
            var p = [String: Any]()
            p["mod"] = mod
            p["page"] = page
            return p
        }
    }
    
    
    /// 用于参数编码的方法
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// 要执行的HTTP任务的类型
    var task: Task {
        return .request
    }
    
    
    /// 提供存根数据用于测试
    /// 只在单元测试文件中有作用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
}


private let endPointClosure = { (target: MoyaApi) -> Endpoint<MoyaApi> in
    let defaultEndpoint = MoyaProvider<MoyaApi>.defaultEndpointMapping(for: target)
    return defaultEndpoint.adding(parameters: publicParameters as [String : AnyObject]?, httpHeaderFields: headerFields)
}


let provider = RxMoyaProvider<MoyaApi>(endpointClosure: endPointClosure, plugins:[NetworkLoggerPlugin(verbose: true), MoyaPlugin()])





