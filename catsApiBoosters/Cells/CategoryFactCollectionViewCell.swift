//
//  CategoryFactCollectionViewCell.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 22.06.2022.
//

import UIKit

class CategoryFactCollectionViewCell: UICollectionViewCell {
	
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
	
}

extension CategoryFactCollectionViewCell {
	
	public func configureCell(with model: AnimalContentModel) {
		
		debugPrint(model.fact)
		
	}
	
	public func configureCell(with image: UIImage?) {
		
		
	}
}
