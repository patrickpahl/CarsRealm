import Foundation
import RealmSwift

class DataController {

    static let shared = DataController()

    func addCarToList(year: String, make: String, model: String, zeroToSixty: String) {

        let realm = try! Realm()
        let user = User.defaultUser(in: realm)

        let car = Car()
        car.year = year
        car.make = make
        car.model = model
        car.zeroToSixty = zeroToSixty

        try! realm.write {
            user.cars.append(car)
        }
    }


}
