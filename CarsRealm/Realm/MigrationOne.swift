//import Foundation
//import RealmSwift
//
//@objc(Version1Migrator)
//class Version1Migrator: BaseMigrator {
//
//    /// Set version here
//    override func version() -> UInt64 {
//        return 2
//    }
//    override func perform(migration: Migration) {
//
//        // Adding the sold bool and soldDate
//
//        migration.enumerateObjects(ofType: Car.className()) { _, newObject in
//            guard let object = newObject else {
//                return
//            }
//
//            guard let sold = object["sold"] as? Bool,
//                sold != true else {
//                    migration.delete(object)
//                    return
//            }
//
//            guard let soldDate = object["soldDate"] as? Date?,
//                soldDate == nil else {
//                    migration.delete(object)
//                    return
//            }
//
//        }
//    }
//}

