//
//  LeaguesData.swift
//  SportsApp
//
//  Created by n0shy on 20/06/2022.
//

import Foundation

class League: Decodable
{
    var idLeague : String?
    var strSport : String?
    var strBadge : String?
    var strLeague : String?
    var strLeagueAlternate : String?
    var strYoutube : String?
    
}

class LeaguesResult: Decodable {
    var countries : [League]
}
