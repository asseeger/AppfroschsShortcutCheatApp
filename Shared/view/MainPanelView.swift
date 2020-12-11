//
//  MainPanelView.swift
//  AppfroschsShortcutCheatApp
//
//  Created by Andreas Seeger on 08.12.20.
//

import SwiftUI

struct MainPanelPlatformView: View {
    @ObservedObject var viewModel: ViewModel
    
    @State private var showActionSheet = false
    @State private var showAddEntry = false
    
    var body: some View {
        #if os(macOS)
        MainPanelView(viewModel: viewModel)
            
        #else
        MainPanelView(viewModel: viewModel)
            .toolbar {
                ToolbarItem(placement: .bottomBar, content: {
                    HStack {
                        Spacer()
                        NavigationLink(
                            destination: AddEntry(viewModel: viewModel),
                            label: {
                                Image(systemName: "plus")
                            })
                        Spacer()
                    }
                })
            }
            .actionSheet(isPresented: $showActionSheet, content: {
                ActionSheet(title: Text("Add"), buttons: [
                    .cancel(),
                    .default(Text("New Application")) {
                        showAddEntry = true
                    },
                    .default(Text("New System")) {
                        print("Tapped…")
                    }
                ])
            })
        #endif
    }
}

struct MainPanelView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section(header: MainPanelViewSectionHeader(viewModel: viewModel, titel: "Applications")) {
                    ForEach(viewModel.applications) { application in
                        NavigationLink(destination: MainView(viewModel: viewModel, parentId: application.id)) {
                            Text(application.name)
                        }
                    }
                }
                Section(header: MainPanelViewSectionHeader(viewModel: viewModel, titel: "Systems")) {
                    ForEach(viewModel.systems) { system in
                        NavigationLink(destination: MainView(viewModel: viewModel, parentId: system.id)) {
                            Text(system.name)
                        }
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Shortcut Cheat App")
        }
    }
}

struct MainPanelView_Previews: PreviewProvider {
    static var previews: some View {
        MainPanelView(viewModel: ViewModel())
    }
}

struct MainPanelViewSectionHeader: View {
    @ObservedObject var viewModel: ViewModel
    
    let titel: String
    
    var body: some View {
        HStack {
            Text(titel)
            Spacer()
        }
    }
}

struct AddEntry: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ViewModel
    @State private var entryName = ""
    var body: some View {
        VStack {
            //            Form {
            Text("New entries need confirmation.")
            TextField("Name", text: $entryName)
            //            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction, content: {
                Button(action: {
                    if !entryName.isEmpty {
                        viewModel.applications.append(Application(id: UUID(), name: entryName))
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        //TODO: show alert: name must not be empty
                    }
                }) {
                    Text("Confirm")
                }
            })
        }
    }
}
