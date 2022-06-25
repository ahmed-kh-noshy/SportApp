//
//  LeaguesDetailsPresenter.swift
//  SportsApp
//
//  Created by n0shy on 22/06/2022.
//

import Foundation
import CoreData

class LeaguesDetailsPresenter {
    var leagueData : LeaguesResultView!
    var dataAPI : APIServiceProtocol = APIService()
    var eventsResult : [Event]?
    var upcomingResult : [Event]!
    var latestResult : [Event]!
    var teamsResult : [Team]!
    var myView : LeaguesDetailsProtocol!
    var coredataManager : CoredataManagerVSLeagues = CoredataManager()
    
    func attachView(view: LeaguesDetailsProtocol)
    {
        self.myView = view
    }
    
    func getEvents()
    {
        dataAPI.fetchDataFromAPI(url: (Links.events.rawValue), param: ["id":leagueData.id ], responseClass: EventsResult.self) { [weak self](eventsResult,error) in
            self?.eventsResult = eventsResult?.events
            DispatchQueue.main.async {
                self?.filterEventsBasedOnDate(eventsResult: self?.eventsResult)
                self?.myView.reloadupComingCollectionData()
                self?.myView.reloadLatestCollectionData()
                //self?.myView.stopAnimator()
        
            }
        }
    }
    
    func getTeams()
    {
        dataAPI.fetchDataFromAPI(url: (Links.teams.rawValue), param: ["l":leagueData.name ], responseClass: TeamsResult.self) { [weak self](teamsResult, error) in
            self?.teamsResult = teamsResult?.teams
            DispatchQueue.main.async {
                self?.myView.reloadTeamsCollectionData()
                self?.myView.stopAnimator()
            }
        }
    }
    
    func prepareLeagueName(leagueName: String) -> String {
        return leagueName.replacingOccurrences(of: " ", with: "_")
    }
    
    func filterEventsBasedOnDate(eventsResult: [Event]!){
        upcomingResult = []
        latestResult = []
        for item in eventsResult ?? []{
            var apiDate = item.strTimestamp ?? ""
            
            apiDate = apiDate.replacingOccurrences(of: "T", with: " ")
            apiDate = apiDate.replacingOccurrences(of: "+00:00", with: "+0000")
            //print("apiDate \(apiDate)")

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ssZ"
            dateFormatter.timeZone = TimeZone(identifier: "GMT")
            let currentDate = dateFormatter.string(from: Date())
            //print("current data \(currentDate)")


            if apiDate >= currentDate{
                //print("Upcoming")
                upcomingResult.append(item)
            }
            else if apiDate < currentDate{
                //print("Latest")
                latestResult.append(item)
            }
        }
//        print("count of all \(eventsResult.count)")
//        print("upcoming count \(upcomingResult.count)")
//        print("latest count \(latestResult.count)")
    }
    

    func setSelectedTeam(selectedTeamIndex: Int) {
        let team = teamsResult[selectedTeamIndex]
        RouterTeamDetails.presenter.selectedTeam = team
        
    }
    
    func checkIfFavourite(){
        if coredataManager.searchForLeague(id: leagueData.id){
            print("favourit league")
        }
        else{
            print("unfavourite league")
        }
        print("league's id from presenter \(leagueData.id)")
        
        myView.setupHeartIcon(flag: coredataManager.searchForLeague(id: leagueData.id))
    }
    
    func addFavouriteLeague(){
        
        print("2-leagues details presenter call the add func from coredata with id \(leagueData.id)")

        coredataManager.storeFavouriteLeague(data: leagueData)
        print("3-the heart become red")

        myView.setupHeartIcon(flag: true)
    }
    
    func deleteFavouriteLeague(){
        
        coredataManager.deleteFavouriteLeague(deletedData: leagueData)
        myView.setupHeartIcon(flag: false)
    }
    
}
