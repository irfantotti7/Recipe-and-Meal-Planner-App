import SwiftUI
import PhotosUI

struct ImagePicker: View {
    @Binding var image: UIImage?
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        PhotosPicker(
            "Select an Image", selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()
        )
        .onChange(of: selectedItem) { newItem in
            guard let item = newItem else {
                return
            }
            loadImage(from: item)
        }
    }
    
    private func loadImage(from item: PhotosPickerItem) {
        Task {
            do {
                // Load the selected item as Data
                if let selectedImageData = try await item.loadTransferable(type: Data.self) {
                    // Convert Data to UIImage
                    if let image = UIImage(data: selectedImageData) {
                        self.image = image
                    }
                }
            } catch {
                print("Failed to load image: \(error)")
            }
        }
    }
}

