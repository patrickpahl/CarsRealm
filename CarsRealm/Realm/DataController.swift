import Foundation
import RealmSwift

class DataController {

    static let shared = DataController()

    func addCar(year: String, make: String, model: String, zeroToSixty: String) {
        let realm = try! Realm()
        let car = Car()
        car.year = year
        car.make = make
        car.model = model
        car.zeroToSixty = zeroToSixty

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

    func updateCar(car: Car, year: String, make: String, model: String, zeroToSixty: String) {
        let realm = try! Realm()
        try! realm.write {
            car.year = year
            car.make = make
            car.model = model
            car.zeroToSixty = zeroToSixty
        }
    }

    func filterByMakeName(_ makeText: String) -> Results<Car> {
        let realm = try! Realm()
        //let predicate = NSPredicate(format: "make = %@", makeText)
        //let cars = realm.objects(Car.self).filter(predicate)  /// case sensitive filter
        let cars = realm.objects(Car.self).filter("make contains[c] %d", makeText) /// case insensitive filter
        return cars
    }

}
