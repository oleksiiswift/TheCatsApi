//
//  CategoryTableViewCell.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
	
	@IBOutlet weak var imageContainerReuseShadowView: ReuseShadowView!
	@IBOutlet weak var stackView: UIStackView!
	@IBOutlet weak var baseView: UIView!
	@IBOutlet weak var imageContainerView: UIView!
	@IBOutlet weak var thumbnailImageView: UIImageView!
	@IBOutlet weak var titleTextLabel: UILabel!
	@IBOutlet weak var subtitleTextLabel: UILabel!
	@IBOutlet weak var paidButton: UIButton!
	
	lazy var dimmerView = UIView()
	
	private lazy var activityIndicatorView = UIActivityIndicatorView()
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
		self.setIndicatorHide()
		self.setupUI()
		self.dimmerViewSetup()
    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		self.dimmerView.isHidden = true
		self.thumbnailImageView.image = nil
	}
	
	@IBAction func didTapPaidActionButton(_ sender: Any) {
		
	}
}

extension CategoryTableViewCell {

	public func configureCell(with model: AnimalCategoryModel) {
		
		titleTextLabel.text = model.title ?? ""
		subtitleTextLabel.text = model.objectDescription ?? ""
		
		self.paidButton.isHidden = !(model.status == .paid)
		self.dimmerView.isHidden = !model.content.isEmpty
	}
	
	public func configure(with image: UIImage?) {
		
		if let image = image {
			self.setIndicatorHide()
			thumbnailImageView.image = image
		}
	}
}

extension CategoryTableViewCell {
	
	private func setupUI() {
	
		self.selectionStyle = .none
		self.contentView.backgroundColor = .clear
		paidButton.isHidden = true
		
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.alignment = .fill
		stackView.spacing = 3
		
		imageContainerReuseShadowView.cornerRadius = 12
		imageContainerReuseShadowView.viewShadowOffsetOriginX = 4
		imageContainerReuseShadowView.viewShadowOffsetOriginY = 4
		
		imageContainerView.backgroundColor = .clear
		imageContainerView.setCorner(12)
		thumbnailImageView.contentMode = .scaleAspectFill
		
		titleTextLabel.font = .systemFont(ofSize: 14, weight: .bold)
		subtitleTextLabel.font = .systemFont(ofSize: 12, weight: .medium)
		
		titleTextLabel.textColor = Theme.titleTextColor
		subtitleTextLabel.textColor = Theme.subTitleTextColor
		subtitleTextLabel.numberOfLines = 0
		
		activityIndicatorView.color = .black.withAlphaComponent(0.8)
		let activityIndicatorSize = CGSize(width: 20, height: 20)
		let activityIndicatorPoint = CGPoint(x: (imageContainerView.frame.width / 2) - activityIndicatorSize.width / 2, y: (imageContainerView.frame.height / 2) - activityIndicatorSize.width / 2)
		activityIndicatorView.frame = CGRect(origin: activityIndicatorPoint, size: activityIndicatorSize)
		imageContainerView.addSubview(activityIndicatorView)
		imageContainerView.bringSubviewToFront(activityIndicatorView)
		showIndicator()
		
		var paidButtonConfig = UIButton.Configuration.plain()
		paidButtonConfig.title = "Premium"
		paidButtonConfig.image = Images.Buttons.locker
		paidButtonConfig.imagePadding = 2.0
		paidButtonConfig.imagePlacement = .leading
		paidButtonConfig.baseBackgroundColor = .clear
		paidButtonConfig.baseForegroundColor = Theme.premiumButtonLinkColor
		paidButtonConfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -2, bottom: 0, trailing: 0)
		paidButton.configuration = paidButtonConfig
	}
	
	private func dimmerViewSetup() {
		
		self.dimmerView.backgroundColor = .clear

		self.contentView.addSubview(self.dimmerView)
		self.contentView.bringSubviewToFront(self.dimmerView)
		
		self.dimmerView.translatesAutoresizingMaskIntoConstraints = false
		self.dimmerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
		self.dimmerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
		self.dimmerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
		self.dimmerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
		
		let blankView = UIView()
		blankView.backgroundColor = .white
		blankView.alpha = 0.5
		self.dimmerView.addSubview(blankView)
		blankView.translatesAutoresizingMaskIntoConstraints = false
		blankView.leadingAnchor.constraint(equalTo: self.dimmerView.leadingAnchor).isActive = true
		blankView.trailingAnchor.constraint(equalTo: self.dimmerView.trailingAnchor).isActive = true
		blankView.topAnchor.constraint(equalTo: self.dimmerView.topAnchor).isActive = true
		blankView.bottomAnchor.constraint(equalTo: self.dimmerView.bottomAnchor).isActive = true
		
		
		let commingSoonTextLabel = UILabel()
		commingSoonTextLabel.font = .systemFont(ofSize: 12, weight: .bold)
		commingSoonTextLabel.text = "Comming \nSoon"
		commingSoonTextLabel.numberOfLines = 2
		commingSoonTextLabel.setCorner(8)
		commingSoonTextLabel.layer.borderWidth = 3
		commingSoonTextLabel.layer.borderColor = UIColor.black.cgColor
		commingSoonTextLabel.textAlignment = .center
		
		self.dimmerView.addSubview(commingSoonTextLabel)
		self.dimmerView.bringSubviewToFront(commingSoonTextLabel)
		commingSoonTextLabel.translatesAutoresizingMaskIntoConstraints = false
		commingSoonTextLabel.trailingAnchor.constraint(equalTo: self.dimmerView.trailingAnchor, constant: -40).isActive = true
		commingSoonTextLabel.topAnchor.constraint(equalTo: self.dimmerView.topAnchor, constant: 40).isActive = true
		commingSoonTextLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
		commingSoonTextLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
		
		var transform = CGAffineTransform.identity
		let size = commingSoonTextLabel.bounds.size
		transform = transform.translatedBy(x: -size.width / 2, y: size.height / 2)
		transform = transform.rotated(by: -CGFloat(0.3) * CGFloat.pi / 2)
		transform = transform.translatedBy(x: size.width / 2, y: -size.height / 2)
		commingSoonTextLabel.transform = transform
	}

	private func setIndicatorHide() {
		
		activityIndicatorView.isHidden = true
		activityIndicatorView.stopAnimating()
	}
	
	private func showIndicator() {
		
		activityIndicatorView.isHidden = false
		activityIndicatorView.startAnimating()
	}
}
