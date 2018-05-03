import UIKit

class SoldCarTableViewCell: UITableViewCell {

    @IBOutlet weak var yearMakeModelLabel: UILabel!
    @IBOutlet weak var dateSoldLabel: UILabel!
    @IBOutlet weak var salesPriceLabel: UILabel!

    static let reuseIdentifier = "soldCarCell"

}
