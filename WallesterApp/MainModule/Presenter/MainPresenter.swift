//
//  MainPresenter.swift
//  WallesterApp
//
//  Created by Максим on 31.03.2021.
//

import Foundation
import UIKit

protocol MainViewProtocol: class {
    func succes()
    func failure(error: Error)
    func addToFavorite(cell: UITableViewCell)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, coreData: CoreDataProtocol)
    func getBeers()
    var beers: [Beer]? {get set}
    func saveData(_ beer: Beer)
    func deleteData(_ beer: Beer)
    //func checkDataInCoreDtaWithJSONData(_ beer: Beer) -> Beer
}

class MainPresenter: MainViewPresenterProtocol {
//    func checkDataInCoreDtaWithJSONData(_ beer: Beer) -> Beer {
//        let beb: Beer
//        beb = coreData.checkDataInCoreDtaWithJSONData(beer: beer, arrBeer: beers!)
//    }
    
    func saveData(_ beer: Beer) {
        coreData.saveData(beer)
    }
    func deleteData(_ beer: Beer) {
        coreData.deleteData(beer)
    }
    
    
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!
    var beers: [Beer]?
    var coreData: CoreDataProtocol!
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, coreData: CoreDataProtocol) {
        self.view = view
        self.networkService = networkService
        self.coreData = coreData
        
        getBeers()
    }
    
    func getBeers() {
        networkService.getBeers { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let beers):
                    //self.beers = beers
                    self.beers = beers?.sorted{ $0.name < $1.name }
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    
    
    
}
