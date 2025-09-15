//
//  NavigationController.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit

class NavigationController: UINavigationController {
    
    
}

extension UINavigationController {
    
    func show(controller: SuperViewController, animated: Bool = true) {
        pushViewController(controller, animated: animated)
    }

    func present(controller: SuperViewController, animated: Bool = true, fullScreen: Bool = false, completion: (() -> ())? = nil) {
        if fullScreen { modalPresentationStyle = .fullScreen }
        present(controller, animated: animated, completion: completion)
    }

    func present(model: BaseModel, animated: Bool = true, fullScreen: Bool = false, completion: (() -> ())? = nil) {
        print("go to \(model)")

    }

    func show(model: BaseModel, animated: Bool = true) {
        let controller = ContainerViewController.controller()
        controller.model = model
        show(controller: controller, animated: animated)
    }
    
}


