//
//  ViewController.swift
//  Currency
//
//  Created by 안정흠 on 2022/10/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var currencyTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currencyTableView.reloadData()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        todayLabel.text = formatter.string(from: Date())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyTableView.layer.borderWidth = 1
        currencyTableView.layer.cornerRadius = 10
        currencyTableView.layer.borderColor = UIColor.gray.cgColor
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        
        loadCurrencyList()
        
        let sharedNib = UINib(nibName: "CurrencyTableViewCell", bundle: nil)
        currencyTableView.register(sharedNib, forCellReuseIdentifier: "CurrencyCell")
    }
    
    @IBAction func showHelpPopUp(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController else { return }
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    private func loadCurrencyList() {
        do {
            if let data = UserDefaults.standard.value(forKey: "CurrencyList") as? Data {
                let list = try PropertyListDecoder().decode([CurrencyCellInfo].self, from: data)
                currencyList = list
            }
        } catch {
            print("HM: CurrencyList Load Fail")
        }
    }
    private func saveCurrencyList() {
        let defaults = UserDefaults.standard
        defaults.set(try? PropertyListEncoder().encode(currencyList), forKey: "CurrencyList")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as? CurrencyTableViewCell else { return UITableViewCell() }
        let currencyInfo = currencyList[indexPath.row]
        
        cell.leftCountryLabel.text = currencyInfo.leftCountry
        cell.rightCountryLabel.text = currencyInfo.rightCountry
        cell.leftCurrencyField.text = String(format: "%.2f ", currencyInfo.leftCurrency) + currencyInfo.leftCountry
        cell.rightCurrencyField.text = String(format: "%.2f ", currencyInfo.rightCurrency) + currencyInfo.rightCountry
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CaculateViewController") as? CaculateViewController else { return }
        
        vc.leftStandard = currencyList[indexPath.row].leftCurrency
        vc.rightStandard = currencyList[indexPath.row].rightCurrency
        vc.leftCountry = currencyList[indexPath.row].leftCountry
        vc.rightCountry = currencyList[indexPath.row].rightCountry
        
        navigationController?.present(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            currencyList.remove(at: indexPath.row)
            saveCurrencyList()
            tableView.reloadData()
        case .none:
            break
        case .insert:
            break
        @unknown default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



