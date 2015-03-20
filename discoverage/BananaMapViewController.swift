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

let _ANNOTATE_DISTANCE_ = 300.0 //annotate if within this distance
let _CLAIM_DISTANCE = 10.0 //claim if within this distance

class BananaMapViewController: UIViewController, UITabBarDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tabBar: UITabBar!
    var bananaTrees:[BananaTree]?
    var animals:[Animal]?
    var lastLocation:CLLocation?
    
    override func viewDidLoad() {
        bananaTrees = [BananaTree]()
        super.viewDidLoad()
        
        tabBar.selectedItem = tabBar.items![1] as? UITabBarItem
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        
        let annotationsToRemove = mapView.annotations.filter { $0 !== self.mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove )
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        getBananasAndAnimals()
    }

    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        
        let spanX = 0.010
        let spanY = 0.010
        var newRegion = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        self.mapView.setRegion(newRegion, animated: true)
        self.lastLocation = userLocation.location
    }
    
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        self.annotateMapViewWithBananas()
        self.annotateMapViewWithAnimals()
    }
    
    func getBananasAndAnimals() {
        
        //TODO banana trees near user and animals near user and then draw the annotations
        Alamofire.request(Discoverage.Router.BananaTreesWithParams([:])).responseJSON { (_, _, data, error) in
            if error == nil {
                self.bananaTrees = BananaTree.initWithArray(data as! [NSDictionary])
                self.annotateMapViewWithBananas()
            }
        }
     
        Alamofire.request(Discoverage.Router.AnimalsWithParams([:])).responseJSON { (_, _, data, error) in
            if error == nil {
                self.animals = Animal.initWithArray(data as! [NSDictionary])
                println(data)
                self.annotateMapViewWithAnimals()
            }
        }

        
    }
    
    func annotateMapViewWithAnimals() {
        
        //3 cases
        // 1. If bananas are < 100 meters away annotate them on the map
        // 2. if bananas are < 5 meters away add them to users banana count and remove annotation
        // 3. if bananas are > 100 meters away remove the annotation
        
        //case #1
        if let animals = self.animals {
            for entity in animals {
                let location = entity.location as CLLocation
                let distance = self.lastLocation?.distanceFromLocation(location)
                if distance < _ANNOTATE_DISTANCE_ {
                    let ann = MKPointAnnotation()
                    ann.setCoordinate(location.coordinate)
                    ann.title = entity.sprite
                    mapView.addAnnotation(ann)
                }
            }
        }
        
        //case 2,3
        updateExistingAnnotations()
    }

    func annotateMapViewWithBananas() {
    
        //3 cases
        // 1. If bananas are < 100 meters away annotate them on the map
        // 2. if bananas are < 5 meters away add them to users banana count and remove annotation
        // 3. if bananas are > 100 meters away remove the annotation
        
        //case #1
        if let btrees = self.bananaTrees {
            for entity in btrees {
                let location = entity.location as CLLocation
                let distance = self.lastLocation?.distanceFromLocation(location)
                if distance < _ANNOTATE_DISTANCE_ {
                    let ann = MKPointAnnotation()
                    ann.setCoordinate(location.coordinate)
                    ann.title = "Banana"
                    mapView.addAnnotation(ann)
                }
            }
        }
        
        //case 2,3
        updateExistingAnnotations()
    }
 
    func updateExistingAnnotations() {
        
        //case #2,#3
        let annotations = mapView.annotations.filter { $0 !== self.mapView.userLocation }
        for annotation in annotations {
            let annotation = annotation as! MKPointAnnotation
            let location = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            let distance = self.lastLocation?.distanceFromLocation(location)
            //println(distance)
            if (distance > _ANNOTATE_DISTANCE_) {
                self.mapView.removeAnnotation(annotation as? MKAnnotation)
            } else if (distance < _CLAIM_DISTANCE) {
                //call delegate, or send notification
                self.mapView.removeAnnotation(annotation as? MKAnnotation)
            }
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if annotation.title! == "Banana" {
            let view = MKAnnotationView()
            view.image = UIImage(named: "banana")
            return view
        } else if (annotation.title == "Current Location") {
            return nil;
        } else  {
            let view = MKAnnotationView()
            let image = annotation.title!
            view.image = UIImage(named: image!)
            return view
        }
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
