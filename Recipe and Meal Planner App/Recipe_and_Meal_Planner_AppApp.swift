//
//  Recipe_and_Meal_Planner_AppApp.swift
//  Recipe and Meal Planner App
//
//  Created by Irfan T on 03/12/24.
//

import SwiftUI

@main
struct Recipe_and_Meal_Planner_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
