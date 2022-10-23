//
//  CurrencyTableViewCell.swift
//  Currency
//
//  Created by 안정흠 on 2022/10/21.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    @IBOutlet weak var rightCurrencyField: UITextField!
    @IBOutlet weak var leftCurrencyField: UITextField!
    @IBOutlet weak var rightCountryLabel: UILabel!
    @IBOutlet weak var leftCountryLabel: UILabel!
    var cellRow = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        leftCurrencyField.isEnabled = false
        rightCurrencyField.isEnabled = false
    }
    
    private func getCurrencyInfo(to: String, from: String) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
