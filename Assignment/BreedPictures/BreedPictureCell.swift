import Foundation
import UIKit

class BreedPictureCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView?
    @IBOutlet private weak var favoriteIndicator: UIImageView?
    
    private var viewModel: BreedPictureCellViewModel?
    private var indexPath: IndexPath?
    
    func setupView(viewModel: BreedPictureCellViewModel, indexPath: IndexPath) {
        self.indexPath = indexPath
        imageView?.image = nil
        self.viewModel = viewModel
        
        Task {
            do {
                let image = try await viewModel.fetchImage()
                if indexPath == self.indexPath {
                    imageView?.image = image
                    updateFavoriteIndicator()
                }
            } catch {
                // some error image
            }
        }
    }
    
    @IBAction func imageTapped(_ sender: Any) {
        viewModel?.imageLikeStateShouldChange()
        updateFavoriteIndicator()
    }
    
    private func updateFavoriteIndicator() {
        
        if let isFavorite = viewModel?.isFavorite,
           isFavorite == true {
            favoriteIndicator?.image = UIImage(systemName: "heart.fill")
        } else {
            favoriteIndicator?.image = UIImage(systemName: "heart")
        }
    }
}
