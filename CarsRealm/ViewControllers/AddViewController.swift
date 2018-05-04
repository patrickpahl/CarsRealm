import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var zeroToSixtyTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var soldSwitch: UISwitch!
    @IBOutlet weak var dateSoldTextField: UITextField!
    @IBOutlet weak var salesPriceTextField: UITextField!
    @IBOutlet weak var soldLabel: UILabel!
    @IBOutlet weak var dateSoldLabel: UILabel!
    @IBOutlet weak var salesPriceLabel: UILabel!

    var car: Car?
    var carSold: Bool = false
    var dateSelected: Date?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCloseKeyboardGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        setupUI()
        setupCar()
        setupDatePickerView()
        setupSalesPriceTextField()
    }

    // Setup Methods

    func setupUI() {
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
            guard let car = car else { return }
            yearTextField.text = car.year
            makeTextField.text = car.make
            modelTextField.text = car.model
            zeroToSixtyTextField.text = car.zeroToSixty
            soldSwitch.isOn = car.sold
            carSold = car.sold

            if car.soldDate != nil {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "M/d/yyyy"
                dateSoldTextField.text = dateFormatter.string(from: car.soldDate!)
                dateSelected = car.soldDate!
            }

            let salesPrice = car.salesPrice
            if salesPrice == 0 {
                salesPriceTextField.text = ""
            } else {
                salesPriceTextField.text = String(describing: car.salesPrice)
            }
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

    func setupSalesPriceTextField() {
        salesPriceTextField.keyboardType = UIKeyboardType.decimalPad
    }

    func setupDatePickerView() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        dateSoldTextField.inputView = datePicker
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        toolbar.barStyle = .blackTranslucent
        toolbar.tintColor = .white
        let todayButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(datePickerTodayButtonTapped))
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(datePickerDoneButtonTapped))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([todayButton, flexButton, doneButton], animated: true)
        dateSoldTextField.inputAccessoryView = toolbar
    }

    // Methods

    @objc func datePickerChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateSelected = sender.date
        dateSoldTextField.text = dateFormatter.string(from: sender.date)
        print(dateSoldTextField.text ?? "")
    }

    @objc func datePickerTodayButtonTapped(sender: UIBarButtonItem) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateSelected = Date()
        dateSoldTextField.text = dateFormatter.string(from: Date())
        dateSoldTextField.resignFirstResponder()
    }

    @objc func datePickerDoneButtonTapped() {
        dateSoldTextField.resignFirstResponder()
    }

    // Actions
    @IBAction func addButtonTapped(_ sender: UIButton) {

        guard let yearText = yearTextField.text,
            let makeText = makeTextField.text,
            let modelText = modelTextField.text,
            let zeroToSixtyText = zeroToSixtyTextField.text else { return }

        var soldDate: Date?
        if self.dateSelected != nil {
            soldDate = self.dateSelected
        } else {
            soldDate = nil
        }

        var salesPrice = Int()
        if salesPriceTextField.text != "" {
            let salesPriceText = salesPriceTextField.text
            salesPrice = Int(salesPriceText!)!
        } else {
            salesPrice = 0
        }

        print("sold? \(carSold)")

        print("SOLD DATE =")
        print(soldDate)

        print("SALES PRICE =")
        print("\(salesPrice)")

        if carSold == true {
            if soldDate == nil || salesPrice == 0 {
                    print("If car is sold, date sold and sales price is required - return out of func")
                    return
                }
            }

        if car == nil {
            // Add
            DataController.shared.addCar(year: yearText, make: makeText, model: modelText, zeroToSixty: zeroToSixtyText, sold: carSold, soldDate: soldDate, salesPrice: salesPrice)
            navigationController?.popViewController(animated: true)
        } else {
            // Update
            if let car = car {
                DataController.shared.updateCar(car: car, year: yearText, make: makeText, model: modelText, zeroToSixty: zeroToSixtyText, sold: carSold, soldDate: soldDate, salesPrice: salesPrice)
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

    @IBAction func soldSwitchValueChanged(_ sender: UISwitch) {
        carSold = sender.isOn ? true : false
        print("Car sold bool = \(carSold)")
        if carSold == false {
            dateSoldTextField.text = nil
            salesPriceTextField.text = nil
            dateSelected = nil
        }
    }

    @IBAction func clearButtonTapped(_ sender: UIButton) {
        dateSoldTextField.text = ""
        dateSelected = nil
    }
    
}
