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
				let fileManager = FileManager.default
						let storeURL = URL.documentsDirectory
								.deletingLastPathComponent()
								.appending(path: "Library")
								.appending(path: "Application Support")
								.appending(path: "default.store")

						if fileManager.fileExists(atPath: storeURL.path) {
								do {
										try fileManager.removeItem(at: storeURL)
								} catch {
									fatalError("Failed to initialize model container.")
								}
						}
				container = try! ModelContainer(
					for: ContextoConfessionario3.ContextoConfessionario.self, ContextoConfessionario3.ContextoSalvo.self, ContextoConfessionario3.Bloco.self,
						migrationPlan: ConfessionarioMigracao.self
				)
					//fatalError("Failed to initialize model container.")
			}
	}
	
	var body: some Scene {
			WindowGroup {
				IntroducaoView()
			}
			.modelContainer(container)
	}
}
