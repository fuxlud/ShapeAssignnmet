import Foundation
import UIKit

class BreedPicturesViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView?
    
    public var viewModel: BreedPicturesViewModel?
    
    override func viewDidLoad() {
        title = viewModel?.breed.name
        
        Task {
            do {
                try await viewModel?.loadImages()
                collectionView?.reloadData()
            } catch {
                showError(error: error)
            }
        }
    }
}

extension BreedPicturesViewController: UICollectionViewDataSource {
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedPictureCell.className, for: indexPath) as? BreedPictureCell,
              let imageURL = viewModel?.imagesDetails[indexPath.row]
        else {
            return UICollectionViewCell()
        }

        
        let breedCellViewModel = BreedPictureCellViewModel(with: imageURL)

        cell.setupView(viewModel: breedCellViewModel, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.imagesDetails.count ?? 0
    }
}

private let screenWidth: CGFloat = UIScreen.main.bounds.width
private let edgeLength = (screenWidth - 3)/3

extension BreedPicturesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: edgeLength, height: edgeLength)
    }
}

