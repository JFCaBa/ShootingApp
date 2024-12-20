//
//  PlayerAnnotation.swift
//  ShootingApp
//
//  Created by Jose on 27/10/2024.
//

import MapKit

final class PlayerAnnotation: MKPointAnnotation {
    // MARK: - constants
    
    let playerId: String
    let heading: Double
    let timestamp: Date
    
    // MARK: - init(playerId:, heading:, timestamp:)
    
    init(playerId: String, heading: Double, timestamp: Date) {
        self.playerId = playerId
        self.heading = heading
        self.timestamp = timestamp
        super.init()
    }
}
