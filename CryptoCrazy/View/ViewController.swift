//
//  ViewController.swift
//  CryptoCrazy
//
//  Created by Macbook Pro on 7.11.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var cryptoListViewModel : CryptoListViewModel!
    
    var colorArray = [UIColor]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.colorArray = [
            UIColor(red: 100/255, green: 150/255, blue: 170/255, alpha: 1.0),
            UIColor(red: 120/255, green: 150/255, blue: 170/255, alpha: 1.0),
            UIColor(red: 140/255, green: 150/255, blue: 170/255, alpha: 1.0),
            UIColor(red: 160/255, green: 150/255, blue: 170/255, alpha: 1.0),
            UIColor(red: 180/255, green: 150/255, blue: 170/255, alpha: 1.0),
            UIColor(red: 200/255, green: 150/255, blue: 170/255, alpha: 1.0)
        ]
        
      getData()
    }
    
    func getData(){
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        Webservice().downloadCurrencies(url: url) { cryptos in
            if let cryptos = cryptos {
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numbersOfRowsInSection()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
        let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
        cell.cryptoName.text = cryptoViewModel.name
        cell.cryptoPrice.text = cryptoViewModel.price
        cell.backgroundColor = colorArray[indexPath.row % 6]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

