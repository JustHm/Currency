//
//  AddTableViewController.swift
//  Currency
//
//  Created by 안정흠 on 2022/10/22.
//

import UIKit

class AddTableViewController: UITableViewController {
    @IBOutlet weak var targetCountry: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        indicator.isHidden = true
    }
    @IBAction func addButtonTap(_ sender: UIBarButtonItem) {
        indicator.isHidden = false
        indicator.startAnimating()
        
        let defaults = UserDefaults.standard
        let toStr = targetCountry.text?.lowercased() ?? "usd"
        APIService.sharedObject.currencyCheck(to: toStr, from: "krw", completion: { result in
            let temp = CurrencyCellInfo(leftCountry: toStr.uppercased(), rightCountry: "KRW", leftCurrency: 1, rightCurrency: result.price)
            currencyList.append(temp)
            defaults.set(try? PropertyListEncoder().encode(currencyList), forKey: "CurrencyList")
            defaults.set(Date(), forKey: "CurrentDate")
            self.navigationController?.popViewController(animated: true)
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.row == 1  else { return }
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CountryListTableView") as? CountryListTableView else { return }
        vc.sendProperty = { str in
            self.targetCountry.text = str
        }
        navigationController?.present(vc, animated: true)
    }
}
