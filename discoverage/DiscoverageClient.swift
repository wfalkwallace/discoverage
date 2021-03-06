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
        
        case Login(String, String)
        case Update([User], [BananaPick], [Animal])
        case ItemsNear([String: AnyObject])

        case AnimalsNear([String: AnyObject])
        case AnimalCreate([String: AnyObject])
        case AnimalUpdate(String, [String: AnyObject])
        case AnimalWithId(String)
        case AnimalsWithParams([String: AnyObject])

        case UserCreate([String: AnyObject])
        case UserUpdate(String, [String: AnyObject])
        case UsersWithParams([String: AnyObject])
        case UsersNear([String: AnyObject])
        case UsersRanked()
        case UserWithId(String)

        case BananaPickCreate([String: AnyObject])
        case BananaPicksWithParams([String: AnyObject])
        case BananaPickWithId(String)

        case BananaTreesNear([String: AnyObject])
        case BananaTreeWithId(String)
        case BananaTreesWithParams([String: AnyObject])

        var method: Alamofire.Method {
            switch self {
            case .Login, .Update, .AnimalCreate, .AnimalUpdate, .UserCreate, .UserUpdate, .BananaPickCreate:
                return .POST
                
            case .ItemsNear, .AnimalsNear, .AnimalWithId, .AnimalsWithParams, .UsersWithParams, .UsersRanked, .UsersNear, .UserWithId, .BananaPicksWithParams, .BananaPickWithId, .BananaTreesNear, .BananaTreeWithId, .BananaTreesWithParams:
                return .GET
            }
        }

        var path: String {
            switch self {
            case .Login(_, _):
                return "/login"
            case .Update(_, _, _):
                return "/update"
            case .ItemsNear(_):
                return "/items/near"
                
            case .AnimalsNear(_):
                return "/animals/near"
            case .AnimalCreate(_):
                return "/animal/"
            case .AnimalUpdate(let id, let _):
                return "/animal/\(id)"
            case .AnimalWithId(let id):
                return "/animals/\(id)"
            case .AnimalsWithParams(_):
                return "/animals"

            case .UserCreate(_):
                return "/user"
            case .UserUpdate(let id, _):
                return "/user/\(id)"
            case .UsersWithParams(_):
                return "/users"
            case .UsersNear(_):
                return "/users/near"
            case .UsersRanked():
                return "/users/ranked"
            case .UserWithId(let id):
                return "/users/\(id)"

            case .BananaPickCreate(_):
                return "/bananaPick"
            case .BananaPicksWithParams(_):
                return "/bananaPicks"
            case .BananaPickWithId(let id):
                return "/bananaPicks/\(id)"

            case .BananaTreesNear(_):
                return "/bananatrees/near"
            case .BananaTreeWithId(let id):
                return "/bananatrees/\(id)"
            case .BananaTreesWithParams(_):
                return "/bananatrees"
            }
        }


        var URLRequest: NSURLRequest {
            let URL = NSURL(string: Router.baseURLString)!
            let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
            mutableURLRequest.HTTPMethod = method.rawValue

            switch self {
            case .Login(let email, let password):
                var params = [String: AnyObject]()
                params["email"] = email
                params["password"] = password
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0

            case .Update(let users, let bananaPicks, let animals):
                var params = [String: AnyObject]()
                params["token"] = User.currentUser?.token
                params["users"] = users.map({ $0.serialize() })
                params["bananaPicks"] = bananaPicks.map({ $0.serialize() })
                params["animals"] = animals.map({ $0.serialize() })
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            case .ItemsNear(let params):
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0

                
            case .AnimalsNear(let params):
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
            case .AnimalCreate(let params):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            case .AnimalUpdate(_, let params):
                var paramsWithToken = params
                paramsWithToken["token"] = User.currentUser?.token
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: paramsWithToken).0
            case .AnimalsWithParams(let params):
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0

            case .UserCreate(let params):
                var paramsWithToken = params
                paramsWithToken["token"] = User.currentUser?.token
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: paramsWithToken).0
            case .UserUpdate(_, let params):
                var paramsWithToken = params
                paramsWithToken["token"] = User.currentUser?.token
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: paramsWithToken).0
            case .UsersNear(let params):
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
            case .UsersWithParams(let params):
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0

            case .BananaPickCreate(let params):
                var paramsWithToken = params
                paramsWithToken["token"] = User.currentUser?.token
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: paramsWithToken).0
            case .BananaPicksWithParams(let params):
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0

            case .BananaTreesNear(let params):
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
            case .BananaTreesWithParams(let params):
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0

            default:
                // these are the "WithId" requests that take no params
                return mutableURLRequest
            }
        }
        
    }
}
