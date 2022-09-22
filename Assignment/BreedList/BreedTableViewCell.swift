import Foundation
import UIKit

class BreedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var breedNameLabel: UILabel!
        
    func setupView(viewModel: BreedCellViewModel) {
        breedNameLabel.text = viewModel.breedName
    }
}
