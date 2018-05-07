import UIKit
import RealmSwift

class FilterDateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let cellReuseIdentifier = "dateCarCell"

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!

    var startDateSelected: Date?
    var endDateSelected: Date?
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    var cars: [Car]?  //var cars: Results<Car>?
    let cal = Calendar(identifier: .gregorian)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        setupCloseKeyboardGesture()
        setupDatePickerView()
        setupDefaultDates()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    // Setup

    func setupCloseKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false     // So that didSelectRow on TableVC isn't disabled
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func setupDatePickerView() {

        startDatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date

        startDatePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        endDatePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)

        startDateTextField.inputView = startDatePicker
        endDateTextField.inputView = endDatePicker

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        toolbar.barStyle = .blackTranslucent
        toolbar.tintColor = .white
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(datePickerDoneButtonTapped))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([flexButton, doneButton], animated: true)
        startDateTextField.inputAccessoryView = toolbar
        endDateTextField.inputAccessoryView = toolbar
    }

    func setupDefaultDates() {
        let date = Date()
        let beginDate = cal.startOfDay(for: date) // Beginning of date at midnight
        let endingDate = cal.date(byAdding: .day, value: 1, to: beginDate)
        // End date: date at midnight + 1 day to get full day. For logic only, not UI.
        startDateSelected = beginDate
        endDateSelected = endingDate

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        startDateTextField.text = dateFormatter.string(from: beginDate)
        endDateTextField.text = dateFormatter.string(from: beginDate)
    }

    // Methods

    @objc func datePickerChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let beginningOfDate = cal.startOfDay(for: sender.date)

        if sender == startDatePicker {
            startDateSelected = beginningOfDate
            startDateTextField.text = dateFormatter.string(from: beginningOfDate)
        }

        if sender == endDatePicker {
            let endingDate = cal.date(byAdding: .day, value: 1, to: beginningOfDate)
            endDateSelected = endingDate
            print("End date selected (cuurent date + 1) \(dateFormatter.string(from: endDateSelected!))")
            endDateTextField.text = dateFormatter.string(from: beginningOfDate)
        }
    }

    @objc func datePickerDoneButtonTapped() {
        startDateTextField.resignFirstResponder()
        endDateTextField.resignFirstResponder()
    }

    // Actions

    @IBAction func searchButtonTapped(_ sender: UIButton) {

        guard let startDate = startDateSelected,
            let endDate = endDateSelected else {
                print("Need both start and end date")
                return
        }

        cars = DataController.shared.searchSoldCarsBySelectedDates(startDate: startDate, endDate: endDate)
        tableView.reloadData()
    }

    // TableView Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let carCount = cars?.count else { return 0 }
        return carCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)

        guard let cars = cars else { return UITableViewCell() }
        let car = cars[indexPath.row]

        cell.textLabel?.text = car.yearMakeModel

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy"
        cell.detailTextLabel?.text = dateFormatter.string(from: car.soldDate!)

        return cell
    }

}
