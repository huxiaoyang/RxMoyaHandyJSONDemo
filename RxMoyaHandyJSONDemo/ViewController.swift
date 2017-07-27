//
//  ViewController.swift
//  RxMoyaHandyJSONDemo
//
//  Created by ucredit-XiaoYang on 2017/7/27.
//  Copyright © 2017年 XiaoYang. All rights reserved.
//

import UIKit
import RxSwift


class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "moya"
        view.backgroundColor = UIColor.orange
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { 
            self.testMoya()
        }
        
    }
    
    
    
    func testMoya() {
        provider.request(.threadList(mod: "getAppIndexThreadList", page: "1"))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .showErrorToast()
            .mapArrayFromData(type: ListModel.self)
            .subscribe ({ event in
                switch event {
                case .next(let list):
                    self.showAlertView(title: "SUCCESS", message: "request is success", action: {
                        print(list)
                    })
                    
                case .error(let error):
                    print(error.localizedDescription)
                    
                case .completed:
                    break
                    
                }
            })
            .addDisposableTo(disposeBag)
    }


}

