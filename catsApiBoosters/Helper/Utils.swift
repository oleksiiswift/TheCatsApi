//
//  Utils.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import Foundation
import UIKit

class Utils {
	
	static let application: UIApplication = .shared
	
	static let appDelegate: AppDelegate = application.delegate as! AppDelegate
	
	static let scene = UIApplication.shared.connectedScenes.first
	
	static let sceneDelegate: SceneDelegate = scene!.delegate as! SceneDelegate
	
}
