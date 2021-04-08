//
//  MainViewCell.swift
//  WallesterApp
//
//  Created by Максим on 02.04.2021.
//

import UIKit

class MainViewCell: UITableViewCell {
    
    var view: MainViewProtocol?

    var nameOfBeer = UILabel()
    var volOfBeer = UILabel()
    let stackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //addSubview(nameOfBeer)
        configureStackView()
        configureNabeOfBeer()
        configureVolOfBeer()
        addToFavoriteStarButton()
        //setNameOfBeerConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addToFavoriteStarButton (){
        let starButton = UIButton(type: .system)  
        starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        starButton.tintColor = .gray
        starButton.addTarget(self, action: #selector(addToFavoriteByButtonPressed), for: .touchUpInside)
        accessoryView = starButton
    }
    
    @objc private func addToFavoriteByButtonPressed() {
        view?.addToFavorite(cell: self)
    }
    
    
    
    func configureStackView(){
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.addArrangedSubview(nameOfBeer)
        stackView.addArrangedSubview(volOfBeer)
        //constraint
        setStackViewConstraint()
    }
    
    func setStackViewConstraint () {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        //stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        //stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
    }
    
    func set(beer: Beer){
        nameOfBeer.text = beer.name
        volOfBeer.text = "Vol: \(String(beer.abv))"
    }
    
    func configureNabeOfBeer() {
        nameOfBeer.numberOfLines = 0
        nameOfBeer.adjustsFontSizeToFitWidth = true
    }
    
    func configureVolOfBeer() {
        volOfBeer.numberOfLines = 0
        volOfBeer.adjustsFontSizeToFitWidth = true
        volOfBeer.font = textLabel?.font.withSize(13)
    }
    
    func setNameOfBeerConstraints() {
        nameOfBeer.translatesAutoresizingMaskIntoConstraints = false
        nameOfBeer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
    }
}
