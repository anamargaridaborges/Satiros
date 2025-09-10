//
//  Fonte.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 20/08/25.
//

import Foundation
import SwiftUI

extension Font {
		static func VT323(size: CGFloat) -> Font {
				.custom("VT323-Regular", size: size)
		}
}


extension Font {
		static func appFont(_ selectedFont: String, size: CGFloat, weight: Font.Weight = .regular) -> Font {
				switch selectedFont {
				case "SFPro":
						return .system(size: size-5, weight: weight)
				default:
						return .custom("VT323-Regular", size: size)
				}
		}
}

