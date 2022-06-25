//
//  LeaguesPresenter.swift
//  SportsApp
//
//  Created by n0shy on 20/06/2022.
//

import Foundation

class LeaguesPresenter
{
    var leaguesResult : [League]!
    let leaguesAPI : APIServiceProtocol = APIService()
    var myView : LeaguesProtocol!
    var leagueData : LeaguesResultView!
    var sportName : String!

    
    
    func attachView(view: LeaguesProtocol)
    {
        self.myView = view
    }
    
    func getLeagues()
    {
        leaguesAPI.fetchDataFromAPI(url: (Links.leagues.rawValue), param: ["s":sportName ?? ""], responseClass: LeaguesResult.self) { [weak self](leaguesResult,error) in
            self?.leaguesResult = leaguesResult?.countries
            DispatchQueue.main.async {
                self?.myView.reloadTableData()
                self?.myView.stopAnimator()
            }
        }
    }
    func setLeagueData(leagueData : LeaguesResultView){
        RouterDetails.presenter.leagueData = leagueData
    }
    
    
}
