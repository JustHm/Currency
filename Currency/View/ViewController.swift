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
            // Load 이후 어제 날짜의 환율이라면 데이터를 갱신한다.
            if let lastDate = UserDefaults.standard.value(forKey: "CurrentDate") as? Date {
                let lastDay = Calendar.current.dateComponents([.day], from: lastDate)
                let currentDay = Calendar.current.dateComponents([.day], from: Date())
                if lastDay != currentDay {
                    //저장되어 있는 데이터 갱신
                    updateCurrencyList()
                }
            }
        } catch {
            print("HM: CurrencyList Load Fail")
        }
    }
    private func saveCurrencyList() {
        let defaults = UserDefaults.standard
        defaults.set(try? PropertyListEncoder().encode(currencyList), forKey: "CurrencyList")
    }
    private func updateCurrencyList() {
        print("update List")
        for (index, item) in currencyList.enumerated() {
            APIService.sharedObject.currencyCheck(to: item.leftCountry.lowercased(), from: item.rightCountry.lowercased(), completion: { result in
                currencyList[index].rightCurrency = result.price
            })
        }
        // 업데이트 날짜 갱신
        UserDefaults.standard.set(Date(), forKey: "CurrentDate")
        saveCurrencyList()
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



