//
//  FavouritesPresenter.swift
//  SportsApp
//
//  Created by n0shy on 21/06/2022.
//

import Foundation
import CoreData

class favouritesPresenter{
    var myView : FavouritesProtocol!
    var favourites : [NSManagedObject] = []
    var coredataManager : CoredataManagerVSFavourites = CoredataManager()
        
    
    func attachView(view: FavouritesProtocol)
    {
        self.myView = view
    }
    
    func fetchFavouritesData(){
        favourites = coredataManager.fetchFavouriteLeagues(fetchedData: &favourites)
    }
    
    func checkInternetConnection(){
        
        
    }
    
    func setLeagueData(leagueData : LeaguesResultView){
        RouterDetails.presenter.leagueData = leagueData
    }
}
