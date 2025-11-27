//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

import ARKit
import RealityKit

public class SphereEntity: Entity, HasModel, HasCollision, HasAnchoring {
  required init() {
    super.init()
    
    let mesh = MeshResource.generateSphere(radius: 0.05)
    let material = SimpleMaterial(color: .blue, roughness: 0.45, isMetallic: false)
    
    self.name = "sphere"
    
    self.components.set(ModelComponent(mesh: mesh, materials: [material]))
    
    let entityBounds = self.visualBounds(relativeTo: self)
    self.collision = CollisionComponent(shapes: [ShapeResource.generateBox(size: entityBounds.extents).offsetBy(translation: entityBounds.center)])
  }
}
