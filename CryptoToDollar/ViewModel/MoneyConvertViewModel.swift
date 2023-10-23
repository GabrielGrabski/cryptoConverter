//
//  MoneyConvertViewModel.swift
//  CryptoToDollar
//
//  Created by Gabriel Grabski on 23/10/23.
//

import Foundation

class MoneyConvertViewModel {
    private let apiKey = "2CE64B77-27DA-4ABB-A2AA-F98E0C7A8F94"
    
    
    public func getData(cryptoCurrency: String, dollarCurrency: String, completion: @escaping (String) -> Void) {
        if let url = URL(string: "https://rest.coinapi.io/v1/exchangerate/\(cryptoCurrency)/\(dollarCurrency)?apikey=\(apiKey)") {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("ERROR: Error to get data from server.")
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(ExchangeRate.self, from: data).rate
                    let formattedRate = String(format: "%.2f", result)
                    completion(formattedRate)
                } catch {
                    print("ERROR: Error to get data from server.")
                }
            }.resume()
        }
    }
    
}
