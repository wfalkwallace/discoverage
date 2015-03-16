//
//  DiscoverageClient.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/15/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit
import AlamoFire

struct Discoverage {
    
    enum Router: URLRequestConvertible {
        static let baseURLString = "https://discoverage.herokuapp.com"
        
        case Animals()
        case Animals(String)
        case AnimalsForUser(String)
        case AnimalsNear(Float, Float)
        case Users()
        case Users(String)
        case BananaPicks()
        case BananaPicks(String)
        case BananaPicksForUser(String)
        case BananaTrees()
        case BananaTrees(String)
        case BananaTreesNear(Float, Float)
        
        var URLRequest: NSURLRequest {
            let (path: String, parameters: [String: AnyObject]) = {
                switch self {
                    
                case .Animals():
                    let params = []
                    return ("/animals", params)
                case .Animals(let id):
                    let params = []
                    return ("/animals/\(id)", params)
                case .AnimalsForUser(let id):
                    let params = []
                    return ("/animals/user/\(id)", params)
                case .AnimalsNear(let lat, let lon):
                    let params = ["lat": "\(lat)", "lon": "\(lon)"]
                    return ("/animals/near", params)
                case .Users():
                    let params = []
                    return ("/users", params)
                case .Users(let id):
                    let params = []
                    return ("/users/\(id)", params)
                case .BananaPicks():
                    let params = []
                    return ("/bananapicks", params)
                case .BananaPicks(let id):
                    let params = []
                    return ("/bananapicks/\(id)", params)
                case .BananaPicksForUser(let id):
                    let params = []
                    return ("/bananapicks/user/\(id)", params)
                case .BananaTrees():
                    let params = []
                    return ("/bananatrees", params)
                case .BananaTrees(let id):
                    let params = []
                    return ("/bananatrees/\(id)", params)
                case .BananaTreesNear(let lat, let lon):
                    let params = ["lat": "\(lat)", "lon": "\(lon)"]
                    return ("/bananatrees", params)
                }
                }()
            
            let URL = NSURL(string: Router.baseURLString)
            let URLRequest = NSURLRequest(URL: URL!.URLByAppendingPathComponent(path))
            let encoding = Alamofire.ParameterEncoding.URL
            
            return encoding.encode(URLRequest, parameters: parameters).0
        }
    }
}
