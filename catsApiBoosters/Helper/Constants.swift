//
//  Constants.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import Foundation

struct Constants {
	
	struct Links {
	
		static let apiLink = "https://drive.google.com/uc?export=download&id=1Fs6RwY3a3ZNWDyXDbU-BgcfkN4oSJak4"
//		static let apiLink = "https://drive.google.com/uc?export=download&id=12L7OflAsIxPOF47ssRdKyjXoWbUrq4V5"
	}
	
	struct Advertisement {
		static let advertisementDuration: TimeInterval = 5
	}
	
	struct Identifiers {
		
		struct Stroryboards {
			static let main = "Main"
			static let loader = "Loader"
		}
		
		struct ViewControllers {
			static let categoriesList = "CategoriesListViewController"
			static let categoriesFacts = "CategoriesFactsViewController"
			static let loader = "LoaderViewController"
			static let advertisement = "AdvertisementViewController"
		}
		
		struct Cells {
			static let category = "CategoryTableViewCell"
			static let fact = "CategoryFactCollectionViewCell"
		}
		
		struct Xibs {
			static let category = "CategoryTableViewCell"
			static let fact = "CategoryFactCollectionViewCell"
		}
	}
	
	struct CodingKeysRawValues {
		
		static let free = "free"
		static let paid = "paid"
	}
	
	struct Notification {
		
		static let updateDataBase = "com.cats.databaseDidUpdate"
	}
	
	struct DefaultValues {
		static let zerotime = "00:00"
	}
}
