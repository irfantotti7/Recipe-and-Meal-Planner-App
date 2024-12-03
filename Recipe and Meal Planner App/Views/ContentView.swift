//
//  ContentView.swift
//  Recipe and Meal Planner App
//
//  Created by Irfan T on 03/12/24.
//

import SwiftUI
import CoreData


struct ContentView: View {
    var body: some View {
        TabView {
            RecipeListView()
                .tabItem {
                    Label("Recipes", systemImage: "list.bullet")
                        .font(.custom("Helvetica Neue", size: 24))
                }
            
            AddRecipeView()
                .tabItem {
                    Label("Add Recipe", systemImage: "plus.circle")
                        .foregroundColor(.blue)
                        .font(.custom("Helvetica Neue", size: 24))
                }
        }
    }
}
