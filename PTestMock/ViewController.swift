//
//  ViewController.swift
//  PTestMock
//
//  Created by ITP312 on 31/5/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var sizeSegment: UISegmentedControl!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var estateList: [Es] = []
    
    var locationManager :CLLocationManager?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        locationManager = CLLocationManager();
        locationManager?.delegate = self;
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest;
        let ios8 = locationManager?.responds(to:
            #selector(CLLocationManager.requestWhenInUseAuthorization))
        if (ios8!) {
            locationManager?.requestWhenInUseAuthorization();
        }
        locationManager?.startUpdatingLocation();
    }
    
    var lastLocationUpdateTime : Date = Date()
    
    // This function receives information about the change of the
    // user’s GPS location. The locations array may contain one
    // or more location updates that were collected in-between calls
    // to this function.
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        // There are multiple locations, but we are only
        // interested in the last one.
        let newLocation = locations.last!;
        // Get find out how old (in seconds) this data was.
        let howRecent =
            self.lastLocationUpdateTime.timeIntervalSinceNow;
        // Handle only recent events to save power.
        if (abs(howRecent) > 15)
        {
            print("Longitude = \(newLocation.coordinate.longitude)");
            print("Latitude = \(newLocation.coordinate.latitude)");
            self.lastLocationUpdateTime = Date()
        }
    }
    
    // This funcion is triggered if the location manager was unable
    // to retrieve a location.
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("Could not find location: \(error)");
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let url = "http://crowd.sit.nyp.edu.sg/itp312_2017s1/estate/list"
        
        HTTP.postJSON(
            url: url,             // The URL to post to
            json: JSON.init([]), // Pass in an empty JSON object
            onComplete:
            {
                json, response, error in
                        
                // This is what will happen after the download
                // from the server is complete
                        
                if (json != nil)
                {
                    // Print the downloaded JSON to console
                    print (json!.rawString()!)
                }
                
                })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
