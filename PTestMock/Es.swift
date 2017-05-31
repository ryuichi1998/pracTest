//
//  Es.swift
//  PTestMock
//
//  Created by ITP312 on 31/5/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class Es: NSObject {
    
    var name: String
    var population: Int
    var latitude: Double
    var longtitude: Double
    
    init(name: String, population: Int, latitude: Double, longtitude: Double) {
        self.name = name;
        self.population = population;
        self.latitude = latitude;
        self.longtitude = longtitude;
        
        super.init()
    }

}
