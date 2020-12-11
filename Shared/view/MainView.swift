//
//  MainView_.swift
//  AppfroschsShortcutCheatApp
//
//  Created by Andreas Seeger on 09.12.20.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: ViewModel
    
    let parentId: UUID
    
    var sectionsShortcutsDicts: [ShortcutSection:[Shortcut]] {
        // Create an so far empty dict to return after filling
        var dict = [ShortcutSection:[Shortcut]]()
        // Search sections
        var availableSections = [ShortcutSection]()
        self.viewModel.sections.forEach {
            if $0.parentId == self.parentId {
                availableSections.append($0)
            }
        }
        // Loop through the sections
        availableSections.forEach { section in
            // Create an array that holds the shortcuts for this section
            var availableShortcuts = [Shortcut]()
            viewModel.shortcuts.forEach { shortcut in
                if shortcut.sectionId == section.id {
                    availableShortcuts.append(shortcut)
                }
            }
            dict[section] = availableShortcuts
        }
        return dict
    }
    
    var body: some View {
        List {
            if sectionsShortcutsDicts.isEmpty {
                Text("There are no sections available so far…")
            } else {
                ForEach(Array(sectionsShortcutsDicts.keys), id: \.self) { keyOfTypeShortcutSection in
                    Section(header: Text(keyOfTypeShortcutSection.name)) {
                        if let shortcuts = sectionsShortcutsDicts[keyOfTypeShortcutSection] {
                            if shortcuts.isEmpty {
                                Text("There are no shortcuts available so far…")
                            } else {
                                ForEach(shortcuts) { shortcut in
                                    Text(shortcut.name)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        MainView(viewModel: viewModel, parentId: viewModel.applications.first!.id)
    }
}
