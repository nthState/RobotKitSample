//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

import RealityKit
import SwiftUI

@MainActor
public struct ContentView {
  @State var viewModel: ViewModel = .init()
}

extension ContentView: View {
  
  public var body: some View {
    content
  }
  
  private var content: some View {
    ZStack {
      arView
      hud
      buttons
    }
    .sheet(isPresented: $viewModel.isEntitySheetPresented) {
      AddEntityOverlayView(viewModel: viewModel)
        .presentationDetents([.height(50)])
    }
  }
  
  private var hud: some View {
    VStack {
      selectedEntityLabel
      Spacer()
    }
    .padding(.vertical, 44)
  }
  
  private var selectedEntityLabel: some View {
    Text(viewModel.selectedEntityName)
      .font(.title)
      .foregroundStyle(Color.white)
      .accessibilityIdentifier("selectedEntityName")
  }
  
  private var buttons: some View {
    VStack {
      Spacer()
      addEntityButton
    }
  }
  
  private var addEntityButton: some View {
    Button {
      viewModel.presentAddEntitySheet(true)
    } label: {
      Image(systemName: "plus")
    }
    .frame(width: 44, height: 44)
    .contentShape(Rectangle())
    .accessibilityIdentifier("addEntityButton")
  }
  
  private var arView: some View {
    ARContainer(arView: viewModel.arView)
      .edgesIgnoringSafeArea(.all)
      .accessibilityIdentifier("arView")
  }
}

#Preview("ContentView", traits: .landscapeRight) {
  ContentView()
}

#Preview("ContentView Assistive access", traits: .assistiveAccess, .landscapeRight) {
  ContentView()
}
