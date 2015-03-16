//
//  DiscoverageClient.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/15/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit
import Alamofire

struct Discoverage {
    
    enum Router: URLRequestConvertible {
        static let baseURLString = "https://discoverage.herokuapp.com"
        
        case Animal([String: AnyObject])
        case Animals(String)
        case AnimalsForUser(String)
        case AnimalsNear([String: AnyObject])
        case User([String: AnyObject])
        case Users(String)
        case BananaPick([String: AnyObject])
        case BananaPicks(String)
        case BananaPicksForUser(String)
        case BananaTree([String: AnyObject])
        case BananaTrees(String)
        case BananaTreesNear([String: AnyObject])
        
        
        var method: Alamofire.Method {
            switch self {

            case .Animal:
                return .POST
            case .Animals:
                return .GET
            case .Animals:
                return .GET
            case .AnimalsForUser:
                return .GET
            case .AnimalsNear:
                return .GET
            case .User:
                return .POST
            case .Users:
                return .GET
            case .Users:
                return .GET
            case .BananaPick:
                return .POST
            case .BananaPicks:
                return .GET
            case .BananaPicks:
                return .GET
            case .BananaPicksForUser:
                return .GET
            case .BananaTree:
                return .POST
            case .BananaTrees:
                return .GET
            case .BananaTrees:
                return .GET
            case .BananaTreesNear:
                return .GET
                
            }
        }
        
        var path: String {
            switch self {
            case .Animal:
                return "/animal"
            case .Animals(let id):
                return "/animals/\(id)"
            case .AnimalsForUser(let id):
                return "/animals/user/\(id)"
            case .AnimalsNear:
                return "/animals/near"
            case .User:
                return "/user"
            case .Users(let id):
                return "/users/\(id)"
            case .BananaPick:
                return "/bananapick"
            case .BananaPicks(let id):
                return "/bananapicks/\(id)"
            case .BananaPicksForUser(let id):
                return "/bananapicks/user/\(id)"
            case .BananaTree:
                return "/bananatree"
            case .BananaTrees(let id):
                return "/bananatrees/\(id)"
            case .BananaTreesNear:
                return "/bananatrees"
            }
        }
        
        
        var URLRequest: NSURLRequest {
            let URL = NSURL(string: Router.baseURLString)!
            let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
            mutableURLRequest.HTTPMethod = method.rawValue
            
            switch self {
            case Animal(let params):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            case AnimalsNear(let params):
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
            case User(let params):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            case BananaPick(let params):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            case BananaTree(let params):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            case BananaTreesNear(let params):
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
            default:
                return mutableURLRequest
                
            }
        }
        
    }
}
