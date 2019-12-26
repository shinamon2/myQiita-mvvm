//
//  __PREFIX__Wireframe.swift
//  Kuri
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © __YEAR__ __USERNAME__. All rights reserved.
//

import UIKit

protocol __PREFIX__Wireframe: class {
    private weak var viewController: UIViewController? { get set }
    
    func showList()
    func closeView()
}


class __PREFIX__WireframeImpl: __PREFIX__Wireframe {
    private weak var viewController: UIViewController?
    
    init(
        viewController: UIViewController
        ) {
        self.viewController = viewController
    }
    func closeView() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
