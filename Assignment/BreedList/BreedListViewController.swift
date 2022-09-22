import Foundation
import UIKit

class BreedListViewController: UIViewController {

    @IBOutlet private var tableView: UITableView?
    
    private let viewModel = BreedListViewModel()
    
    override func viewDidLoad() {
         Task {
            do {
                try await viewModel.fetchBreeds()
                tableView?.reloadData()
            } catch {
                showError(error: error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let breedPictureViewController = segue.destination as? BreedPictureViewController {
            guard let breed = sender as? Breed else {
                return
            }
            
            let breedPictureViewModel = BreedPictureViewModel(with: breed)
            breedPictureViewController.viewModel = breedPictureViewModel
        }
    }
}

extension BreedListViewController: UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.breeds.count
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BreedTableViewCell.className, for: indexPath) as? BreedTableViewCell else {
            return UITableViewCell()
        }

        let breed = viewModel.breeds[indexPath.row]
        let breedCellViewModel = BreedCellViewModel(with: breed)

        cell.setupView(viewModel: breedCellViewModel)
        return cell
    }
}

extension BreedListViewController: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breed = viewModel.breeds[indexPath.row]
        self.performSegue(withIdentifier: BreedPictureViewController.className, sender: breed)
    }
}

