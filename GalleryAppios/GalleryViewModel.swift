//
//  GalleryViewModel.swift
//  GalleryAppios
//
//  Created by Raj Shekhar on 31/05/24.
//

import UIKit

class GalleryViewModel {
    
    private(set) var images = [ImageModel]()
    private(set) var selectedImages = [IndexPath]()

    init(images: [ImageModel] = [ImageModel]()) {
        self.images = images
        loadImages()
    }
    
    func loadImages() {
        let imageNames = ["image1",
                          "image2",
                          "image3",
                          "image4",
                          "image5",
                          "image6",
                          "image7",
                          "image8",
                          "image9",
                          "image10",
                          "image11",
                          "image12",
                          "image13",
                          "image14",
                          "image15",
                          "image16",
                          "image17",
                          "image18",
                          "image19",
                          "image20",
                          "image21"]
        
        for imageName in imageNames {
            if let image = UIImage(named: imageName) {
                images.append(ImageModel(image: image))
            } else {
                print("Error: Image \(imageName) could not be loaded.")
            }
        }
    }
    
    func numberOfItems() -> Int {
        return images.count
    }
    
    func image(at indexPath: IndexPath) -> UIImage {
        return images[indexPath.item].image
    }
    
    func selectImage(at indexPath: IndexPath) {
        selectedImages.append(indexPath)
    }
    
    func deSelectImage(at indexPath: IndexPath) {
        if let index = selectedImages.firstIndex(of: indexPath) {
            selectedImages.remove(at: index)
        }
    }
    
    func isSelected(at indexPath: IndexPath) -> Bool {
        return selectedImages.contains(indexPath)
    }
    
    func deleteSelectedImages(at indexPaths: [IndexPath]) {
        let sortedIndexPaths = indexPaths.sorted(by: { $0.item > $1.item })
        for indexPath in sortedIndexPaths {
            images.remove(at: indexPath.item)
        }
        selectedImages.removeAll()
    }
}
