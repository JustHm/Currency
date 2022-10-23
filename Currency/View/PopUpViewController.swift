//
//  PopUpViewController.swift
//  Currency
//
//  Created by 안정흠 on 2022/10/23.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet var uiView: UIView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let frameView = CGRect(x: 0, y: 0, width: 300, height: 300)
        uiView.frame = frameView
//        uiView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        uiView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
