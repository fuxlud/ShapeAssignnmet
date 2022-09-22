import Foundation
import UIKit

class BreedPictureViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView?
    
    public var viewModel: BreedPictureViewModel?
    
    override func viewDidLoad() {
        title = viewModel?.breed.name
        
        Task {
            do {
                try await viewModel?.fetchImages()
                collectionView?.reloadData()
            } catch {
                showError(error: error)
            }
        }
    }
}

extension BreedPictureViewController: UICollectionViewDataSource {
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedPictureCell.className, for: indexPath) as? BreedPictureCell,
              let imageURL = viewModel?.imageURLs[indexPath.row]
        else {
            return UICollectionViewCell()
        }

        
        let breedCellViewModel = BreedPictureCellViewModel(with: imageURL)

        cell.setupView(viewModel: breedCellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.imageURLs.count ?? 0
    }
}
