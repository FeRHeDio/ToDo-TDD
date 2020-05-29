//
//  Location.swift
//  ToDo
//
//  Created by Fernando Putallaz on 18/05/2020.
//  Copyright © 2020 myOwn. All rights reserved.
//

import Foundation
import CoreLocation

struct Location: Equatable {
    
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        
        if lhs.coordinate?.latitude != rhs.coordinate?.latitude {
            return false
        }
        
        if lhs.coordinate?.longitude != rhs.coordinate?.longitude {
            return false
        }
        
        if lhs.name != rhs.name {
            return false
        }

        return true
    }

}
