//import Foundation
//import RealmSwift
//
//protocol MigratorImplementation {
//    func version() -> UInt64
//    func perform(migration: Migration)
//}
//
//class BaseMigrator: NSObject, MigratorImplementation {
//    required override init() {
//    }
//    func version() -> UInt64 {
//        return 0
//    }
//    func perform(migration: Migration){
//    }
//}
//
//class MigrationHandler {
//
//    static func perform(migration: Migration, from: UInt64, to: UInt64) {
//
//        var migrators: [BaseMigrator] = []
//        for i in (from + 1)...to {
//            let className = "Version\(i)Migrator"
//            guard let classFromString = NSClassFromString(className) as? BaseMigrator.Type else {
//                continue
//            }
//            migrators.append(classFromString.init())
//        }
//        for migrator in migrators {
//            migrator.perform(migration: migration)
//        }
//    }
//
//}

