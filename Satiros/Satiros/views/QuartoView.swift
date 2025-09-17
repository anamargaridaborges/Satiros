//
//  TutorialView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI
import SwiftData

struct QuartoView: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@Binding var path: [Caminhos]
	//@FocusState private var estaFocado: FocusKey?
	@Bindable var bloco: ContextoConfessionario3.Bloco
	@State var falaNome: Bool = false
	@State private var fadeIn = false
	@State private var fadeOut = false
	@State var passaMural: Bool = false
	
	var body: some View {
		GeometryReader { geometry in
		ZStack(alignment: .topLeading){
			Image(dialogos[contexto.idDialogo].local_fundo)
				.resizable()
				.scaleEffect((dialogos[contexto.idDialogo].personagem == "Sister Desmond") ? 1.0 : 1.0)
				.aspectRatio(16 / 10, contentMode: .fit)
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			if(contexto.idDialogo == 111) {
				Button (action: {if (contexto.idDialogo == 111) {
					path.append(.mural)}}) {
						Image("muralzinho")
							.resizable()
							.scaledToFit()
							.frame(width: geometry.size.width * 0.25)
						//.contentShape(Rectangle())
							.onHover {over in
								passaMural = over
							}
					}
					.scaleEffect(passaMural && contexto.idDialogo == 111 ? 1.2 : 1)
					.buttonStyle(.plain)
					.offset(x: 650, y:200)
			}
			
			if (contexto.idDialogo != 111) {
				FalaView(path: $path, contexto: contexto, bloco: bloco, falaNome: defineFalaNome())
				
				AtributosView(contexto: contexto)
					.offset(x: (dialogos[contexto.idDialogo].personagem == "Sister Desmond") ? 30: 0, y: (dialogos[contexto.idDialogo].personagem == "Sister Desmond") ? 197 : 0)
				
				BotaoSair(contexto: contexto, path: $path)
				.offset(x: (dialogos[contexto.idDialogo].personagem == "Sister Desmond") ? -30: 0, y: (dialogos[contexto.idDialogo].personagem == "Sister Desmond") ? 197 : 0)
			}
			
		}
	}
		.aspectRatio(16/10, contentMode: .fit)
		.offset(y: (dialogos[contexto.idDialogo].personagem != "Sister Desmond") ? 0 : -200)
			.opacity(fadeIn ? 1 : 0)
			.animation(.easeIn(duration: 1), value: fadeIn)
			.opacity(fadeOut ? 0 : 1)
			.animation(.easeOut(duration: 2), value: fadeOut)
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			.navigationBarBackButtonHidden()
			.onChange(of: contexto.idDialogo) {
				if (contexto.idDialogo == 15) {
							contexto.horario = "confissao1"
					contexto.local = .confessionario
							contexto.parteDialogo = 0
					path.append(.confessionario)
				}
			}
			.onAppear {
				withAnimation { fadeIn = true }
			}
		}
	
	func defineFalaNome() -> Binding<Bool> {
		if (dialogos[contexto.idDialogo].personagem == "Sister Desmond" || dialogos[contexto.idDialogo].personagem == "You" || dialogos[contexto.idDialogo].personagem == "Radiovoice") {
			falaNome = true
		} else {
			falaNome = false
		}
		return $falaNome
	}
	
}

#Preview {
		//TutorialView()
}
