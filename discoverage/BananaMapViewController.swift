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

class BananaMapViewController: UIViewController, UITabBarDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tabBar: UITabBar!
    var bananaTrees:[BananaTree]?
    var lastLocation:CLLocation?
    
    
    override func viewDidLoad() {
        bananaTrees = [BananaTree]()
        super.viewDidLoad()
        
        tabBar.selectedItem = tabBar.items![1] as? UITabBarItem
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        Location.sharedInstance.startUpdatingLocation()
        
    }

    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        println(userLocation.location)
        println("user location ")
        
        let spanX = 0.007
        let spanY = 0.007
        var newRegion = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        
        //TODO banana trees near user and animals near user and then draw the annotations
        Alamofire.request(Discoverage.Router.BananaTreesWithParams([:])).responseJSON { (_, _, data, error) in
            //println(data)
            if error == nil {
                self.bananaTrees = BananaTree.initWithArray(data as! [NSDictionary])
                //annotate bananas
            }
        }
        
        //TODO change this to draw the annotations in the block above
        
        var lat =  37.76157
        var lon = -122.419065
        
        let loc = CLLocation(latitude: lat, longitude: lon)
        
        let ann = MKPointAnnotation()
        ann.setCoordinate(loc.coordinate)
        ann.title = "Banana"
        mapView.addAnnotation(ann)
        

        lat = 37.760591
        lon = -122.419613
        
        let loc2 = CLLocation(latitude: lat, longitude: lon)
        let ann2 = MKPointAnnotation()
        ann2.setCoordinate(loc2.coordinate)
        ann2.title = "Animal"
        mapView.addAnnotation(ann2)

    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        println(annotation.title)
        
        if annotation.title! == "Banana" {
            let view = MKAnnotationView()
            view.image = UIImage(named: "banana")
            return view
        } else if (annotation.title == "Current Location") {
            return nil;
        } else  if (annotation.title == "Animal") {
            let view = MKAnnotationView()
            view.image = UIImage(named: "7_squirtle")
            return view
        }
        return MKAnnotationView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //drawBananasOnMap()
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

}
