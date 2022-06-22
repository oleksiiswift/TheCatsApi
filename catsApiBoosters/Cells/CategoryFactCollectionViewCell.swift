//
//  CategoryFactCollectionViewCell.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 22.06.2022.
//

import UIKit

enum ElementhPosition {
	case first
	case last
	case regular
}

protocol CategoryFactCellDelegate {
	
	func didTapScrollForward(_ cell: CategoryFactCollectionViewCell)
	func didTapScrollBackward(_ cell: CategoryFactCollectionViewCell)
}

class CategoryFactCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var baseView: UIView!
	@IBOutlet weak var imageContainerView: UIView!
	@IBOutlet weak var imageConteinerReuseShadowView: ReuseShadowView!
	@IBOutlet weak var contentImageView: UIImageView!
	@IBOutlet weak var forwardButton: UIButton!
	@IBOutlet weak var backwardButtom: UIButton!
	@IBOutlet weak var factTextLabel: UILabel!
	
	private lazy var activityIndicatorView = UIActivityIndicatorView()
	public var delegate: CategoryFactCellDelegate?
	
	override func awakeFromNib() {
        super.awakeFromNib()
        
		setupUI()

    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		contentImageView.image = nil
	}
	
	@IBAction func didTapBackwardActionButton(_ sender: Any) {
		delegate?.didTapScrollBackward(self)
	}
	
	@IBAction func didTapForwardActionButton(_ sender: Any) {
		delegate?.didTapScrollForward(self)
	}
}

extension CategoryFactCollectionViewCell {
	
	public func configureCell(with model: AnimalContentModel, position: ElementhPosition) {
		setupActivityIndicator()
		factTextLabel.text = model.fact ?? "-"
		backwardButtom.isEnabled = position != .first
		forwardButton.isEnabled = position != .last
	}
	
	public func configureCell(with image: UIImage?) {
		
		if let image = image {
			setIndicatorHide()
			contentImageView.image = image
		}
	}
}

extension CategoryFactCollectionViewCell {
	
	private func setIndicatorHide() {
		
		activityIndicatorView.isHidden = true
		activityIndicatorView.stopAnimating()
	}
	
	private func showIndicator() {
		
		activityIndicatorView.isHidden = false
		activityIndicatorView.startAnimating()
	}
}

extension CategoryFactCollectionViewCell {
	
	private func setupUI() {
	
		factTextLabel.font = .systemFont(ofSize: 12, weight: .medium)
		factTextLabel.textColor = Theme.subTitleTextColor
		factTextLabel.sizeToFit()
		factTextLabel.numberOfLines = 0
				
		let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
		var forwardConfiguration = UIButton.Configuration.plain()
		forwardConfiguration.image = Images.Buttons.arrowForward
		forwardConfiguration.imagePlacement = .leading
		forwardConfiguration.preferredSymbolConfigurationForImage = largeConfig
		forwardConfiguration.baseBackgroundColor = .clear
		forwardConfiguration.baseForegroundColor = Theme.titleTextColor
		forwardButton.configuration = forwardConfiguration
		
		var backwardConfiguration = UIButton.Configuration.plain()
		backwardConfiguration.image = Images.Buttons.arrowBackward
		backwardConfiguration.imagePlacement = .leading
		backwardConfiguration.preferredSymbolConfigurationForImage = largeConfig
		backwardConfiguration.baseBackgroundColor = .clear
		backwardConfiguration.baseForegroundColor = Theme.titleTextColor
		backwardButtom.configuration = backwardConfiguration
		
		imageConteinerReuseShadowView.cornerRadius = 12
		imageConteinerReuseShadowView.viewShadowOffsetOriginX = 4
		imageConteinerReuseShadowView.viewShadowOffsetOriginY = 4
		
		imageContainerView.backgroundColor = .clear
		imageContainerView.setCorner(12)
		contentImageView.contentMode = .scaleAspectFill
		
		activityIndicatorView.color = Theme.loadingActivityIndicatorColor
	}
	
	private func setupActivityIndicator() {
		
		contentImageView.layoutIfNeeded()
		self.contentView.layoutIfNeeded()
		let activityIndicatorSize = CGSize(width: 20, height: 20)
		let activityIndicatorPoint = CGPoint(x: (imageContainerView.frame.width / 2) - activityIndicatorSize.width / 2, y: (imageContainerView.frame.height / 2) - activityIndicatorSize.width / 2)
		activityIndicatorView.frame = CGRect(origin: activityIndicatorPoint, size: activityIndicatorSize)
		contentImageView.addSubview(activityIndicatorView)
		contentImageView.bringSubviewToFront(activityIndicatorView)
		showIndicator()
	}
}
