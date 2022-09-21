import UIKit

extension UIView {
    public class var className: String {
        let className: String = NSStringFromClass(self).components(separatedBy: ".").last!
        return className
    }
}

extension UIViewController {
    public class var className: String {
        let className = String(describing: self).components(separatedBy: ".").first!
        return className
    }
    
    public func showError(error: Error){
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
