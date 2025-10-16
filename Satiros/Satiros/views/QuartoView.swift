//
//  TutorialView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI
import SwiftData
import WidgetKit

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
	@State var clicaBloco: Bool = false
	
		var body: some View {
			ZStack(alignment: .topLeading){
				Image(dialogos[contexto.idDialogo].local_fundo)
						.resizable()
						.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
				
				if (!clicaBloco) {
					if(contexto.idDialogo == 111) {
						Button (action: {path.append(.mural)}) {
							Image("muralzinho")
								.resizable()
								.scaledToFit()
								.frame(width: 350, height: 300)
								.onHover {over in
									passaMural = over
								}
						}
						.scaleEffect(passaMural ? 1.2 : 1)
						.buttonStyle(.plain)
						.offset(x: 650, y: 150)
						
						Image("radio")
							.resizable()
							.scaledToFit()
							.frame(width: 200, height: 200)
							.offset(x: 400, y: 390)
						
					} else {
						FalaView(path: $path, contexto: contexto, bloco: bloco, falaNome: defineFalaNome())
						if(contexto.idDialogo >= 59){
							Image("radio")
								.resizable()
								.scaledToFit()
								.frame(width: 200, height: 200)
								.offset(x: 400, y: 390)
						}
					}
					
					AtributosView(contexto: contexto)
					BotaoNotas(contexto: contexto, path: $path, clicaBloco: $clicaBloco)
						.padding(.trailing, 80)
					BotaoSair(contexto: contexto, path: $path)
				}
				else {
					BlocoView(path: $path, bloco: bloco, clicaNotas: $clicaBloco)
						.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
				}
			}
			.aspectRatio(16/10, contentMode: .fill)
			.opacity(fadeIn ? 1 : 0)
			.animation(.easeIn(duration: 1), value: fadeIn)
			.opacity(fadeOut ? 0 : 1)
			.animation(.easeOut(duration: 2), value: fadeOut)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.navigationBarBackButtonHidden()
			.onChange(of: contexto.idDialogo) {
				defineFalaNome()
				if (contexto.idDialogo == 1){
					salvarImagemEscolhida("mural1")
				}
			}
			.onAppear {
				withAnimation { fadeIn = true }
			}
		}
	
	private func salvarImagemEscolhida(_ nome: String) {
			let defaults = UserDefaults(suiteName: "group.satiros.Satiros")
			defaults?.set(nome, forKey: "widgetImage")
		if defaults != nil {
			print("Estou aqui")
			print(defaults?.string(forKey: "widgetImage"))
		} else {
			print("Não funfou!!")
		}
			WidgetCenter.shared.reloadTimelines(ofKind: "MuralWidget")
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
