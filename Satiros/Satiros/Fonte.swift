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
		static func appFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
				let selectedFont = UserDefaults.standard.string(forKey: "selectedFont") ?? "VT323"

				switch selectedFont {
				case "SFPro":
						return .system(size: size, weight: weight)
				default:
						return .custom("VT323-Regular", size: size)
				}
		}
}
