import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var zeroToSixtyTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    var car: Car?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCloseKeyboardGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        setupButtons()
        setupCar()
    }

    func setupButtons() {
        if car == nil {
            deleteButton.isHidden = true
            addButton.setTitle("Add", for: .normal)
        } else {
            deleteButton.isHidden = false
            addButton.setTitle("Update", for: .normal)
            if let car = car {
            print("Car's UUID = \(car.uuid)")
            }
        }
    }

    func setupCar() {
        if car != nil {
            yearTextField.text = car?.year
            makeTextField.text = car?.make
            modelTextField.text = car?.model
            zeroToSixtyTextField.text = car?.zeroToSixty
        }
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

        if car == nil {
            // Add
            DataController.shared.addCar(year: yearText, make: makeText, model: modelText, zeroToSixty: zeroToSixtyText)
            navigationController?.popViewController(animated: true)
        } else {
            // Update
            if let car = car {
            DataController.shared.updateCar(car: car, year: yearText, make: makeText, model: modelText, zeroToSixty: zeroToSixtyText)
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        // Delete
        guard let car = car else { return }

        DataController.shared.deleteCar(car: car)
        navigationController?.popViewController(animated: true)
    }
    
}
