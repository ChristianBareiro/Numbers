//
//  ReactEx.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import RxSwift

extension Observable {

    func applyIOSchedulers() -> Observable<Element> {
        return subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background)).observe(on: MainScheduler.instance)
    }

}

extension Single {

    func applyIOSchedulers() -> PrimitiveSequence<Trait, Element> {
        return subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background)).observe(on: MainScheduler.instance)
    }

}
