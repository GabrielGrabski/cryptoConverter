//
//  ContentView.swift
//  CryptoToDollar
//
//  Created by Gabriel Grabski on 23/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var amount = "0"
    @State var dollarCurrency = "usd"
    @State var cryptoCurrency = "usd"
    
    let viewModel = MoneyConvertViewModel()
    
    let dollarCurrencies: [String] = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    let cryptoCurrencies: [String] = ["BTC", "ETH", "USDT", "ADA", "BNB", "DOGE", "XRP", "DOT", "UNI", "BCH", "LTC", "LINK", "USDC", "MATIC", "SOL", "THETA", "ICP", "WBTC", "VET", "FIL"]
    
    var body: some View {
        VStack {
            Text("What is the exchange rate between dollar and crypto currencies?")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            
            Text("$\(amount)")
                .font(.largeTitle)
                .padding()
            
            Text("Dollar Currencies")
                .font(.title)
            
            Picker("", selection: $dollarCurrency) {
                ForEach(dollarCurrencies, id: \.self) { dollar in
                    Text(dollar)
                        .tag(dollar.lowercased())
                }
            }
            .pickerStyle(.wheel)
            
            Text("Crypto Currencies")
                .font(.title)
            
            Picker("", selection: $cryptoCurrency) {
                ForEach(cryptoCurrencies, id: \.self) { crypto in
                    Text(crypto)
                        .tag(crypto.lowercased())
                }
            }
            .pickerStyle(.wheel)
            .padding(.bottom, 10)
        }
        .preferredColorScheme(.dark)
        .onChange(of: dollarCurrency) { _, _ in
            getData()
        }
        .onChange(of: cryptoCurrency) { _, _ in
            getData()
        }
        .onAppear(perform: getData)
    }
    
    private func getData() {
        viewModel.getData(cryptoCurrency: cryptoCurrency, dollarCurrency: dollarCurrency) { amount in
            self.amount = amount
        }
    }
}

#Preview {
    ContentView()
}
