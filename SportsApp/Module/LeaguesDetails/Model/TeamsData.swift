//
//  TeamsData.swift
//  SportsApp
//
//  Created by n0shy on 22/06/2022.
//

import Foundation

class Team : Decodable{
    var idTeam: String?
    var strTeam: String?
    var strTeamShort: String?
    var intFormedYear: String?
    var strSport: String?
    var strLeague: String?
    var idLeague: String?
    var strStadium: String?
    var strStadiumDescription: String?
    var strStadiumLocation: String?
    var intStadiumCapacity: String?
    var strWebsite: String?
    var strFacebook: String?
    var strTwitter: String?
    var strInstagram: String?
    var strDescriptionEN: String?
    var strGender: String?
    var strCountry: String?
    var strTeamBadge: String?
}

class TeamsResult : Decodable {
    var teams : [Team]?
}
