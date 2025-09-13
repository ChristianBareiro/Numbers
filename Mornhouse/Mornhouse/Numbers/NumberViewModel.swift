//
//  NumberViewModel.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit
import RxSwift

class NumberViewModel: BaseViewModel {

    private var dbManager: NumberManager = NumberManager()
    private var history: [MHNumber] = []
    
    var numberListener: PublishSubject<MHNumber> = PublishSubject()
    
    private func addNumber(_ number: MHNumber) {
        history.insert(number, at: .zero)
    }
    
    func getNumbers(cache: Bool = false) -> [MHNumber] {
        if !cache { history = dbManager.fetchData() }
        return history
    }
    
    func loadRandomNumber() async {
        addLoader()
        guard let object = try? await requestCodable(request: .init(with: .randomNumber([:])), typeOf: String.self) else { removeLoader(); return }
        handleString(result: object)
    }
    
    func loadNumberInfo(_ number: String) async {
        guard let numberInt = Int(number) else { return }
        if
            let dbNumber = history.first(where: { $0.number == numberInt }) {
            numberListener.onNext(dbNumber)
            return
        }
        addLoader()
        guard let object = try? await requestCodable(request: .init(with: .number([kValue: number])), typeOf: String.self) else { removeLoader(); return }
        handleString(result: object)
    }
    
    private func handleString(result: String) {
        removeLoader()
        let numbers = result.components(separatedBy: " ").filter({ Int($0) != nil })
        guard
            let number = numbers.first,
            let numberInt = Int(number),
            let dbObject = dbManager.insert(number: numberInt, fact: result)
        else { return }
        addNumber(dbObject)
        numberListener.onNext(dbObject)
    }
    
}
