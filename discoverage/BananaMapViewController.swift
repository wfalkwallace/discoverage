//
//  BananaMapViewController.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/14/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class BananaMapViewController: UIViewController, UITabBarDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tabBar: UITabBar!
    var bananaTrees:[BananaTree]?
    
    override func viewDidLoad() {
        bananaTrees = [BananaTree]()
        super.viewDidLoad()
        tabBar.selectedItem = tabBar.items![1] as? UITabBarItem
        //Location.sharedInstance.startUpdatingLocation()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateViews:", name:"updateViews", object: nil)
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        drawBananasOnMap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        if item.title == (tabBar.items![0] as! UITabBarItem).title {
            let menagerieStoryboard = UIStoryboard(name: "Menagerie", bundle: nil)
            let menagerieViewController = menagerieStoryboard.instantiateInitialViewController() as! UINavigationController
            self.presentViewController(menagerieViewController, animated: true, completion: nil)
        } else if item.title == (tabBar.items![2] as! UITabBarItem).title {
            let rankingStoryboard = UIStoryboard(name: "Ranking", bundle: nil)
            let rankingViewController = rankingStoryboard.instantiateInitialViewController() as! UINavigationController
            self.presentViewController(rankingViewController, animated: true, completion: nil)
        }
    }
    
    func drawBananasOnMap() {
        if let btree = self.bananaTrees {
            
            if let location = User.currentUser!.location {
            
                //region center on map
                let span = MKCoordinateSpanMake(0.05, 0.05)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                mapView.setRegion(region, animated: true)
            
                //3 pin the userLocation
                let userAnnotation = MKPointAnnotation()
                userAnnotation.setCoordinate(location.coordinate)
                userAnnotation.title = "Here's Waldo"
                mapView.addAnnotation(userAnnotation)
                
                
                //TODO draw the bananas
                //4 pin the rest of the locations
                for btree in self.bananaTrees! {
                    let ann = MKPointAnnotation()
                    ann.setCoordinate(btree.location.coordinate)
                    ann.title = "Banana"
                    mapView.addAnnotation(ann)
                }
            }
            
        }
    }
    
    func updateViews(object: AnyObject?) {
        println("location changed")
        
        //TODO banana trees near user
        Alamofire.request(Discoverage.Router.BananaTreesWithParams([:])).responseJSON { (_, _, data, error) in
            println(data)
            if error == nil {
                self.bananaTrees = BananaTree.initWithArray(data as! [NSDictionary])
                self.drawBananasOnMap()
            }
        }
    }

}
