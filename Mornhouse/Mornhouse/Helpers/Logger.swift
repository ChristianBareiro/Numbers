//
//  Logger.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit

enum Logger {
    
    static func log(_ item: @autoclosure () -> Any = ()) {
        #if DEBUG
        print(item())
        #endif
    }
    
    static func error(_ error: Error) {
        #if DEBUG
        log("ERROR: \(error.localizedDescription)")
        #endif
    }
    
}
