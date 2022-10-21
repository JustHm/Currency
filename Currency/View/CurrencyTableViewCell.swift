//
//  CurrencyTableViewCell.swift
//  Currency
//
//  Created by 안정흠 on 2022/10/21.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    @IBOutlet weak var leftCurrencyLabel: UILabel!
    @IBOutlet weak var rightCurrencyLabel: UILabel!
    @IBOutlet weak var rightCountryLabel: UILabel!
    @IBOutlet weak var leftCountryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func rightCountryButtonTap(_ sender: UIButton) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CountryListView") as? CountryListView else {
            return
        }
        print(vc)
    }
    @IBAction func leftCountryButtonTap(_ sender: UIButton) {
    }
    
    private func getCurrencyInfo(to: String, from: String) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
