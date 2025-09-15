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
    var model: BaseModel? = nil

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

class ContainerViewController: SuperViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    static func controller<T: SuperViewController>(storyboardName: String = "Main", identifier: String = "container") -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model?.mConstructor = MHTableConstructor(tableView: tableView, data: TableData())
        model?.addViews?(topStackView)
    }
    
}
