//
//  CoredataManager.swift
//  SportsApp
//
//  Created by n0shy on 21/06/2022.
//

import Foundation
import UIKit
import CoreData


protocol  CoredataManagerVSFavourites{
    func fetchFavouriteLeagues(fetchedData: inout [NSManagedObject])->[NSManagedObject]
    func deleteFavouriteLeague(deletedData: NSManagedObject)
}

protocol CoredataManagerVSLeagues {
    func storeFavouriteLeague(data: LeaguesResultView)
    func deleteFavouriteLeague(deletedData: LeaguesResultView)
    func searchForLeague(id: String) -> Bool
}

class CoredataManager : CoredataManagerVSFavourites,CoredataManagerVSLeagues{
    
    //var appDelegate = UIApplication.shared.delegate as! AppDelegate
    //var managedcontext = appDelegate.persistentContainer.viewContext
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var managedContext = appDelegate.persistentContainer.viewContext
    
    func storeFavouriteLeague(data: LeaguesResultView){

        print("4-data is stored in core data with id \(data.id)")

        let entity = NSEntityDescription.entity(forEntityName: "FavouriteLeague", in: managedContext)
        let league = NSManagedObject(entity: entity!, insertInto: managedContext)
        league.setValue(data.id, forKey: "leagueId")
        league.setValue(data.name, forKey: "leagueName")
        league.setValue(data.imageURL, forKey: "leagueImgURL")
        league.setValue(data.ytURL, forKey: "leagueYtuURL")
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print(error)
        }
    }
    
    
    func fetchFavouriteLeagues(fetchedData: inout [NSManagedObject])->[NSManagedObject]{

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteLeague")
        
        do{
            fetchedData = try managedContext.fetch(fetchRequest)
        }catch let error as NSError{
            print(error)
        }
        
        return fetchedData
        
    }
    
    func deleteFavouriteLeague(deletedData: NSManagedObject){
        managedContext.delete(deletedData)
        
        do{
            try managedContext.save()
            
        }catch let error as NSError
        {
            print(error)
        }
    }
    
    
    func deleteFavouriteLeague(deletedData: LeaguesResultView){
        var tempLeague : FavouriteLeague?

        var favLeagues : [NSManagedObject] = []
        favLeagues = fetchFavouriteLeagues(fetchedData: &favLeagues)



        for l in favLeagues{
            if l.value(forKey: "leagueId") as? String == deletedData.id{
                tempLeague = l as? FavouriteLeague
            }

        }
        guard let temp = tempLeague else{
            return
        }

        deleteFavouriteLeague(deletedData: temp)
    }
    
    
    
    func searchForLeague(id: String) -> Bool{
        
        print("league's id from core data \(id)")
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteLeague")
        
        let myPredicate = NSPredicate(format: " leagueId == %@ ", id)
        fetchRequest.predicate = myPredicate
        
        do{
            let fetchedData = try managedContext.fetch(fetchRequest)
            if fetchedData.isEmpty{
                return false
            }
  
        }catch let error as NSError{
            print(error)
        }
        
        return true
    }
    
}
