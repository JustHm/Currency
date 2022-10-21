//
//  ViewController.swift
//  Currency
//
//  Created by 안정흠 on 2022/10/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APIService.sharedObject.currencyCheck(to: "usd", from: "krw", date: Date(), completion: { result in
            print(result.date)
            print(result.target)
        })
    }


}



