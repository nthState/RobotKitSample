//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

import ARKit
import RealityKit

public class CubeEntity: Entity, HasModel, HasCollision, HasAnchoring {
  required init() {
    super.init()
    
    let mesh = MeshResource.generateBox(size: 0.1)
    let material = SimpleMaterial(color: .red, roughness: 0.5, isMetallic: true)
    
    self.name = "cube"
    
    self.components.set(ModelComponent(mesh: mesh, materials: [material]))
    
    let entityBounds = self.visualBounds(relativeTo: nil)
    self.collision = CollisionComponent(shapes: [ShapeResource.generateBox(size: entityBounds.extents).offsetBy(translation: entityBounds.center)])
  }
}
