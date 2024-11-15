//
//  PhotoCaptureView.swift
//  PhotoCamera
//
//  Created by Rajesh Triadi Noftarizal on 13/11/24.
//

import SwiftUI

struct PhotoCaptureView: View {
    @StateObject private var viewModel = PhotoViewModel()
    
    var body: some View {
        VStack {
            if let selectedPhoto = viewModel.selectedPhoto {
                Image(uiImage: selectedPhoto)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            } else {
                Text("No photo selected")
                    .foregroundStyle(.gray)
            }
            
            // Button that triggers the small modal (Menu)
            Menu {
                Button("Take Photo") {
                    viewModel.takePhoto() // Trigger camera to take a photo
                }
                Button("Choose from Gallery") {
                    viewModel.selectPhotoFromGallery() // Trigger gallery picker
                }
            } label: {
                Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .fullScreenCover(isPresented: $viewModel.isCameraActive, content: {
            ImagePickerView(sourceType: .camera) { image in
                viewModel.processPickedImage(image)
            }
        })
        .sheet(isPresented: $viewModel.isPhotoPickerActive, content: {
            ImagePickerView(sourceType: .photoLibrary) { image in
                viewModel.processPickedImage(image)
            }
        })
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    PhotoCaptureView()
}
