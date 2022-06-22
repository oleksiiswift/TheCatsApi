//
//  AdvertisementViewController.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import UIKit

class AdvertisementViewController: UIViewController {
	
	@IBOutlet weak var cancelAdvertisementButton: UIButton!
	
	var advertisementTimer: Timer?
	var advertisementDuration: TimeInterval = Constants.Advertisement.advertisementDuration
	var stopTime: Date?
	var advertisementTextLabel = UILabel()
	let elapsedShapeLayer = CAShapeLayer()
	let backgroudShapeLayer = CAShapeLayer()
	
	override func viewDidLoad() {
		super.viewDidLoad()

		setupUI()
		blurSetup()
		drawBgShape()
		drawTimeLeftShape()
		advertisementLabelSetup()
		progressSetup()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		timerSetup()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		advertisementTimer?.invalidate()
		advertisementTimer = nil
	}
	
	@IBAction func didTapCancelAdvertisementActionButton(_ sender: Any) {
		AdvertisementMediator.instance.advertisementTryCancel()
	}
}

extension AdvertisementViewController {
	
	func drawBgShape() {
		
		backgroudShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX , y: view.frame.midY),
												radius: 100,
												startAngle: -90.radii,
												endAngle: 270.radii,
												clockwise: true).cgPath
		
		backgroudShapeLayer.strokeColor = Theme.progressCircleBackgroundColor.cgColor
		
		backgroudShapeLayer.fillColor = Theme.clearColor.cgColor
		backgroudShapeLayer.lineWidth = 20
		backgroudShapeLayer.masksToBounds = false
		backgroudShapeLayer.shadowOffset = CGSize(width: 6, height: 6)
		backgroudShapeLayer.shadowColor = UIColor.black.cgColor
		backgroudShapeLayer.shadowRadius = 14
		backgroudShapeLayer.shadowOpacity = 0.5
		
		self.view.layer.addSublayer(backgroudShapeLayer)
	}
	func drawTimeLeftShape() {
		
		elapsedShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX , y: view.frame.midY),
											  radius: 100,
											  startAngle: -90.radii,
											  endAngle: 270.radii,
											  clockwise: true).cgPath
		
		elapsedShapeLayer.strokeColor = Theme.progressCircleColor.cgColor
		elapsedShapeLayer.fillColor = Theme.clearColor.cgColor
		elapsedShapeLayer.lineWidth = 20
		
		self.view.layer.addSublayer(elapsedShapeLayer)
	}
	
	@objc func timerUpdate() {
		if advertisementDuration > 0 {
			advertisementDuration = stopTime?.timeIntervalSinceNow ?? 0
			let stringTime = advertisementDuration.getReadableTimeString
			updateAdvertisementDurationLabel(with: stringTime)
		} else {
			self.timerDidStop()
		}
	}
	
	private func timerDidStop() {
		updateAdvertisementDurationLabel(with: Constants.DefaultValues.zerotime)
		advertisementTimer!.invalidate()
		advertisementTimer = nil
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			AdvertisementMediator.instance.advertisementDidShow()
		}
	}
}

extension AdvertisementViewController {
	
	private func setupUI() {
		
		self.navigationController?.setNavigationBarHidden(true, animated: false)
		self.view.backgroundColor = .clear
		
		cancelAdvertisementButton.setImage(Images.Buttons.close, for: .normal)
		cancelAdvertisementButton.tintColor = Theme.titleTextColor
	}
	
	private func progressSetup() {
		
		let stroke = CABasicAnimation(keyPath: "strokeEnd")
		stroke.fromValue = 0
		stroke.toValue = 1
		stroke.duration = advertisementDuration
		elapsedShapeLayer.add(stroke, forKey: nil)
	}
	
	private func timerSetup() {
		
		stopTime = Date().addingTimeInterval(advertisementDuration)
		advertisementTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
	}
	
	private func updateAdvertisementDurationLabel(with text: String) {
		advertisementTextLabel.text = text
	}
	
	private func advertisementLabelSetup() {
		
		self.updateAdvertisementDurationLabel(with: advertisementDuration.getReadableTimeString)
		advertisementTextLabel.textAlignment = .center
		advertisementTextLabel.font = .systemFont(ofSize: 30, weight: .bold).withMonospacedNumbers()
		advertisementTextLabel.textColor = Theme.titleTextColor
		self.view.addSubview(advertisementTextLabel)
		advertisementTextLabel.translatesAutoresizingMaskIntoConstraints = false
		advertisementTextLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
		advertisementTextLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
		advertisementTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		advertisementTextLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
	}
	
	private func blurSetup() {
		
		let blurContainerView = UIView()
		let blurEffect = UIBlurEffect(style: .light)
		let visualEffectView = VisualEffectBlurView(effect: blurEffect, intencity: 0.2)
		
		visualEffectView.frame = self.view.bounds
		let dimmerView = UIView()
		
		dimmerView.backgroundColor = .black.withAlphaComponent(0.4)
		dimmerView.frame = self.view.bounds
		blurContainerView.addSubview(visualEffectView)
		blurContainerView.addSubview(dimmerView)
		self.view.addSubview(blurContainerView)
		self.view.sendSubviewToBack(blurContainerView)
	}
}
