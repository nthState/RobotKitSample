//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

import ARKit
import RealityKit
import SwiftUI

struct ARContainer : UIViewRepresentable {
  let arView: ARView
  
  private func sessionConfig() {
    arView.automaticallyConfigureSession = false
    let configuration = ARWorldTrackingConfiguration()
    configuration.planeDetection = [.horizontal, .vertical]
    configuration.sceneReconstruction = .mesh
    
#if targetEnvironment(simulator)
    setupNonArMode()
#endif
    
    arView.session.run(configuration)
  }
  
#if targetEnvironment(simulator)
  func setupNonArMode() {
    arView.cameraMode = .nonAR
    
    // Non AR mode needs to have a camera
    let cameraEntity = PerspectiveCamera()
    cameraEntity.name = "perspectiveCameraEntity"
    cameraEntity.position = [0, 0, 3]
    let cameraAnchor = AnchorEntity(world: .zero)
    cameraAnchor.name = "cameraAnchor"
    cameraAnchor.addChild(cameraEntity)
    arView.scene.anchors.append(cameraAnchor)
    
    // Light
    let light = DirectionalLight()
    light.name = "directionalLight"
    light.light.intensity = 1500
    light.light.isRealWorldProxy = false
    light.look(at: .zero, from: [0, 2, 3], relativeTo: nil)
    
    let lightAnchor = AnchorEntity(world: .zero)
    lightAnchor.name = "lightAnchor"
    lightAnchor.addChild(light)
    arView.scene.anchors.append(lightAnchor)
  }
#endif
  
  func makeUIView(context: Context) -> ARView {
    self.sessionConfig()
    
    return arView
  }
  
  func updateUIView(_ view: ARView, context: Context) {}
}
