//
//  TimeInterval.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import Foundation

extension TimeInterval {
	
	var getReadableTimeString: String {
		return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
	}
}
