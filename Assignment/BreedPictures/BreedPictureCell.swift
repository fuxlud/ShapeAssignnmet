import Foundation
import UIKit

class BreedPictureCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView?
    
    private var viewModel: BreedPictureCellViewModel?
        
    func setupView(viewModel: BreedPictureCellViewModel) {
        self.viewModel = viewModel //TODO: Consider removing
        
        Task {
            do {
                let image = try await viewModel.fetchImage()
                imageView?.image = image
            } catch {
                // some error image
            }
        }
    }
}
