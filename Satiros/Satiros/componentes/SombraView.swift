//
//  SombraView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 02/09/25.
//

import SwiftUI

struct SombraView: View {
	
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@State private var frameIndex = 0
	@State var tick: Bool = false
	@Binding var isSpeaking: Bool
	let frames = ["fala1", "fala2", "fala3", "fala4", "fala5", "fala6"]
	
	var body: some View {
		ZStack(alignment: .topLeading) {
			Image(frames[frameIndex])
				.resizable()
				.scaledToFill()
				.ignoresSafeArea()
				.onChange(of: tick) { oldValue, newValue in
					if isSpeaking {
						frameIndex = (frameIndex + 1) % frames.count
					}
				}.task {
					var timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) {_ in
						Task {
							await MainActor.run {
								tick.toggle()
							}
						}
					}
				}
			
				AtributosView(contexto: contexto)
				.padding(.top, 30)
		}
	}
}

#Preview {
    //SombraView()
}
