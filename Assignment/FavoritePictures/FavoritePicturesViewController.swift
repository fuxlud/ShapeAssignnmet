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
            let breedName = viewModel.favoriteBreedNames[0]
            await viewModel.loadImages(of: breedName)
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

private let screenWidth: CGFloat = UIScreen.main.bounds.width //TODO: Is right place?
private let edgeLength = (screenWidth - 3)/3

extension FavoritePicturesViewController: UICollectionViewDelegateFlowLayout {
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: edgeLength, height: edgeLength)
    }
}

extension FavoritePicturesViewController: UIPickerViewDataSource {
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.favoriteBreedNames.count
    }
}

extension FavoritePicturesViewController: UIPickerViewDelegate {
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.favoriteBreedNames[row]
    }
    
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Task {
            let breedName = viewModel.favoriteBreedNames[row]
            await viewModel.loadImages(of: breedName)
            collectionView?.reloadData()
        }
    }
}
