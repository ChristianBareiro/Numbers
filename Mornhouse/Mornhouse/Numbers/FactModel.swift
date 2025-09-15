//
//  FactViewController.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit

class FactModel: BaseModel {
    
    init(number: MHNumber) {
        super.init()
        addViews = { stackView in
            let textView = UITextView()
            textView.text = number.fact
            textView.isEditable = false
            textView.isScrollEnabled = false
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = .systemFont(ofSize: 16, weight: .regular)
            textView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            stackView.addArrangedSubview(textView)
        }
    }
    
}
