//
//  FavoritePresenter.swift
//  WallesterApp
//
//  Created by Максим on 04.04.2021.
//

import Foundation

protocol FavoriteViewProtocol: class {
    func getBeers(beers: [FavoriteBeers])
    func getNameOfSorted(nameOfSorted: [String])
}

protocol FavoritePresenterProtocol: class {
    init(view: FavoriteViewProtocol, coreData: CoreDataProtocol)
    var beers: [FavoriteBeers] {get set}
    func setBeers()
    func loadData()
    func setNameOfSorted()
}

class FavoritePresenter: FavoritePresenterProtocol {

    weak var view: FavoriteViewProtocol?
    var coreData: CoreDataProtocol?
    var beers = [FavoriteBeers]()
    
    private let mirror = Mirror(reflecting: NameOfSorted())
    func getLabelsFromNameOfSorted() -> [String] {
        var allLabels = [String]()
        for child in mirror.children {
            allLabels.append(child.value as! String)
        }
        return allLabels
    }
    
    
    func setNameOfSorted() {
        self.view?.getNameOfSorted(nameOfSorted: getLabelsFromNameOfSorted())
        //print(nameOfSorted)
    }
    
    required init(view: FavoriteViewProtocol, coreData: CoreDataProtocol) {
        self.view = view
        self.coreData = coreData
        loadData()
        setNameOfSorted()
        
        
    }
    
    func loadData() {
        if let data = coreData?.loadData() {
            beers = data.sorted{$0.name!<$1.name!}
            setBeers()
        } else {
            print("Error with load data")
        }
    }
    
    func setBeers() {
        self.view?.getBeers(beers: beers)
    }
    
}
