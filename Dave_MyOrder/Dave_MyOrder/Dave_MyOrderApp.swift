//
//  Dave_MyOrderApp.swift
//  Dave_MyOrder
//
//  Created by Dave Aldrich Cueto on 2021-09-25.
//

import SwiftUI

@main
struct Dave_MyOrderApp: App {
    
    let persistenceController = PersistenceController.shared
    let coreDBHelper = CoreDBHelper(context: PersistenceController.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(coreDBHelper)
        }
    }
}
