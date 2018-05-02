import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let detailSegueIdentifier = "detailSegue"

    @IBOutlet weak var tableView: UITableView!

    var cars: Results<Car>!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        let realm = try! Realm()
        cars = realm.objects(Car.self)

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

    // Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier {
            guard let addVC = segue.destination as? AddViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
            let car = cars[indexPath.row]
            addVC.car = car
        }
    }

}
