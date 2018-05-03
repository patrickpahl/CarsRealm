import Foundation
import RealmSwift

class DataController {

    static let shared = DataController()

//    init() {
//        setupRealm()
//    }
//
//    /// Increase current version when performing a migration
//    func setupRealm() {
//        let currentVersion: UInt64 = 2
//        let config = Realm.Configuration(
//            schemaVersion: currentVersion,
//            migrationBlock: { migration, oldSchemaVersion in
//        })
//        Realm.Configuration.defaultConfiguration = config
//    }

    func addCar(year: String, make: String, model: String, zeroToSixty: String, sold: Bool, soldDate: Date?, salesPrice: Int) {
        let realm = try! Realm()
        let car = Car()
        car.year = year
        car.make = make
        car.model = model
        car.zeroToSixty = zeroToSixty
        car.sold = sold
        car.soldDate = soldDate
        car.salesPrice = salesPrice

        try! realm.write {
            realm.add(car)
        }
    }

    func deleteCar(car: Car) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(car)
        }
    }

    func updateCar(car: Car, year: String, make: String, model: String, zeroToSixty: String, sold: Bool, soldDate: Date?, salesPrice: Int) {
        let realm = try! Realm()
        try! realm.write {
            car.year = year
            car.make = make
            car.model = model
            car.zeroToSixty = zeroToSixty
            car.sold = sold
            car.soldDate = soldDate
            car.salesPrice = salesPrice
        }
    }

    func filterByMakeName(_ makeText: String) -> Results<Car> {
        let realm = try! Realm()
        //let predicate = NSPredicate(format: "make = %@", makeText)
        //let cars = realm.objects(Car.self).filter(predicate)  /// case sensitive filter
        let cars = realm.objects(Car.self).filter("make contains[c] %d", makeText) /// case insensitive filter
        return cars
    }

    func filterSoldCars() -> Results<Car> {

        let realm = try! Realm()
        let soldCars = realm.objects(Car.self).filter("sold = true")
        return soldCars
    }

}
