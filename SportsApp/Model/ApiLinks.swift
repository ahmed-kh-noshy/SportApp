//
//  ApiLinks.swift
//  SportsApp
//
//  Created by n0shy on 20/06/2022.
//

import Foundation

enum Links : String{
    case sports = "https://www.thesportsdb.com/api/v1/json/2/all_sports.php"
    case leagues = "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php"
    case events = "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id=4617"
    case teams = "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=English%20Premier%20League"
}
