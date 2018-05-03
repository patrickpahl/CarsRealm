import UIKit

class SoldCarTableViewCell: UITableViewCell {

    @IBOutlet weak var yearMakeModelLabel: UILabel!
    @IBOutlet weak var dateSoldLabel: UILabel!
    @IBOutlet weak var salesPriceLabel: UILabel!

    static let reuseIdentifier = "soldCarCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
