//
//  DetailPresenter.swift
//  WallesterApp
//
//  Created by Максим on 03.04.2021.
//

import Foundation

protocol DetailViewProtocol: class {
    func getDetail(beer: Beer?)
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, beer: Beer?)
    func setDetail()
}

class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var beer: Beer?
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, beer: Beer?) {
        self.view = view
        self.networkService = networkService
        self.beer = beer
    }
    
    public func setDetail() {
        self.view?.getDetail(beer: beer)
    }
    
    
}
