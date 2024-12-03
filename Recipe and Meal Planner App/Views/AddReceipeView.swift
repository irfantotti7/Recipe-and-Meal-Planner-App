import SwiftUI

struct AddRecipeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var title = ""
    @State private var category = ""
    @State private var instructions = ""
    @State private var prepTime = 0
    @State private var image: UIImage?
    @State private var showImagePicker = false
    
    var body: some View {
        ZStack {
            Image("app-background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                
            
            VStack {
                Spacer()
                Form {
                    Section(header: Text("Recipe Info").font(.title2).bold()) {
                        TextField("Title", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        TextField("Category", text: $category)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        TextField("Preparation Time", value: $prepTime, format: .number)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                    }
                    
                    Section(header: Text("Instructions").font(.title2).bold()) {
                        TextEditor(text: $instructions)
                            .frame(height: 150)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                            .padding(.horizontal)
                    }
                    
                    Section(header: Text("Recipe Image").font(.title2).bold()) {
                        Button(action: {
                            showImagePicker.toggle()
                        }) {
                            HStack {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .foregroundColor(.blue)
                                Text("Choose Image")
                                    .foregroundColor(.blue)
                                    .font(.body)
                                    .padding(.leading, 5)
                            }
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                        
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .cornerRadius(10)
                                .padding(.top, 10)
                                .shadow(radius: 10)
                        }
                    }
                    
                    Button(action: {
                        addRecipe()
                    }) {
                        Text("Save Recipe")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.top, 20)
                }
                .background(Color.white.opacity(0.9)) // Slightly opaque background for form
                .cornerRadius(20)
                .padding(.horizontal)
                .padding(.top, 30)
                Spacer()
            }
        }
        .navigationTitle("Add Recipe")
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $image)
        }
    }
    
    private func addRecipe() {
        let newRecipe = Recipe(context: viewContext)
        newRecipe.title = title
        newRecipe.category = category
        newRecipe.instructions = instructions
        newRecipe.prepTime = Int32(prepTime)
        if let imageData = image?.jpegData(compressionQuality: 0.8) {
            newRecipe.imageData = imageData
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to save recipe: \(error)")
        }
    }
}


