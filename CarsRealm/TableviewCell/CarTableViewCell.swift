import UIKit

class CarTableViewCell: UITableViewCell {

    static let reuseIdentifier = "CarCell"

    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var zeroToSixtyLabel: UILabel!

    func configureWithCar(_ car: Car) {
        yearLabel.text = car.year
        makeLabel.text = car.make
        modelLabel.text = car.model
        zeroToSixtyLabel.text = car.zeroToSixty
    }

}
