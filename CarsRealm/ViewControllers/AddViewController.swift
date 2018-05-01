import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var zeroToSixtyTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCloseKeyboardGesture()
    }

    func setupCloseKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false     // So that didSelectRow on TableVC isn't disabled
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let yearText = yearTextField.text,
            let makeText = makeTextField.text,
            let modelText = modelTextField.text,
            let zeroToSixtyText = zeroToSixtyTextField.text else { return }

        DataController.shared.addCarToList(year: yearText, make: makeText, model: modelText, zeroToSixty: zeroToSixtyText)
    }

}
