import UIKit

extension UIViewController {

    func showAlert(title:String, message:String, completion: (()-> ())!) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel) {(_) in
            completion()
            alert.dismiss(animated: false, completion: nil)
        }
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }

}
