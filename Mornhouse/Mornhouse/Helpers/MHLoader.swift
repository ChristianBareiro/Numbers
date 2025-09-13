//
//  MHLoader.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit

class MHLoader {
    
    private static var counter: Int = .zero

    static func configure() {
        DispatchQueue.main.async {
            counter += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if counter == 0 { return }
                let view = UIView(frame: UIScreen.main.bounds)
                view.backgroundColor = .black.withAlphaComponent(0.3)
                view.tag = 1000
                let activityIndicatorView = UIActivityIndicatorView(style: .large)
                activityIndicatorView.center = view.center
                activityIndicatorView.startAnimating()
                view.addSubview(activityIndicatorView)
                UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.addSubview(view)
            }
        }
    }
    
    static func remove() {
        DispatchQueue.main.async {
            counter -= 1
            let view = UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first?.subviews.first(where: { $0.tag == 1000 })
            view?.removeFromSuperview()
        }
    }
    
}
