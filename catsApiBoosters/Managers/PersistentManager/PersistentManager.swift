//
//  PersistentManager.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import RealmSwift

class PersistentManager {

	static var instance: PersistentManager {
		struct Static {
			static let instance: PersistentManager = PersistentManager()
		}
		return Static.instance
	}
	
	public func saveObjects<T:Object>(objects: [T], completionHandler: @escaping (_ saved: Bool) -> Void) {
		
		do {
			let realm = try Realm()
			try realm.write {
				realm.add(objects)
				completionHandler(true)
			}
		} catch {
			debugPrint(error.localizedDescription)
			completionHandler(false)
		}
	}
	
	public func getObjects<T:Object>(with type: T.Type) -> [T] {
		
		do {
			let realm = try Realm()
			let results = realm.objects(T.self)
			return Array(results)
		} catch {
			debugPrint(error.localizedDescription)
		}
		return []
	}
	
	public func removeAllObjects() {
		
		do {
			let realm = try Realm()
			try realm.write {
				realm.deleteAll()
				debugPrint("all data removed")
			}
		} catch {
			debugPrint(error.localizedDescription)
		}
	}
}
