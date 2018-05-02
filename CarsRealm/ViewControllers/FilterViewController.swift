import UIKit
import RealmSwift

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let cellReuseIdentifier = "filterCell"

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var filterButton: UIButton!

    var cars: Results<Car>?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        let realm = try! Realm()
        cars = realm.objects(Car.self).sorted(byKeyPath: "year", ascending: false)
        tableView.reloadData()
    }

    // TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let carCount = cars?.count else { return 0 }
        return carCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)

        guard let cars = self.cars else { return UITableViewCell() }

        let car = cars[indexPath.row]

        cell.textLabel?.text = car.year
        cell.detailTextLabel?.text = car.makeAndModel

        return cell
    }

    // Action

    @IBAction func filterButtonTapped(_ sender: UIButton) {
        guard let makeText = makeTextField.text else { return }

        cars = DataController.shared.filterByMakeName(makeText).sorted(byKeyPath: "year", ascending: false)
        tableView.reloadData()
    }
}
