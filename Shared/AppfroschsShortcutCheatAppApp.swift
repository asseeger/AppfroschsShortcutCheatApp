//
//  AppfroschsShortcutCheatAppApp.swift
//  Shared
//
//  Created by Andreas Seeger on 08.12.20.
//

import SwiftUI

@main
struct AppfroschsShortcutCheatAppApp: App {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainPanelPlatformView(viewModel: viewModel)
        }
    }
}
