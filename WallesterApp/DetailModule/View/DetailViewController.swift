//
//  DetailViewController.swift
//  WallesterApp
//
//  Created by Максим on 03.04.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var tableView = UITableView()
    var beer: Beer?

    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter.setDetail()
        customiseSections()
        title = beer?.name ?? "NoMoreBeers!"
        //ИСПРАВИТЬ ВНИЗУ
        let button = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: nil)
        if beer?.favorite == true {
            button.tintColor = UIColor.yellow
        } else {
            button.tintColor = UIColor.gray
        }
        
        navigationItem.rightBarButtonItem = button
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        //set delegates
        setTableViewDelegates()
        //set constraint
        setTableViewConstraint()
        //set cell height
        tableView.rowHeight = 30
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setTableViewConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.topAnchor.constraint(equalTo: view!.topAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view!.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view!.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view!.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view!.bottomAnchor).isActive = true
    }
    
    func customiseSections() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        tableView.tableHeaderView = header
        tableView.tableFooterView = footer
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor.systemGray6
        
    }

}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.textAlignment = .center
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Name: \(beer?.name ?? "NoMoreBeers!")"
        case 1:
            cell.textLabel?.text = "Alcohol: \(beer?.abv ?? 0)°"
        case 2:
            cell.textLabel?.text = "EBC: \(beer?.ebc ?? 0)"
        case 3:
            cell.textLabel?.text = "IBU: \(beer?.ibu ?? 0)"
        default:
            break
        }
        return cell
    }
    
    
}

extension DetailViewController: DetailViewProtocol{
    func getDetail(beer: Beer?) {
        self.beer = beer
    }
    
    
}
