//
//  PersistantManager.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import RealmSwift

class PersistantManager {

	static var instance: PersistantManager {
		struct Static {
			static let instance: PersistantManager = PersistantManager()
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
	
	public func getObjects<T:Object>() -> [T] {
		
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
			}
		} catch {
			debugPrint(error.localizedDescription)
		}
	}
}
