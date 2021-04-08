//
//  ModuleBuilder.swift
//  WallesterApp
//
//  Created by Максим on 31.03.2021.
//

import Foundation
import UIKit
import CoreData

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailModule(beer: Beer?) -> UIViewController
    static func createFavoriteModule() -> UIViewController
}

class ModelBuilder: Builder {
    
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let coreData = CoreData()
        let presenter = MainPresenter(view: view, networkService: networkService, coreData: coreData)
        view.presenter = presenter
        return view
    }
    
    static func createFavoriteModule() -> UIViewController {
        let view = FavoriteViewController()
        let coreData = CoreData()
        let presenter = FavoritePresenter(view: view, coreData: coreData)
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule(beer: Beer?) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: networkService, beer: beer)
        view.presenter = presenter
        return view
    }
    
    
}
