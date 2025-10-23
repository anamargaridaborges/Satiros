//
//  animacaoFala.swift
//  Satiros
//
//  Created by Jordana Lourenço Santos on 22/10/25.
//

import SwiftUI

struct animacaoFala: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@State private var frameIndex = 0
	@State var tick: Bool = false
	@Binding var isSpeaking: Bool
	
	private var frames: [String] {
			let personagem = dialogos[contexto.idDialogo].personagem
			switch personagem {
			case "Sister Desmond":
					return ["d1", "d2", "d3"]
			case "Edgar":
					return ["edgar1", "edgar2", "edgar3"]
			case "Thomas":
					return ["thomas1", "thomas2", "thomas3"]
			default:
					return [""]
				
			}
	}
	
	var body: some View {
		Image(frameIndex < frames.count ? frames[frameIndex]: "")
			.resizable()
			.frame(width: 350, height: 345, alignment: .bottom)
			.clipped()
			.offset(x: -300, y:10)
			.onChange(of: tick) { oldValue, newValue in
				if isSpeaking {
					frameIndex = (frameIndex + 1) % (frames.count)
				}
			}.task {
				var timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) {_ in
					Task {
						await MainActor.run {
							tick.toggle()
						}
					}
				}
			}
	}
}
