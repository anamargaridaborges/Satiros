//
//  SatirosApp.swigit ft
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 19/08/25.
//

import SwiftUI
import SwiftData

@main
struct SatirosApp: App {
	//@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	
	let container: ModelContainer
	
	init() {
			do {
					container = try ModelContainer(
						for: ContextoConfessionario3.ContextoConfessionario.self, ContextoConfessionario3.ContextoSalvo.self, ContextoConfessionario3.Bloco.self,
							migrationPlan: ConfessionarioMigracao.self
					)
			} catch {
					fatalError("Failed to initialize model container.")
			}
	}
	
	var body: some Scene {
			WindowGroup {
				IntroducaoView()
			}
			.modelContainer(container)
	}
}
