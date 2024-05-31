//
//  ImageCollectionViewCell.swift
//  GalleryAppios
//
//  Created by Raj Shekhar on 31/05/24.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var checkMarkImageView: UIImageView!
    @IBOutlet weak var galleryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        galleryImageView.layer.borderWidth = 1.0
        galleryImageView.layer.borderColor = UIColor.lightGray.cgColor
        galleryImageView.contentMode = .scaleToFill
        
        checkMarkImageView.image = UIImage(systemName: "checkmark.circle.fill")
        checkMarkImageView.tintColor = .systemRed
        checkMarkImageView.isHidden = true
    }
    
    func set(image: UIImage?) {
        galleryImageView.image = image
    }
    
    func setSelected(_ selected: Bool) {
        checkMarkImageView.isHidden = !selected
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset any cell state here
        setSelected(false) // Ensure checkmark is hidden
    }
}


