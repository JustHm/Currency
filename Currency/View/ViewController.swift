//
//  ViewController.swift
//  Currency
//
//  Created by 안정흠 on 2022/10/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currencyTableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        APIService.sharedObject.currencyCheck(to: "usd", from: "krw", date: Date(), completion: { result in
            print(result.date)
            print(result.target)
        })
    }

    @IBAction func targetChangeButton(_ sender: UIButton) {
        print("is Pressed")
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
    @IBAction func addCurrencyList(_ sender: UIBarButtonItem) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddCurrencyViewController") as? AddCurrencyViewController else { return }
        present(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}



