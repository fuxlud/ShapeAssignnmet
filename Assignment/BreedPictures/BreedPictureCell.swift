import Foundation
import UIKit

class BreedPictureCell: UICollectionViewCell {
    
    @IBOutlet weak var breedNameLabel: UILabel!

    private var viewModel: BreedPictureCellViewModel?
        
    func setupView(viewModel: BreedPictureCellViewModel) {
        self.viewModel = viewModel //TODO: Consider removing
        breedNameLabel.text = viewModel.imageURL.absoluteString
    }
}
