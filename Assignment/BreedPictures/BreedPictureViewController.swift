import Foundation
import UIKit

class BreedPictureViewController: UICollectionViewController {
    public var viewModel: BreedPictureViewModel?
    
    override func viewDidLoad() {
        title = viewModel?.breed.name
    }
}
