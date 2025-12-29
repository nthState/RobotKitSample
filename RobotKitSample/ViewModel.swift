//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

import Observation
import OSLog
import RealityKit
import SwiftUI
import ARKit

@Observable
class ViewModel {
  
  let arView = ARView(frame: .zero)
  var isEntitySheetPresented: Bool = false
  var selectedEntityName: String = "No Entity Selected"
  
  init() {
    arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_:))))
    
    initLocalNetwork()
  }
  
  func initLocalNetwork() {
    
    let url = URL(string: "http://192.168.1.183")!
    let task = URLSession.shared.dataTask(with: url) { localURL, urlResponse, error in
      Logger.sample.debug("response: \(urlResponse)")
    }
    
    task.resume()
    
  }
  
  func presentAddEntitySheet(_ value: Bool) {
    isEntitySheetPresented = value
  }
  
  func add(type: EntityType) {
    
    let entity: HasAnchoring = type == .cube ? CubeEntity() : SphereEntity()
    
#if targetEnvironment(simulator)
    // Note: Simulator has no physical environment when running in a UITest without AR Replay data
    arView.scene.addAnchor(entity)
#else
    let center = CGPoint(x: arView.bounds.width / 2, y: arView.bounds.height / 2)
    guard let rayCastResult = arView.raycast(from: center, allowing: .existingPlaneInfinite, alignment: .any).first else {
      return
    }
    
    entity.transform.matrix = rayCastResult.worldTransform
    
    arView.scene.addAnchor(entity)
#endif
    
  }
  
  @objc func tapped(_ recognizer: UIGestureRecognizer) {
    let center = recognizer.location(in: arView)
    let hits = arView.entities(at: center)
    selectedEntityName = hits.first?.name ?? ""
  }
}
