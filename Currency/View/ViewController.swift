//
//  ViewController.swift
//  Currency
//
//  Created by 안정흠 on 2022/10/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currencyTableView: UITableView!
//    private var currencyList: [CurrencyCellInfo] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currencyTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        loadCurrencyList()
        
        let sharedNib = UINib(nibName: "CurrencyTableViewCell", bundle: nil)
        currencyTableView.register(sharedNib, forCellReuseIdentifier: "CurrencyCell")
    }

    @IBAction func changeDate(_ sender: UIButton) {
        let dateFrame = CGRect(x: 0, y: self.view.bounds.midY, width: self.view.bounds.width, height: 250)
        let datePicker = UIDatePicker(frame: dateFrame)
        datePicker.preferredDatePickerStyle = .inline
        datePicker.backgroundColor = UIColor(cgColor: CGColor(gray: 0.9, alpha: 0.8))
        datePicker.layer.cornerRadius = 10
        datePicker.layer.masksToBounds = true //corner radius 적용
        datePicker.datePickerMode = .date
        
        self.view.addSubview(datePicker)
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
        cell.rightCurrencyField.text = "\(currencyInfo.rightCurrency)"
        cell.leftCurrencyField.text = "\(currencyInfo.leftCurrency)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CurrencyTable") as? CountryListView else { return }
//        navigationController?.present(vc, animated: true)
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



