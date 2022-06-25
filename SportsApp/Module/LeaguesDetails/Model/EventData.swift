//
//  EventData.swift
//  SportsApp
//
//  Created by n0shy on 22/06/2022.
//

import Foundation

class Event : Decodable{
    var idEvent: String!
    //p1
    var strEvent: String!
    var strFilename: String!
    var strSport: String!
    var idLeague: String!
    var strLeague: String!
    var strSeason: String!
    var strHomeTeam: String!
    var strAwayTeam: String!
    var intHomeScore: String!
    var intAwayScore: String!
    var strTimestamp: String!
    //p1 Ex:2021-09-18
    var dateEvent: String!
    var dateEventLocal: String!
    //p1 Ex: 18:30:00
    var strTime: String!
    var strTimeLocal: String!
    var idHomeTeam: String!
    var idAwayTeam: String!
    var strCountry: String!
    var strThumb: String!
    var strStatus: String!
}

class EventsResult : Decodable{
    var events : [Event]!
}
