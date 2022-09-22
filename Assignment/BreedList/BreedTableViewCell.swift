import Foundation
import UIKit

class BreedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var breedNameLabel: UILabel!

    private var viewModel: BreedCellViewModel?
        
    func setupView(viewModel: BreedCellViewModel) {
        self.viewModel = viewModel //TODO: Consider removing
        breedNameLabel.text = viewModel.breedName
    }
}
