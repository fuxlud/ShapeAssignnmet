import Foundation
import UIKit

class FavoritePicturesViewController: UIViewController {
    
    @IBOutlet weak var breedPicker: UIPickerView!
    @IBOutlet private var collectionView: UICollectionView?
    
    public var viewModel: FavoritePicturesViewModel?
    override func viewDidLoad() {
        Task {
            await viewModel?.getFavoriteBreeds()
            breedPicker.reloadAllComponents()
            collectionView?.reloadData()
        }
    }
}

//extension FavoritePicturesViewController: UICollectionViewDataSource {
//    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedPictureCell.className, for: indexPath) as? BreedPictureCell,
//              let imageURL = viewModel?.imageURLs[indexPath.row]
//        else {
//            return UICollectionViewCell()
//        }
//
//
//        let breedCellViewModel = BreedPictureCellViewModel(with: imageURL)
//
//        cell.setupView(viewModel: breedCellViewModel)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel?.imageURLs.count ?? 0
//    }
//}

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
        return viewModel?.favoriteBreeds.count ?? 0
    }
}

extension FavoritePicturesViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.favoriteBreeds[row]
    }
}
