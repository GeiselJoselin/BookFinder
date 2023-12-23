//
//  MainCoordinator.swift
//  BookFinder
//
//  Created by Geisel Roque on 21/12/23.
//

import Foundation
import UIKit

protocol Coordinator {
    var rootViewController: UINavigationController { get set }
    func start()
    func openDetailBook(bookData: VolumeData)
}

class MainCoordinator: Coordinator {
    var rootViewController: UINavigationController
    var viewControllerFactory: ViewControllerFactory
    
    init(rootViewController: UINavigationController, viewControllerFactory: ViewControllerFactory) {
        self.rootViewController = rootViewController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        rootViewController.pushViewController(viewControllerFactory.homeViewController(), animated: false)
    }
    
    func openDetailBook(bookData: VolumeData) {
        rootViewController.pushViewController(viewControllerFactory.detailBookViewController(bookData: bookData), animated: true)
    }
}
