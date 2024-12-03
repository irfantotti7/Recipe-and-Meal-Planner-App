//
//  RecipeDetailView.swift
//  Recipe and Meal Planner App
//
//  Created by Irfan T on 03/12/24.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    
    var body: some View {
        ScrollView {
            ZStack {
                // Background Image
                Image("app-background") // Replace with your asset name
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all) // Fill the screen
                
                VStack(alignment: .leading, spacing: 20) {
                    if let imageData = recipe.imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxHeight: 300)
                            .cornerRadius(15)
                            .clipped()
                            .shadow(radius: 10)
                    }
                    
                    Text(recipe.title ?? "Untitled")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(recipe.category ?? "No Category")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    Text("Instructions")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(recipe.instructions ?? "No instructions available.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(nil)
                    
                    Spacer()
                }
                .padding()
                .background(Color.white.opacity(0.8)) // Optional: adds a slight white background for contrast
                .cornerRadius(15)
            }
        }
        .navigationTitle("Recipe Details")
    }
}


