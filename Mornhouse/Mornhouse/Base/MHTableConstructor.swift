//
//  MHTableConstructor.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit

enum MHIdentifier: String {
    
    case historyNumber = "MHTableViewCell"
    
}

class MHRow {
    
    var identifier: MHIdentifier
    var path: IndexPath?
    var object: Any?
    
    init(id: MHIdentifier, data: Any?) {
        identifier = id
        object = data
    }
    
}

class MHSection {
    
    var rows: [MHRow] = []
    
}

class TableData {
    
    var sections: [MHSection] = []
    
}

class MHTableConstructor: NSObject {
    
    private var mTableView: UITableView!
    var handler: ((MHRow) -> ())? = nil
    var tableData: TableData = TableData() {
        didSet {
            mTableView.reloadData()
        }
    }

    init(tableView: UITableView, data: TableData) {
        super.init()
        mTableView = tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
}

extension MHTableConstructor: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowData = tableData.sections[indexPath.section].rows[indexPath.row]
        handler?(rowData)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension MHTableConstructor: UITableViewDataSource {
    
    func tablenumberOfSections(in tableView: UITableView) -> Int {
        tableData.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section < tableData.sections.count ? tableData.sections[section].rows.count : .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = tableData.sections[indexPath.section].rows[indexPath.row]
        let identifier = rowData.identifier.rawValue
        let nib = UINib(nibName: identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        rowData.path = indexPath
        cell.configure(rowData.object)
        return cell
    }
    
}
