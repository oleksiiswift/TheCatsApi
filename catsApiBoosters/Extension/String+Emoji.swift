//
//  String+Emoji.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 22.06.2022.
//

import Foundation

extension RangeReplaceableCollection where Self: StringProtocol {
	var removingEmoji: Self  {
		filter { !($0.unicodeScalars.first?.properties.isEmoji == true && !("0"..."9" ~= $0)) }
	}
}
