//
//  HomePresenter.swift
//  SportsApp
//
//  Created by n0shy on 20/06/2022.
//

import Foundation

class HomePresenter
{
    
    var sportsResult : [Sport]!
    var sportsAPI : APIServiceProtocol = APIService()
    var myView : HomeProtocol!
    
    func attachView(view: HomeProtocol){
        self.myView = view
    }
    
    func getSports()
    {
        sportsAPI.fetchDataFromAPI(url: Links.sports.rawValue, param: nil, responseClass: SportsResult.self) { [weak self](sportsResult, error) in
            self?.sportsResult = sportsResult!.sports
            DispatchQueue.main.async {
                self?.myView.reloadCollectionData()
                self?.myView.stopAnimator()
            }
        }
    }
    func setSportName(sportName : String){
        RouterClass.presenter.sportName = sportName
        
    }
}
