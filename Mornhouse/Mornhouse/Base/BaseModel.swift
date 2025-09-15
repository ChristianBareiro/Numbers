//
//  BaseModel.swift
//  Mornhouse
//
//  Created by Александр Колесник on 15.09.2025.
//

import UIKit

class BaseModel: NSObject {

    var mTableData: TableData? = nil
    var mConstructor: MHTableConstructor? = nil
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
    
    func initConstructor() {}
    
    var addViews: ((UIStackView) -> ())? = nil
    
}
