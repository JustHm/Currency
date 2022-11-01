//
//  CaculateViewController.swift
//  Currency
//
//  Created by 안정흠 on 2022/10/24.
//

import UIKit

class CaculateViewController: UIViewController {
    var leftStandard: Float = 0
    var rightStandard: Float = 0
    var leftCountry: String = ""
    var rightCountry: String = ""
    // Field 글자수 제한 13
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightField: UITextField!
    @IBOutlet weak var leftField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftField.text = "\(leftStandard)"
        rightField.text = "\(rightStandard)"
        leftLabel.text = leftCountry
        rightLabel.text = rightCountry
        
        leftField.addTarget(self, action: #selector(leftFieldChanged), for: .editingChanged)
        rightField.addTarget(self, action: #selector(rightFieldChanged), for: .editingChanged)
    }
    private func caculateCurrency(changed: String, isKRW: Bool) -> Float {
        let money = Float(changed) ?? 1.0
        if isKRW { // KRW -> Target
            return  money / rightStandard
        } else { // Target -> KRW
            return money * rightStandard
        }
    }
    @objc func leftFieldChanged() {
        let result = caculateCurrency(changed: leftField.text ?? "0", isKRW: false)
        rightField.text = "\(result)"
    }
    @objc func rightFieldChanged() {
        let result = caculateCurrency(changed: rightField.text ?? "0", isKRW: true)
        leftField.text = "\(result)"
    }
    @IBAction func backButtonTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        leftField.resignFirstResponder()
        rightField.resignFirstResponder()
    }
}

