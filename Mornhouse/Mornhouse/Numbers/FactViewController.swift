//
//  FactViewController.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit

class FactViewController: SuperViewController {

    @IBOutlet weak var textView: UITextView!
    
    var number: MHNumber!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = number.fact
    }

}
