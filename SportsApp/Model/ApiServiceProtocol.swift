//
//  ApiServiceProtocol.swift
//  SportsApp
//
//  Created by n0shy on 20/06/2022.
//

import Foundation
import Alamofire
protocol APIServiceProtocol {
    
    func fetchDataFromAPI<T: Decodable>(url: String,param: Parameters?, responseClass: T.Type, complitionHandler : @escaping (T?,Error?) -> Void)
}
