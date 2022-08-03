//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.delegate = self
        pickerView.dataSource = self
        coinManager.delegate = self
    }
}
//MARK: - UIPickerViewDelegate section

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.fetchData(by: row)
    }
}

//MARK: - UIPickerViewDataSource section

extension ViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

//MARK: - CoinManagerDelegate section

extension ViewController: CoinManagerDelegate {
    func onSuccessUpdate(coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.quoteLabel.text = coinModel.quote
            self.valueLabel.text = coinModel.rate
        }
    }
    
    func onFailedUpdate(error: Error) {
        print(error.localizedDescription)
    }
}
