//
//  GeoARNodeFactory.swift
//  ShootingApp
//
//  Created by Jose on 19/12/2024.
//


import SceneKit
import CoreLocation

final class GeoARNodeFactory {
    static func createNode(for geoObject: GeoObject, location: SCNVector3) -> GeoARNode {
        let node = GeoARNode(
            id: geoObject.id,
            coordinate: geoObject.coordinate.toCLLocationCoordinate2D(),
            altitude: geoObject.coordinate.altitude
        )
        
        // Configure the node based on type
        switch geoObject.type {
        case .weapon:
            configureWeapon(node, location)
        case .target:
            configureTargetNode(node, location)
        case .powerup:
            configurePowerupNode(node, location)
        default:
            configurePowerupNode(node, location)
        }
        
        // Add metadata
        node.name = geoObject.id
        
        return node
    }
    
    private static func configureWeapon(_ node: GeoARNode, _ location: SCNVector3) {
        guard let scene = SCNScene(named: "weapon.scn") else {
            // Fallback to basic geometry if the model fails to load
            let geometry = SCNBox(width: 0.3, height: 0.3, length: 0.3, chamferRadius: 0.05)
            geometry.firstMaterial?.diffuse.contents = UIColor.yellow
            node.geometry = geometry
            return
        }
        
        // Extract the root node from the loaded scene
        guard let modelNode = scene.rootNode.childNodes.first else { return }
        
        // Scale the model appropriately
        modelNode.scale = SCNVector3(0.1, 0.1, 0.1)
        modelNode.position = location
        
        node.addChildNode(modelNode)
        
        // Add pulsing animation
        let pulseAction = SCNAction.sequence([
            SCNAction.scale(to: 1.2, duration: 1.0),
            SCNAction.scale(to: 1.0, duration: 1.0)
        ])
        node.runAction(SCNAction.repeatForever(pulseAction))
    }
    
    private static func configureTargetNode(_ node: GeoARNode, _ location: SCNVector3) {
        let geometry = SCNSphere(radius: 3)
        geometry.firstMaterial?.diffuse.contents = UIColor.red
        node.geometry = geometry
        node.position = location
        
        // Add pulsing animation
        let pulseAction = SCNAction.sequence([
            SCNAction.scale(to: 1.2, duration: 1.0),
            SCNAction.scale(to: 1.0, duration: 1.0)
        ])
        node.runAction(SCNAction.repeatForever(pulseAction))
    }
    
    private static func configurePowerupNode(_ node: GeoARNode, _ location: SCNVector3) {
        guard let scene = SCNScene(named: "weapons_crate.scn") else {
            // Fallback to basic geometry if the model fails to load
            let geometry = SCNBox(width: 0.3, height: 0.3, length: 0.3, chamferRadius: 0.05)
            geometry.firstMaterial?.diffuse.contents = UIColor.yellow
            node.geometry = geometry
            return
        }
                
        // Extract the root node from the loaded scene
        guard let modelNode = scene.rootNode.childNodes.first else { return }
        
        // Scale the model appropriately
        modelNode.scale = SCNVector3(0.2, 0.2, 0.2)
        modelNode.position = location

        // Add the model as a child of the GeoARNode
        node.addChildNode(modelNode)
        
        // Add pulsing animation
        let pulseAction = SCNAction.sequence([
            SCNAction.scale(to: 1.2, duration: 1.0),
            SCNAction.scale(to: 1.0, duration: 1.0)
        ])
        node.runAction(SCNAction.repeatForever(pulseAction))
    }
}
