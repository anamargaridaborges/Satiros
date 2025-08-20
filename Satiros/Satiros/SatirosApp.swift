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
	
    var body: some Scene {
        WindowGroup {
					IntroducaoView()
        }
				.modelContainer(for: ContextoSalvo.self)
    }
		
}
