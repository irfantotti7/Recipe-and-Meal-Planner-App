//
//  RecipeListView.swift
//  Recipe and Meal Planner App
//
//  Created by Irfan T on 03/12/24.
//

import SwiftUI

struct RecipeListView: View {
    @FetchRequest(
        entity: Recipe.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.title, ascending: true)],
        animation: .default
    ) private var recipes: FetchedResults<Recipe>
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("app-background") // Replace "BackgroundImage" with your asset name
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all) // Make sure it fills the screen
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                        ForEach(recipes, id: \.self) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeCardView(recipe: recipe)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Recipes")
        }
    }
}

struct RecipeCardView: View {
    var recipe: Recipe
    
    var body: some View {
        VStack {
            if let imageData = recipe.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .cornerRadius(10)
                    .clipped()
            } else {
                Color.gray
                    .frame(width: 150, height: 150)
                    .cornerRadius(10)
            }
            
            Text(recipe.title ?? "Untitled")
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
                .padding([.top, .bottom], 5)
            
            Text(recipe.category ?? "No Category")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
        .background(Color.white.opacity(0.7)) // Optional: makes card background slightly transparent
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

