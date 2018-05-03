import UIKit
import RealmSwift

class CarSoldViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var cars: Results<Car>?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        //let realm = try! Realm()
        //cars = realm.objects(Car.self).sorted(byKeyPath: "year", ascending: false)
        cars = DataController.shared.filterSoldCars()
        tableView.reloadData()
    }

    // TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let carCount = cars?.count else { return 0 }
        return carCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cars = cars else { return UITableViewCell() }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: SoldCarTableViewCell.reuseIdentifier, for: indexPath) as? SoldCarTableViewCell else { return UITableViewCell() }

        let car = cars[indexPath.row]
        cell.yearMakeModelLabel.text = car.yearMakeModel
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy"
        cell.dateSoldLabel.text = dateFormatter.string(from: car.soldDate!)
        cell.salesPriceLabel.text = String(car.salesPrice)
        return cell
    }

}
