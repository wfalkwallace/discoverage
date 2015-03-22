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

let _ANNOTATE_BANANA_DISTANCE_ = 1000.0 //annotate if within this distance
let _ANNOTATE_ANIMAL_DISTANCE_ = 200.0 //annotate if within this distance

let _CLAIM_DISTANCE = 10.0 //claim if within this distance

struct BananaClaim  {
    var btree : BananaTree
    var claimed: Bool
}

struct AnimalClaim  {
    var animal : Animal
    var claimed: Bool
}


class BananaMapViewController: UIViewController, UITabBarDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tabBar: UITabBar!
    var bananaTrees:[BananaClaim]?
    var animals:[AnimalClaim]?
    var lastLocation:CLLocation?
    
    var delegate:BananaMapViewControllerDelegate?
    
    override func viewDidLoad() {
        bananaTrees = [BananaClaim]()
        animals = [AnimalClaim]()
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
        
        let spanX = 0.01
        let spanY = 0.01
        
        //dont change region unless user location
        

        let location = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)

        if let distance = self.lastLocation?.distanceFromLocation(location) {

            if distance > 10 {
                var newRegion = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
                self.mapView.setRegion(newRegion, animated: true)
                self.lastLocation = userLocation.location
            }
        } else {
            var newRegion = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
            self.mapView.setRegion(newRegion, animated: true)
            self.lastLocation = userLocation.location
        }
    }
    
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        
        if self.animals!.count > 0 {
            self.annotateMapViewWithAnimals()
        }
        
        if self.bananaTrees!.count > 0 {
            self.annotateMapViewWithBananas()
        }
    }
    
    func getBananasAndAnimals() {
        
        //TODO banana trees near user and animals near user and then draw the annotations
        Alamofire.request(Discoverage.Router.BananaTreesWithParams([:])).responseJSON { (_, _, data, error) in
            if error == nil {
                let btrees = BananaTree.initWithArray(data as! [NSDictionary])
                for btree in btrees {
                    self.bananaTrees?.append(BananaClaim(btree: btree, claimed: false))
                    self.annotateMapViewWithBananas()
                }
            }
        }
     
        Alamofire.request(Discoverage.Router.AnimalsWithParams([:])).responseJSON { (_, _, data, error) in
            if error == nil {
                let animals = Animal.initWithArray(data as! [NSDictionary])
                for animal in animals {
                    self.animals?.append(AnimalClaim(animal: animal, claimed: false))
                    self.annotateMapViewWithAnimals()
                }
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
            
            for index in 0...(animals.count-1) {
                let entity = animals[index]
                if entity.claimed == false {
                    let location = entity.animal.location as CLLocation
                    if let distance = self.lastLocation?.distanceFromLocation(location) {
                        if distance < _ANNOTATE_ANIMAL_DISTANCE_ {
                            let ann = MKPointAnnotation()
                            ann.setCoordinate(location.coordinate)
                            ann.title = entity.animal.sprite
                            mapView.addAnnotation(ann)
                        }
                    }
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
        
        
        if let btrees = self.bananaTrees {
            for index in 0...(btrees.count-1) {
                let entity = btrees[index]
                if entity.claimed == false {
                    let location = entity.btree.location as CLLocation
                    if let distance = self.lastLocation?.distanceFromLocation(location) {
                        if distance < _ANNOTATE_BANANA_DISTANCE_ {
                            let ann = MKPointAnnotation()
                            ann.setCoordinate(location.coordinate)
                            ann.title = "Banana"
                            mapView.addAnnotation(ann)
                        }
                    }
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
            if let distance = self.lastLocation?.distanceFromLocation(location) {
                //println(distance)
                let fromDistance = (annotation.title == "Banana") ? _ANNOTATE_BANANA_DISTANCE_ : _ANNOTATE_ANIMAL_DISTANCE_
                if (distance > fromDistance) {
                    self.mapView.removeAnnotation(annotation as? MKAnnotation)
                } else if (distance < _CLAIM_DISTANCE) {
                    self.mapView.removeAnnotation(annotation as? MKAnnotation)
                    claim(location)
               
                }
            }
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if annotation.title! == "Banana" {
            let view = MKAnnotationView()
            view.image = UIImage(named: "banana")
            view.sizeToFit()
            view.frame = CGRect(x: 0, y:0 , width: 48, height: 48)
            return view
        } else if (annotation.title == "Current Location") {
            return nil;
        } else  {
            let view = MKAnnotationView()
            let image = annotation.title!
            view.image = UIImage(named: image!)
            view.sizeToFit()
            view.frame = CGRect(x: 0, y:0 , width: 96, height: 96)
            return view
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func claim(location : CLLocation) {
        
        if let btrees = self.bananaTrees {
            if btrees.count > 0 {
                for index in 0...(btrees.count-1) {
                    let entity = btrees[index]
                    if entity.btree.location.coordinate.latitude == location.coordinate.latitude && entity.btree.location.coordinate.longitude == location.coordinate.longitude {
                        self.bananaTrees![index] = BananaClaim(btree: entity.btree, claimed: true)
                    }
                }
            }
        }
        
        if let animals = self.animals {
            if animals.count > 0 {
                for index in 0...(animals.count-1) {
                    let entity = animals[index]
                    if entity.animal.location.coordinate.latitude == location.coordinate.latitude && entity.animal.location.coordinate.longitude == location.coordinate.longitude {
                        self.animals![index] = AnimalClaim(animal: entity.animal, claimed: true)
                    }
                }
            }
        }
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        if item.title == (tabBar.items![0] as! UITabBarItem).title {
            let menagerieStoryboard = UIStoryboard(name: "Menagerie", bundle: nil)
            let menagerieViewController = menagerieStoryboard.instantiateInitialViewController() as! UINavigationController
            //TODO: update model here and present VC in block
            self.presentViewController(menagerieViewController, animated: true, completion: nil)
        } else if item.title == (tabBar.items![2] as! UITabBarItem).title {
            let rankingStoryboard = UIStoryboard(name: "Ranking", bundle: nil)
            let rankingViewController = rankingStoryboard.instantiateInitialViewController() as! UINavigationController
                //TODO: update model here and present VC in block
            self.presentViewController(rankingViewController, animated: true, completion: nil)
        }
    }

}
