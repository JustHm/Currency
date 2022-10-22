//
//  AddTableViewController.swift
//  Currency
//
//  Created by 안정흠 on 2022/10/22.
//

import UIKit

class AddTableViewController: UITableViewController {
    @IBOutlet weak var targetCountry: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func addButtonTap(_ sender: UIBarButtonItem) {
        let defaults = UserDefaults.standard
        let toStr = targetCountry.text?.lowercased() ?? "usd"
        APIService.sharedObject.currencyCheck(to: toStr, from: "krw", date: Date(), completion: { result in
            let temp = CurrencyCellInfo(leftCountry: toStr.uppercased(), rightCountry: "KRW", leftCurrency: 1, rightCurrency: result.price)
            currencyList.append(temp)
            defaults.set(try? PropertyListEncoder().encode(currencyList), forKey: "CurrencyList")
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
        guard indexPath.row == 1  else { return }
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CountryListTableView") as? CountryListTableView else { return }
        vc.sendProperty = { str in
            self.targetCountry.text = str
        }
        navigationController?.present(vc, animated: true)
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}