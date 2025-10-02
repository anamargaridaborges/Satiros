//
//  TutorialView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI
import SwiftData
import WidgetKit

struct TutorialView: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@Binding var path: [Caminhos]
	@Bindable var bloco: ContextoConfessionario3.Bloco
	@State var falaNome: Bool = false
	@State private var fadeIn = false
	@State private var fadeOut = false
	let frames = ["cut1", "cut2", "cut3", "cut4", "cut5"]
	@State private var frameIndex = 0
	@State var tick: Bool = false
	@State private var animationFinished = false
	@State var passaNoAsset: Bool = false
	@State var clicaBloco: Bool = false
	@State var passaBloco: Bool = false
	@State var mostrarBalao: Bool = false
	
    var body: some View {
			ZStack(alignment: .topLeading){
				if (dialogos[contexto.idDialogo].local_fundo == "animacaoCutscene"){
					Image(frames[frameIndex])
						.resizable()
						.aspectRatio(16/10, contentMode: .fill)
						.onChange(of: tick) { _, _ in
							if frameIndex < frames.count - 1 {
									frameIndex += 1
									DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
											tick.toggle()
									}
							} else {
								animationFinished = true
							}
						}
						.task { tick.toggle() }

				} else {
					Image(dialogos[contexto.idDialogo].local_fundo)
							.resizable()
							.scaleEffect((dialogos[contexto.idDialogo].personagem == "You") ? 1.42 : 1.0)
							//.aspectRatio(16 / 10, contentMode: .fit)
							.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
				}
//				HStack(alignment: .top){
//						Spacer()
//						Button (action: {path.removeAll()}){
//							Image("sair")
//								.resizable()
//								.clipped()
//								.frame(width: 50, height: 50)
//								.padding(20)
//								.scaleEffect(passaNoAsset ? 1.1 : 1.0)
//								.onHover {over in
//									passaNoAsset = over
//								}
//						}
//						.buttonStyle(.plain)
//						//					.focusable()
//						//					.focusEffectDisabled()
//						//					.focused($estaFocado, equals: FocusKey.escape)
//						//					.onKeyPress(.escape) {
//						//						path.removeAll()
//						//						return .handled
//						//					}
//						//					.onChange(of: estaFocado) {
//						//						estaFocado = FocusKey.escape
//						//					}
//					}
//				.offset(y: (dialogos[contexto.idDialogo].personagem == "Sister Desmond") ? 200: 0)
				
				
				//AtributosView(contexto: contexto)
					//.offset(y: (dialogos[contexto.idDialogo].personagem == "Sister Desmond") ? 200: 0)
				if (clicaBloco == false) {
					FalaView(path: $path, contexto: contexto, bloco: bloco, falaNome: defineFalaNome())
					
					AtributosView(contexto: contexto)
						.offset(x: (dialogos[contexto.idDialogo].personagem == "Sister Desmond") ? 318: 0, y: (dialogos[contexto.idDialogo].personagem == "Sister Desmond") ? 197 : 0)
					BotaoSair(contexto: contexto, path: $path)
						.offset(x: (dialogos[contexto.idDialogo].personagem == "Sister Desmond") ? -318: 0, y: (dialogos[contexto.idDialogo].personagem == "Sister Desmond") ? 197 : 0)
				}
				
				if (clicaBloco) {
					BlocoView(path: $path, bloco: bloco, clicaNotas: $clicaBloco)
						//.padding()
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
							contexto.horario = "confissao1"
					contexto.local = .confessionario
							contexto.parteDialogo = 0
					path.append(.confessionario)
				}
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
		if (dialogos[contexto.idDialogo].personagem == "Sister Desmond" || dialogos[contexto.idDialogo].personagem == "You") {
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
