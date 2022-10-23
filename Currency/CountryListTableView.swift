//
//  CountryListTableView.swift
//  Currency
//
//  Created by 안정흠 on 2022/10/22.
//

import UIKit

class CountryListTableView: UITableViewController {
    var sendProperty: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            return
        case 1:
            sendProperty?("USD")
        case 2:
            sendProperty?("EUR")
        case 3:
            sendProperty?("JPY")
        case 4:
            sendProperty?("AUD")
        case 5:
            sendProperty?("NZD")
        default:
            return
        }
        dismiss(animated: true)
    }}
