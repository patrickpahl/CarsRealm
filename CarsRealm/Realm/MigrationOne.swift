import Foundation
import RealmSwift
/*
@objc(Version1Migrator)
class Version1Migrator: BaseMigrator {
    override func version() -> UInt64 {
        return 1
    }
    override func perform(migration: Migration) {
        /*
         Here we introduced primary key for route info model
         */
        migration.enumerateObjects(ofType: RouteInfoModel.className()) { _, newObject in
            // Made it simple, just remove all non visible recent routes i.e which don't have primary keys/generated prior to this implementation,
            // Routes added after this migration will have primary key and updated handling for current locations
            guard let object = newObject else {
                return
            }
            guard let pk = object["pk"] as? String,
                !pk.isEmpty else {
                    migration.delete(object)
                    return
            }
        }
    }
}
*/
