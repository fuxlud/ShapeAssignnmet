import Foundation
import UIKit

let screenWidth: CGFloat = UIScreen.main.bounds.width
let edgeLength = (screenWidth - 3)/3

class BreedPictureCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView?
    @IBOutlet private weak var breedLabel: UILabel?
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
                    updateView()
                }
            } catch {}
        }
    }
    
    @IBAction func imageTapped(_ sender: Any) {
        viewModel?.imageLikeStateShouldChange()
        updateView()
    }
    
    private func updateView() {
        
        if let isFavorite = viewModel?.isFavorite,
           isFavorite == true {
            favoriteIndicator?.image = UIImage(systemName: "heart.fill")
        } else {
            favoriteIndicator?.image = UIImage(systemName: "heart")
        }
        
        breedLabel?.text = viewModel?.breedName
    }
}
