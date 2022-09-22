import Foundation
import UIKit

class BreedPictureCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView?
    
    private var indexPath: IndexPath?
    
    func setupView(viewModel: BreedPictureCellViewModel, indexPath: IndexPath) {
        self.indexPath = indexPath
        imageView?.image = nil
        
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
