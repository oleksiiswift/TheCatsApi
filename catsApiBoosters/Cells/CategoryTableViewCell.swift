//
//  CategoryTableViewCell.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
		self.setupUI()
    }
}


extension CategoryTableViewCell {

	public func configureCell(with model: AnimalCategoryModel) {
		
		debugPrint(model.title)
		debugPrint(model.imageChacheID)
		debugPrint(model.objectDescription)
		
	}
	
	public func configure(with image: UIImage?) {
		
		debugPrint(image)
	}
}

extension CategoryTableViewCell {
	
	private func setupUI() {
		
		self.selectionStyle = .none
		self.contentView.backgroundColor = .clear
	}
}
