import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var cars: List<Car>!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        let realm = try! Realm()
        User.defaultUser(in: realm)

        cars = User.defaultUser(in: realm).cars
        print("Cars count = \(cars.count)")
        tableView.reloadData()
    }

    // Tableview Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseIdentifier, for: indexPath) as? CarTableViewCell else { return UITableViewCell() }

        let car = cars[indexPath.row]
        cell.configureWithCar(car)

        return cell
    }

}
