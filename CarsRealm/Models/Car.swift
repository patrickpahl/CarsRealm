import Foundation
import RealmSwift

class Car: Object {

    @objc dynamic var uuid = UUID().uuidString
    @objc dynamic var year = "2000"
    @objc dynamic var make = "BMW"
    @objc dynamic var model = "328i"
    @objc dynamic var zeroToSixty = "7.0"

    override static func primaryKey() -> String? {
        return "uuid"
    }

    var makeAndModel: String {
        return make + " " + model
    }

}
