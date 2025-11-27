//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

import RealityKit
import SwiftUI

@MainActor
public struct AddEntityOverlayView {
  @Bindable var viewModel: ViewModel
}

extension AddEntityOverlayView: View {
  
  public var body: some View {
    content
  }
  
  private var content: some View {
    buttons
  }
  
  private var buttons: some View {
    VStack {
      Spacer()
      HStack(spacing: 44) {
        sphereButton
        cubeButton
        closeButton
      }
    }
  }
  
  private var closeButton: some View {
    Button {
      viewModel.presentAddEntitySheet(false)
    } label: {
      Image(systemName: "xmark")
    }
    .frame(width: 44, height: 44)
    .contentShape(Rectangle())
    .accessibilityIdentifier("closeButton")
  }
  
  private var sphereButton: some View {
    Button {
      viewModel.add(type: .sphere)
    } label: {
      Image(systemName: "circle")
    }
    .frame(width: 44, height: 44)
    .contentShape(Rectangle())
    .accessibilityIdentifier("sphereButton")
  }
  
  private var cubeButton: some View {
    Button {
      viewModel.add(type: .cube)
    } label: {
      Image(systemName: "cube")
    }
    .frame(width: 44, height: 44)
    .contentShape(Rectangle())
    .accessibilityIdentifier("cubeButton")
  }

}

#Preview("AddEntityOverlayView", traits: .landscapeRight) {
  AddEntityOverlayView(viewModel: .init())
}

#Preview("AddEntityOverlayView Assistive access", traits: .assistiveAccess, .landscapeRight) {
  AddEntityOverlayView(viewModel: .init())
}
