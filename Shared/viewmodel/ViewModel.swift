//
//  ViewModel.swift
//  AppfroschsShortcutCheatApp
//
//  Created by Andreas Seeger on 08.12.20.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var systems: [System]
    @Published var applications: [Application]
    @Published var shortcuts: [Shortcut]
    @Published var sections: [ShortcutSection]
    
    init() {
        self.applications = [Application]()
        self.systems = [System]()
        self.shortcuts = [Shortcut]()
        self.sections = [ShortcutSection]()
        
        if self.applications.isEmpty && self.systems.isEmpty && self.shortcuts.isEmpty && self.sections.isEmpty {
            self.setMockData()
        }
    }
    
    private func setMockData() {
        let xcodeId = UUID()
        self.applications = [
            Application(id: xcodeId, modelVersion: 1, name: "Xcode", version: "12", description: nil, icon: nil, system: nil),
            Application(id: UUID(), modelVersion: 1, name: "Pages", version: "10.3.5", description: nil, icon: nil, system: nil),
            Application(id: UUID(), modelVersion: 1, name: "Numbers", version: "10.3.5", description: nil, icon: nil, system: nil)
        ]
        
        self.systems = [
            System(id: UUID(), modelVersion: 1, name: "macOS"),
            System(id: UUID(), modelVersion: 1, name: "Windows")
        ]
        
        let sectionId = UUID()
        self.sections = [
            ShortcutSection(id: UUID(), modelVersion: 1, parentId: xcodeId, name: "Misc"),
            ShortcutSection(id: sectionId, modelVersion: 1, parentId: xcodeId, name: "File Handling")
        ]
        
        self.shortcuts = [
            Shortcut(id: UUID(), modelVersion: 1, sectionId: sectionId, name: "New File", description: nil, modifierKeys: ["CMD"], keys: ["N"])
        ]
        
    }
}
