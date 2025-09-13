//
//  MHTableViewCell.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit

class MHTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 1
        }
    }
    
    override func configure(_ data: Any?) {
        super.configure(data)
        if let object = data as? MHNumber { fillnfo(object: object) }
    }
    
    private func fillnfo(object: MHNumber) {
        nameLabel.text = object.fact
    }
    
}
