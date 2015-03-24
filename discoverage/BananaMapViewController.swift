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

let BANANA_VISIBILITY_RADIUS = 1000.0 //annotate if within this distance
let ANIMAL_VISIBILITY_RADIUS = 200.0 //annotate if within this distance

struct BananaClaim  {
    var btree : BananaTree
    var claimed: Bool
}

struct AnimalClaim  {
    var animal : Animal
    var claimed: Bool
}

class BananaMapViewController: UIViewController, MKMapViewDelegate, LocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var bananaTrees:[BananaClaim]?
    var animals:[AnimalClaim]?
    var lastLocation:CLLocation?
        
    override func viewDidLoad() {
        bananaTrees = [BananaClaim]()
        animals = [AnimalClaim]()
        super.viewDidLoad()
        
        let annotationsToRemove = mapView.annotations.filter { $0 !== self.mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove )
        LocationManager.sharedInstance.delegate = self
        self.mapView.delegate = self
        getBananasAndAnimals()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.mapView.showsUserLocation = true
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.mapView.showsUserLocation = false
    }

    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
       
        let location = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let spanX = 0.001
        let spanY = 0.001
        if let distance = self.lastLocation?.distanceFromLocation(location) {
            if distance > 20 {
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
                        if distance < ANIMAL_VISIBILITY_RADIUS {
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
                        if distance < BANANA_VISIBILITY_RADIUS {
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
                let fromDistance = (annotation.title == "Banana") ? BANANA_VISIBILITY_RADIUS : ANIMAL_VISIBILITY_RADIUS
                if (distance > fromDistance) {
                    self.mapView.removeAnnotation(annotation as? MKAnnotation)
                } else if (distance < CAPTURE_RADIUS) {
                    self.mapView.removeAnnotation(annotation as? MKAnnotation)
                    //claim(location)
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
    
    
    func locationManager(locationManagerDelegate: LocationManager, didCaptureBananas bananaPicks: [BananaPick], didCaptureAnimals animals: [Animal])    {
     
        for animal in animals {
            claim(animal.location)
        }
        
        for banana in bananaPicks {
            claim(banana.bananaTree.location)
        }
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

}
