//
//  MainViewController.swift
//  WallesterApp
//
//  Created by Максим on 31.03.2021.
//

import UIKit

class MainViewController: UIViewController {
    var tableView = UITableView()
    var presenter: MainViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        title = "All beers"
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        //set delegates
        setTableViewDelegates()
        //register cell
        tableView.register(MainViewCell.self, forCellReuseIdentifier: "Cell")
        //set constraint
        tableView.pin(to: view)
        //set dynamicly cell height
        tableView.rowHeight = 60
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.beers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MainViewCell
        let beer = presenter.beers![indexPath.row]
        //presenter.checkDataInCoreDtaWithJSONData(beer)
        cell.set(beer: beer)
        cell.accessoryView?.tintColor = beer.favorite ?? false ? UIColor.yellow : UIColor.gray
        cell.view = self
        return cell
    }
}

extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beer = presenter.beers?[indexPath.row]
        let detailViewController = ModelBuilder.createDetailModule(beer: beer)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}


extension MainViewController: MainViewProtocol{
    
    
    func addToFavorite(cell: UITableViewCell) {
        let indexPathTapped = tableView.indexPath(for: cell)
        var beer = presenter.beers![indexPathTapped!.row]
        let favorite = beer.favorite
        presenter.beers![indexPathTapped!.row].favorite = !(favorite ?? false)
        beer = presenter.beers![indexPathTapped!.row]
        if presenter.beers![indexPathTapped!.row].favorite == true {
            presenter.saveData(beer)
            print("True")
        } else {
            presenter.deleteData(beer)
            print("False")
        }
        tableView.reloadData()
    }
    
    
    func succes() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error)
    }
    
}
