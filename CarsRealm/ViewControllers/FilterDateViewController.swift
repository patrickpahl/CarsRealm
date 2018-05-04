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
    var cars: Results<Car>?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        getAllSoldCars()
    }

    // Setup

    func getAllSoldCars() {
        cars = DataController.shared.filterSoldCars().sorted(byKeyPath: "soldDate", ascending: false)
        tableView.reloadData()
    }

    // Methods

    func setupCloseKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false     // So that didSelectRow on TableVC isn't disabled
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
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

    @IBAction func searchButtonTapped(_ sender: UIButton) {

    }

    @IBAction func clearButtonTapped(_ sender: UIButton) {
        getAllSoldCars()
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
        cell.detailTextLabel?.text = dateFormatter.string(from: car.soldDate)

        return cell
    }

}