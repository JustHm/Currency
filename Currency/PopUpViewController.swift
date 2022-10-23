//
//  PopUpViewController.swift
//  Currency
//
//  Created by 안정흠 on 2022/10/23.
//

import UIKit

class PopUpViewController: UIViewController {
    @IBOutlet weak var uiView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiView.layer.cornerRadius = 10
        
    }
    
    @IBAction func exitButtonTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
