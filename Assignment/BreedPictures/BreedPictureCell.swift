import Foundation
import UIKit

class BreedPictureCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView?
    
    private var viewModel: BreedPictureCellViewModel?
    private var indexPath: IndexPath?
    
    func setupView(viewModel: BreedPictureCellViewModel, indexPath: IndexPath) {
        self.indexPath = indexPath
        imageView?.image = nil
        self.viewModel = viewModel //TODO: Consider removing
        
        Task {
            do {
                let image = try await viewModel.fetchImage()
                if indexPath == self.indexPath {
                    imageView?.image = image
                }
            } catch {
                // some error image
            }
        }
    }
}
