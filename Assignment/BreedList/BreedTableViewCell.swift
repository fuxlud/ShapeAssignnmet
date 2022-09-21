import Foundation
import UIKit

class BreedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var breedNameLabel: UILabel!

    private var viewModel: BreedCellViewModel?
        
    func setupView(viewModel: BreedCellViewModel) {
        breedNameLabel.text = viewModel.breedName
    }
}
