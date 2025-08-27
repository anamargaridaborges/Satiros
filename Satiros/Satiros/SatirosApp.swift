//
//  SatirosApp.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 19/08/25.
//

import SwiftUI
import SwiftData

@main
struct SatirosApp: App {
	//@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	var body: some Scene {
			WindowGroup {
				IntroducaoView()
			}
			.modelContainer(for: ContextoSalvo.self)
	}
}
