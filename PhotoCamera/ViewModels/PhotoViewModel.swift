//
//  PhotoViewModel.swift
//  PhotoCamera
//
//  Created by Rajesh Triadi Noftarizal on 13/11/24.
//

import SwiftUI
import PhotosUI

class PhotoViewModel: ObservableObject {
    @Published var selectedPhoto: UIImage?
    @Published var isCameraActive = false
    @Published var isPhotoPickerActive = false
    @Published var showErrorAlert = false
    @Published var errorMessage = ""

    func takePhoto() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            errorMessage = "Camera not available"
            showErrorAlert = true
            return
        }
        isCameraActive = true
    }
    
    func selectPhotoFromGallery() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            errorMessage = "Photo Library not available"
            showErrorAlert = true
            return
        }
        isPhotoPickerActive = true
    }
    
    func processPickedImage(_ image: UIImage) {
        selectedPhoto = image
    }
}
