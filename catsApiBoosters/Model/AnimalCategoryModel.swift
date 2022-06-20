//
//  AnimalCategoryModel.swift
//
//
//  Created by alexey sorochan on 20.06.2022.
//

import RealmSwift

class AnimalCategoryModel: Object, Decodable {
	@Persisted var title: String?
	@Persisted var objectDescription: String?
	@Persisted var imageURL: String?
	@Persisted var imageChacheID: String = UUID().uuidString
	@Persisted var order: Int = 0
	@Persisted var status: StatusEnum = .unknown
	@Persisted var content = List<AnimalContentModel>()
	
	enum CodingKeys: String, CodingKey {
		case title
		case objectDescription = "description"
		case imageURL = "image"
		case order
		case status
		case content
	}
	
	override init() {
		super.init()
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Self.CodingKeys)
		
		self.title = try container.decode(String.self, forKey: .title)
		self.objectDescription = try container.decode(String.self, forKey: .objectDescription)
		self.imageURL = try container.decode(String.self, forKey: .imageURL)
		self.order = try container.decode(Int.self, forKey: .order)
		
		let status = try container.decode(String.self, forKey: .status)
		
		switch status {
			case Constants.CodingKeysRawValues.free:
				self.status = .free
			case Constants.CodingKeysRawValues.paid:
				self.status = .paid
			default:
				self.status = .unknown
		}
		
		let content = try container.decodeIfPresent(List<AnimalContentModel>.self, forKey: .content)
		if let persistentContent = content {
			self.content = persistentContent
		}
	}
}

class AnimalContentModel: Object, Decodable {
	@Persisted var fact: String?
	@Persisted var imageURL: String?
	@Persisted var imageChacheID: String = UUID().uuidString
	
	enum CodingKeys: String, CodingKey {
		case fact
		case imageURL = "image"
	}
}

enum StatusEnum: String, CaseIterable, PersistableEnum {
	case free
	case paid
	case unknown
}
