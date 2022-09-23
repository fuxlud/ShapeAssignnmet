import Foundation
import UIKit

class FavoritePicturesViewController: UIViewController {
    
    @IBOutlet weak var breedPicker: UIPickerView!
    @IBOutlet private var collectionView: UICollectionView?
    
    public var viewModel = FavoritePicturesViewModel()
    
    override func viewDidLoad() {
        Task {
            await viewModel.loadFavoriteBreedNames()
            breedPicker.reloadAllComponents()
            collectionView?.reloadData()
        }
    }
}

extension FavoritePicturesViewController: UICollectionViewDataSource {
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedPictureCell.className, for: indexPath) as? BreedPictureCell,
              let imageURL = viewModel.imagesOfSpecificBreed(at: indexPath.row)
        else {
            return UICollectionViewCell()
        }


        let breedCellViewModel = BreedPictureCellViewModel(with: imageURL, breed: Breed(name: "To Change"))

        cell.setupView(viewModel: breedCellViewModel, indexPath: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imagesOfSpecificBreed.count
    }
}

private let screenWidth: CGFloat = UIScreen.main.bounds.width
private let edgeLength = (screenWidth - 3)/3

extension FavoritePicturesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: edgeLength, height: edgeLength)
    }
}

extension FavoritePicturesViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.favoriteBreedNames.count
    }
}

extension FavoritePicturesViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.favoriteBreedNames[row]
    }
}
