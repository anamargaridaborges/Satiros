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
	@Binding var path: [String]
	@FocusState private var estaFocado: FocusKey?
	@State var texto: String = ""
	//@State var idFala: Int = 0
	@State var opcoes: [String] = []
	@State var terminou: Bool = true
	@State private var tarefaOpcoes: Task<Void, Never>? = nil
	@Bindable var bloco: ContextoConfessionario3.Bloco
	@State var falaNome: Bool = false
	@State private var fadeIn = false
	@State private var fadeOut = false
	let frames = ["cut1", "cut2", "cut3", "cut4", "cut5"]
	@State private var frameIndex = 0
	@State var tick: Bool = false
	@State private var animationFinished = false
	@State var passaNoAsset: Bool = false
	@State var passaMural: Bool = false
	@State var clicaBloco: Bool = false
	
		var body: some View {
			ZStack(alignment: .topLeading){
				Image(dialogos[contexto.idDialogo].local_fundo)
						.resizable()
						.scaleEffect((dialogos[contexto.idDialogo].personagem == "Sister Desmond" && !clicaBloco) ? 0.71 : 1.0)
						//.aspectRatio(16 / 10, contentMode: .fit)
						.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
				if(contexto.idDialogo == 111 && !clicaBloco) {
					Button (action: {if (contexto.idDialogo == 111) {
						path.append("mural")}}) {
							Image("muralzinho")
								.resizable()
								.scaledToFit()
								.frame(width: 480, height: 422)
							//.contentShape(Rectangle())
								.onHover {over in
									passaMural = over
								}
						}
						.scaleEffect(passaMural && contexto.idDialogo == 111 ? 1.2 : 1)
						.buttonStyle(.plain)
						.offset(x: 650, y:200)
				}
				if (!clicaBloco) {
					FalaView(path: $path, contexto: contexto, bloco: bloco, falaNome: defineFalaNome())
					
					AtributosView(contexto: contexto)
						.offset(x: (dialogos[contexto.idDialogo].personagem == "Sister Desmond") ? 318: 0, y: (dialogos[contexto.idDialogo].personagem == "Sister Desmond") ? 197 : 0)
					SairBlocoView(contexto: contexto, path: $path, clicaBloco: $clicaBloco)
					.offset(x: (dialogos[contexto.idDialogo].personagem == "Sister Desmond") ? -318: 0, y: (dialogos[contexto.idDialogo].personagem == "Sister Desmond") ? 197 : 0)
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
				if (contexto.idDialogo == 15) {
					//FalaView(contexto: contexto, bloco: bloco, falaNome: defineFalaNome()).cancelarTarefa()
					//withAnimation { fadeOut = true }
					//DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
							contexto.horario = "confissao1"
							contexto.local = "confessionario"
							contexto.parteDialogo = 0
							path.append("confessionario")
					//}
				}
				if (contexto.idDialogo == 1){
					salvarImagemEscolhida("mural1")
				}
//				if (contexto.idDialogo == 0 && terminou) {
//					fadeOut = false
//					DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//						withAnimation { fadeOut = true }
//					}
//
//				}
//				if (contexto.idDialogo == 80) {
//					fadeIn = false
//					DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//						withAnimation { fadeIn = true }
//					}
//				}
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
