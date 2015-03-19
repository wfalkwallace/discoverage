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
        
        case Login(String, String, String)
        case Update([User], [BananaPick], [Animal])

        case AnimalsNear([String: AnyObject])
        case AnimalUpdate(String, [String: AnyObject])
        case AnimalWithId(String)
        case AnimalsWithParams([String: AnyObject])

        case UserCreate([String: AnyObject])
        case UserUpdate(String, [String: AnyObject])
        case UsersWithParams([String: AnyObject])
        case UserWithId(String)

        case BananaPickCreate([String: AnyObject])
        case BananaPicksWithParams([String: AnyObject])
        case BananaPickWithId(String)

        case BananaTreesNear([String: AnyObject])
        case BananaTreeWithId(String)
        case BananaTreesWithParams([String: AnyObject])

        var method: Alamofire.Method {
            switch self {
            case .Login, .Update, .AnimalUpdate, .UserCreate, .UserUpdate, .BananaPickCreate:
                return .POST
                
            case .AnimalsNear, .AnimalWithId, .AnimalsWithParams, .UsersWithParams, .UserWithId, .BananaPicksWithParams, .BananaPickWithId, .BananaTreesNear, .BananaTreeWithId, .BananaTreesWithParams:
                return .GET
            }
        }

        var path: String {
            switch self {
            case .Login(_, _, _):
                return "/login"
            case .Update(_, _, _):
                return "/update"

            case .AnimalsNear(_):
                return "/animals/near"
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
            case .Login(let username, let email, let password):
                var params = [String: AnyObject]()
                params["name"] = username
                params["email"] = email
                params["password"] = password
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0

            case .Update(let users, let bananaPicks, let animals):
                var params = [String: AnyObject]()
                params["users"] = users
                params["bananaPicks"] = bananaPicks
                params["animals"] = animals
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0

            case .AnimalsNear(let params):
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
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
