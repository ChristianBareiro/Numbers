//
//  ViewController.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit
import RxSwift

class SuperViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var disposeBag: DisposeBag = .init()
    var constructor: MHTableConstructor? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }

    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SuperViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

}

