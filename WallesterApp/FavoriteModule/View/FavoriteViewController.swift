//
//  FavoriteViewController.swift
//  WallesterApp
//
//  Created by Максим on 04.04.2021.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    
    var tableView = UITableView()
    var segmentCotroll = UISegmentedControl()
    var selectedDesc = 0
    
    var presenter: FavoritePresenterProtocol!
    var beers = [FavoriteBeers]()
    
    var nameOfSorted = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        configureSegment()
        configureTableView()
        view.backgroundColor = UIColor.white
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.loadData()
        tableView.reloadData()
    }
    
    //MARK: - Configure Segments and values
    func configureSegment(){
        segmentCotroll = UISegmentedControl(items: nameOfSorted)
        view.addSubview(segmentCotroll)
        setSegmentConstraint()
        segmentCotroll.addTarget(self, action: #selector(selectedValue), for: .valueChanged)
    }
    
    @objc func selectedValue(target: UISegmentedControl) {
        if target == segmentCotroll {
            selectedDesc = target.selectedSegmentIndex
            tableView.reloadData()
        }
    }
    
    func setSegmentConstraint() {
        segmentCotroll.translatesAutoresizingMaskIntoConstraints = false
        segmentCotroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        segmentCotroll.leadingAnchor.constraint(equalTo: view!.leadingAnchor, constant: 10).isActive = true
        segmentCotroll.trailingAnchor.constraint(equalTo: view!.trailingAnchor, constant: -10).isActive = true
    }
    
    //MARK: - Configure Table View
    
    func configureTableView(){
        view.addSubview(tableView)
        setTableViewDelegates()
        setTableViewConstraint()
        tableView.rowHeight = 60
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setTableViewConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: segmentCotroll.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view!.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view!.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view!.bottomAnchor).isActive = true
    }

}

//MARK: - Favorite Protocol

extension FavoriteViewController: FavoriteViewProtocol{
    func getNameOfSorted(nameOfSorted: [String]) {
       self.nameOfSorted = nameOfSorted
    }
    
    func getBeers(beers: [FavoriteBeers]) {
        self.beers = beers
    }
}

//MARK: - Table View Data Source
extension FavoriteViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch selectedDesc {
        case 0:
            beers = beers.sorted{$0.name!<$1.name!}
            cell.textLabel?.text = beers[indexPath.row].name
        case 1:
            beers = beers.sorted{$0.abv<$1.abv}
            cell.textLabel?.text = String(beers[indexPath.row].abv)
        case 2:
            beers = beers.sorted{$0.ebc<$1.ebc }
            cell.textLabel?.text = String(beers[indexPath.row].ebc)
        case 3:
            beers = beers.sorted{$0.ibu<$1.ibu}
            cell.textLabel?.text = String(beers[indexPath.row].ibu)
        default:
            break
        }
        return cell
    }
    
}

//MARK: - Table View Delegate
extension FavoriteViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beer = beers[indexPath.row]
        let descript = Beer(name: beer.name!, abv: beer.abv, ebc: beer.ebc, ibu: beer.ibu, favorite: beer.favorite)
        let detailViewController = ModelBuilder.createDetailModule(beer: descript)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
