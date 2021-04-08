//
//  CoreData.swift
//  WallesterApp
//
//  Created by Максим on 05.04.2021.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataProtocol {
    func saveData(_ beer: Beer)
    func loadData() -> [FavoriteBeers]
    func deleteData(_ beer: Beer)
    //func checkDataInCoreDtaWithJSONData(beer: Beer, arrBeer: [Beer]) -> [Beer]
}

class CoreData: CoreDataProtocol {
    var context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request: NSFetchRequest<FavoriteBeers> = FavoriteBeers.fetchRequest()
    
//    func checkDataInCoreDtaWithJSONData(beer: Beer, arrBeer: [Beer]) -> [Beer] {
//        var arr = [Beer]()
//        for i in 0..<arrBeer.count{
//            arr.append(arrBeer[i])
//            if arr[i].name == beer.name {
//                arr[i].favorite = true
//            }
//        }

//
//        return arr
//    }
    
    func checkDataInCoreDataWithJSONData(){
        
    }
    
    
    func saveData(_ beer: Beer) {
        let favoriteBeers = FavoriteBeers(context: context)
        favoriteBeers.name = beer.name
        favoriteBeers.abv = beer.abv
        favoriteBeers.ebc = beer.ebc ?? 0
        favoriteBeers.ibu = beer.ibu ?? 0
        favoriteBeers.favorite = beer.favorite!
        do {
            try context.save()
        } catch  {
            print("Error saving context \(error)")
        }
    }
    
    func loadData() -> [FavoriteBeers] {
        var favoriteBeers = [FavoriteBeers]()
        do {
            favoriteBeers = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        return favoriteBeers
    }
    
    func deleteData(_ beer: Beer) {
        request.predicate = NSPredicate(format: "name = %@", beer.name)
        do {
            let test = try context.fetch(request)
            let objectToDelete = test[0] //as! NSManagedObject
            context.delete(objectToDelete)
            do {
                try context.save()
            } catch  {
                print("Error saving data in DeleteData \(error)")
            }
            
        } catch  {
            print("Error deleding data in DeleteData \(error)")
        }
    }
    
}
