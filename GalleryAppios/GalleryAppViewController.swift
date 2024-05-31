//
//  GalleryAppViewController.swift
//  GalleryAppios
//
//  Created by Raj Shekhar on 31/05/24.
//

import UIKit
private let cellIdentifier = "ImageCollectionViewCell"

class GalleryAppViewController: UIViewController {
    var viewModel = GalleryViewModel()
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var deleteButton: UIButton! // Connect this from storyboard
    
    @IBOutlet weak var shareButton: UIButton!
    var images: [UIImage] = []
    var selectedImages: [IndexPath] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryCollectionView.dataSource = self
        galleryCollectionView.delegate = self
        deleteButton.addTarget(self, action: #selector(deleteSelectedImages), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareSelectedImages), for: .touchUpInside)
    }
    
    @objc func shareSelectedImages() {
        let imagesToShare = selectedImages.map { viewModel.image(at: $0) }
        let activityViewController = UIActivityViewController(activityItems: imagesToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view 
        present(activityViewController, animated: true, completion: nil)
    }

    
    @objc func deleteSelectedImages() {
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete the selected images?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.viewModel.deleteSelectedImages(at: self.selectedImages)
            self.selectedImages.removeAll()
            self.galleryCollectionView.reloadData()
            self.deleteButton.isHidden = true
        }))
        
        present(alert, animated: true, completion: nil)
    }
}

extension GalleryAppViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:self.view.frame.size.width/2, height:self.view.frame.size.width/2)
    }
}

extension GalleryAppViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ImageCollectionViewCell {
            let imageModel = viewModel.image(at: indexPath)
            cell.set(image: imageModel)
            cell.setSelected(viewModel.isSelected(at: indexPath))
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let index = selectedImages.firstIndex(of: indexPath) {
            selectedImages.remove(at: index)
            viewModel.deSelectImage(at: indexPath)
        } else {
            selectedImages.append(indexPath)
            viewModel.selectImage(at: indexPath)
        }
        deleteButton.isHidden = selectedImages.isEmpty
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell {
            cell.setSelected(viewModel.isSelected(at: indexPath))
        }
    }
}
