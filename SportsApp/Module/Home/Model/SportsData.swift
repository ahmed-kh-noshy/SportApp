//
//  SportsData.swift
//  SportsApp
//
//  Created by n0shy on 20/06/2022.
//

import Foundation

class Sport : Decodable
{
    var idSport: String?
    var strSport: String?
    var strFormaz: String?
    var strSportThumb: String?
    var strSportIconGreen: String?
    
}

class SportsResult : Decodable
{
    var sports : [Sport]
}
