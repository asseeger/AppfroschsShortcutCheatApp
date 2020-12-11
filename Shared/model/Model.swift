//
//  Model.swift
//  AppfroschsShortcutCheatApp (iOS)
//
//  Created by Andreas Seeger on 08.12.20.
//

import Foundation

struct Application: Identifiable {
    let id: UUID
    var modelVersion: Int = 1
    var name: String
    var version: String?
    var description: String?
    var icon: String?
    var system: String?
}

struct Shortcut: Identifiable {
    let id: UUID
    var modelVersion: Int
    var sectionId: UUID
    var name: String
    var description: String?
    var modifierKeys: [String]
    var keys: [String]
}

struct ShortcutSection: Identifiable, Hashable {
    let id: UUID
    var modelVersion: Int
    
    /// The id of the parent, which can be either a System or an Application
    var parentId: UUID
    var name: String
}

struct System: Identifiable {
    let id: UUID
    var modelVersion: Int
    var name: String
}
