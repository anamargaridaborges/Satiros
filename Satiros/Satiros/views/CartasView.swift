//
//  CartasView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 28/08/25.
//

import SwiftUI
import SwiftData

struct CartasView: View {
	
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@Binding var path: [Caminhos]
	@State var passaNaCarta: [Bool] = [false, false, false, false, false]
	@State var passaNoAsset: [Bool] = [false, false] //[popularidade, desconfianca]
	@State var mostrarBalao:  [Bool] = [false, false]
	@Query(sort: \ContextoConfessionario3.ContextoConfessionario.momentoAdicionado, order: .forward) var dialogosConfessionario: [ContextoConfessionario3.ContextoConfessionario]
	@State private var scrollProxy: ScrollViewProxy? = nil
	@State var texto: String = ""
	@FocusState private var estaFocado: Bool
	let instrucao: String = "Now you must apply penance, the cards laid in front of you are mysteriously selected and shall indicate proper action in the confessions for the day. But be careful, once you give a card away, you cannot use again until the morrow. Use them wisely, or they might begin to question your judgment."
	@State private var tarefa: Task<Void, Never>? = nil
	@Binding var clicaBloco: Bool
	@Bindable var bloco: ContextoConfessionario3.Bloco
	@State private var fadeIn = false
	@State private var fadeOut = false
	
    var body: some View {
			ZStack {
				GeometryReader { geo in
						HStack(spacing: 0) {
							ZStack(alignment: .topLeading) {
									Image("fundoCartas")
											.resizable()
											.clipped()
									
								VStack(alignment: .leading) {
									AtributosView(contexto: contexto)
										
									VStack (alignment: .center){
										HStack {
											if (contexto.cartaUsada != 1) {
												Button (action: {contexto.cartaUsada = 1; if (contexto.horario == "confissao1") {
														impactoPopDesc(pop: 0, desc: -1)
														contexto.horario = "confissao2"
														withAnimation { fadeOut = true }
														DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
															path.append(.confessionario)
														}
													}
														else {
															impactoPopDesc(pop: 1, desc: 0)
															contexto.local = "popUpMapa"
															withAnimation { fadeOut = true }
															DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
																path.append(.popUpMapa)
															}
														}}) {
												ZStack {
													Image("moses")
														.resizable()
														.clipped()
													//.aspectRatio(2/1, contentMode: .fit)
														.frame(width: 160, height: 226)
														.scaleEffect(passaNaCarta[0] ? 1.1 : 1.0)
														.padding()
														.onHover { over in
															passaNaCarta[0] = over
														}
													if (passaNaCarta[0]) {
														Image("seta")
															.resizable()
															.clipped()
															.frame(width: 40, height: 40)
															.padding(.top, -180)
													}
												}
											}
												.buttonStyle(.plain)
										}
											if (contexto.cartaUsada != 2) {
												Button (action: {contexto.cartaUsada = 2; if (contexto.horario == "confissao1") {
													impactoPopDesc(pop: -1, desc: 1)
													contexto.horario = "confissao2"
													withAnimation { fadeOut = true }
													DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
														path.append(.confessionario)
													}
												}
													else {
														impactoPopDesc(pop: 1, desc: -1)
														contexto.local = "popUpMapa"
														withAnimation { fadeOut = true }
														DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
															path.append(.popUpMapa)
														}
													}
												}) {
													ZStack {
														Image("solomon")
															.resizable()
															.clipped()
														//.aspectRatio(2/1, contentMode: .fit)
															.frame(width: 160, height: 226)
															.scaleEffect(passaNaCarta[1] ? 1.1 : 1.0)
															.padding()
															.onHover { over in
																passaNaCarta[1] = over
															}
														if (passaNaCarta[1]) {
															Image("seta")
																.resizable()
																.clipped()
																.frame(width: 40, height: 40)
																.padding(.top, -180)
														}
													}
												}
												.buttonStyle(.plain)
											}
											if (contexto.cartaUsada != 3 && (contexto.cartaUsada != 4 && contexto.cartaUsada != 5)) {
												Button (action: {contexto.cartaUsada = 3; if (contexto.horario == "confissao1") {
													impactoPopDesc(pop: 1, desc: 0)
													contexto.horario = "confissao2"
													withAnimation { fadeOut = true }
													DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
														path.append(.confessionario)
													}
												}
													else {
														impactoPopDesc(pop: 0, desc: -1)
														contexto.local = "popUpMapa"
														withAnimation { fadeOut = true }
														DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
															path.append(.popUpMapa)
														}
													}}) {
														ZStack {
															Image("david")
																.resizable()
																.clipped()
															//.aspectRatio(2/1, contentMode: .fit)
																.frame(width: 160, height: 226)
																.scaleEffect(passaNaCarta[2] ? 1.1 : 1.0)
																.padding()
																.onHover { over in
																	passaNaCarta[2] = over
																}
															if (passaNaCarta[2]) {
																Image("seta")
																	.resizable()
																	.clipped()
																	.frame(width: 40, height: 40)
																	.padding(.top, -180)
															}
														}
													}
													.buttonStyle(.plain)
											}
										}
											.padding(40)
											HStack {
												if (contexto.cartaUsada != 4) {
													Button (action: {contexto.cartaUsada = 4; if (contexto.horario == "confissao1") {
														contexto.horario = "confissao2"
														withAnimation { fadeOut = true }
														DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
															path.append(.confessionario)
														}
													}
														else {
															contexto.local = "popUpMapa"
															withAnimation { fadeOut = true }
															DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
																path.append(.popUpMapa)
															}
														}}) {
															ZStack {
																Image("joseph")
																	.resizable()
																	.clipped()
																//.aspectRatio(2/1, contentMode: .fit)
																	.frame(width: 160, height: 226)
																	.scaleEffect(passaNaCarta[3] ? 1.1 : 1.0)
																	.padding()
																	.onHover { over in
																		passaNaCarta[3] = over
																	}
																if (passaNaCarta[3]) {
																	Image("seta")
																		.resizable()
																		.clipped()
																		.frame(width: 40, height: 40)
																		.padding(.top, -180)
																}
															}
														}
														.buttonStyle(.plain)
												}
												else {
													Button (action: {contexto.cartaUsada = 3; if (contexto.horario == "confissao1") {
														impactoPopDesc(pop: 1, desc: 0)
														contexto.horario = "confissao2"
														withAnimation { fadeOut = true }
														DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
															path.append(.confessionario)
														}
													}
														else {
															contexto.local = "popUpMapa"
															impactoPopDesc(pop: 0, desc: -1)
															withAnimation { fadeOut = true }
															DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
																path.append(.popUpMapa)
															}
														}}) {
															ZStack {
																Image("david")
																	.resizable()
																	.clipped()
																//.aspectRatio(2/1, contentMode: .fit)
																	.frame(width: 160, height: 226)
																	.scaleEffect(passaNaCarta[2] ? 1.1 : 1.0)
																	.padding()
																	.onHover { over in
																		passaNaCarta[2] = over
																	}
																if (passaNaCarta[2]) {
																	Image("seta")
																		.resizable()
																		.clipped()
																		.frame(width: 40, height: 40)
																		.padding(.top, -180)
																}
															}
														}
														.buttonStyle(.plain)
												}
												if (contexto.cartaUsada != 5) {
													Button (action: {contexto.cartaUsada = 5; if (contexto.horario == "confissao1") {
														impactoPopDesc(pop: 1, desc: -1)
														contexto.horario = "confissao2"
														withAnimation { fadeOut = true }
														DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
															path.append(.confessionario)
														}
													}
														else {
															impactoPopDesc(pop: -1, desc: 1)
															contexto.local = "popUpMapa"
															withAnimation { fadeOut = true }
															DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
																path.append(.popUpMapa)
															}
														}}) {
															ZStack {
																Image("noah")
																	.resizable()
																	.clipped()
																//.aspectRatio(2/1, contentMode: .fit)
																	.frame(width: 160, height: 226)
																	.scaleEffect(passaNaCarta[4] ? 1.1 : 1.0)
																	.padding()
																	.onHover { over in
																		passaNaCarta[4] = over
																	}
																if (passaNaCarta[4]) {
																	Image("seta")
																		.resizable()
																		.clipped()
																		.frame(width: 40, height: 40)
																		.padding(.top, -180)
																}
															}
														}
														.buttonStyle(.plain)
												}
												else {
													Button (action: {contexto.cartaUsada = 3; if (contexto.horario == "confissao1") {
														impactoPopDesc(pop: 1, desc: 0)
														contexto.horario = "confissao2"
														withAnimation { fadeOut = true }
														DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
															path.append(.confessionario)
														}
													}
														else {
															impactoPopDesc(pop: 0, desc: -1)
															contexto.local = "popUpMapa"
															withAnimation { fadeOut = true }
															DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
																path.append(.popUpMapa)
															}
														}}) {
															ZStack {
																Image("david")
																	.resizable()
																	.clipped()
																//.aspectRatio(2/1, contentMode: .fit)
																	.frame(width: 160, height: 226)
																	.scaleEffect(passaNaCarta[2] ? 1.1 : 1.0)
																	.padding()
																	.onHover { over in
																		passaNaCarta[2] = over
																	}
																if (passaNaCarta[2]) {
																	Image("seta")
																		.resizable()
																		.clipped()
																		.frame(width: 40, height: 40)
																		.padding(.top, -180)
																}
															}
														}
														.buttonStyle(.plain)
												}
											}
										}
									.position(x: geo.size.width * 1/3 , y: geo.size.height * 1/3)
									}
									.padding(.top, 10)
								
							}
							.frame(width: geo.size.width * 2/3, height: geo.size.height)
								
								ZStack {
									VStack(spacing: 0) {
										
										MenuzinhoView(contexto: contexto, path: $path, clicaBloco: $clicaBloco)
										.padding(.top, 10)
										.frame(maxWidth: .infinity)
										
										
										ScrollView {
											ScrollViewReader { proxy in
												VStack {
													ForEach (dialogosConfessionario) { dialogoConf in
														Text(dialogoConf.personagem + ": " + dialogoConf.dialogo)
															.frame(maxWidth: .infinity, alignment: .leading)
															.foregroundColor(.white)
															.font(.appFont(selectedFont, size:30))
															.padding()
													}
													
													Text(texto)
														.frame(maxWidth: .infinity, alignment: .leading)
														.foregroundColor(.orange)
														.font(.appFont(selectedFont, size:30))
														.padding()
														.id("instrucao")
													
													Spacer()
													if (passaNaCarta[0] || passaNaCarta[1] || passaNaCarta[2] || passaNaCarta[3] || passaNaCarta[4] ) {
														ZStack (alignment: .bottom){
															Image("detalheCarta")
																.resizable()
																.clipped()
																.frame(width: 505, height: 161)
															VStack () {
																if (passaNaCarta[0]) {
																	Spacer()
																	Text("Moses")
																		.foregroundColor(.white)
																		.font(.appFont(selectedFont, size: 50))
																	Text("Control, Faith, Honor")
																		.foregroundColor(.white)
																		.font(.appFont(selectedFont, size: 30))
																}
																if (passaNaCarta[1]) {
																	Spacer()
																	Text("Solomon")
																		.foregroundColor(.white)
																		.font(.appFont(selectedFont, size: 50))
																	Text("Control, Honor, Providence")
																		.foregroundColor(.white)
																		.font(.appFont(selectedFont, size: 30))
																}
																if (passaNaCarta[2]) {
																	Spacer()
																	Text("David")
																		.foregroundColor(.white)
																		.font(.appFont(selectedFont, size: 50))
																	Text("Perseverance, Faith, Providence")
																		.foregroundColor(.white)
																		.font(.appFont(selectedFont, size: 30))
																}
																if (passaNaCarta[3]) {
																	Spacer()
																	Text("Joseph")
																		.foregroundColor(.white)
																		.font(.appFont(selectedFont, size: 50))
																	Text("Loss, Perseverance, Providence")
																		.foregroundColor(.white)
																		.font(.appFont(selectedFont, size: 30))
																}
																if (passaNaCarta[4]) {
																	Spacer()
																	Text("Noah")
																		.foregroundColor(.white)
																		.font(.appFont(selectedFont, size: 50))
																	Text("Perseverance, Faith, Renunciation")
																		.foregroundColor(.white)
																		.font(.appFont(selectedFont, size: 30))
																}
															}
															.padding(.bottom, 25)
														}
													}
														
												}
												.id("atual")
												.onAppear {
													withAnimation { fadeIn = true }
													scrollProxy = proxy
												}
											}
										}
										}
									.background(Color("Fundo"))
									.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
									.focusable()
									.focusEffectDisabled()
									.focused($estaFocado)
									.onKeyPress(.return) {
										withAnimation {
												scrollProxy?.scrollTo("atual", anchor: .bottom)
										}
										carregaFalaToda()
										return .handled
									}
									.onAppear {
										estaFocado = true
										texto = ""
										animacaoTexto()
									}
									.onChange(of: texto) { _ in
										withAnimation {
												scrollProxy?.scrollTo("atual", anchor: .bottom)
										}
									}
									.onChange(of: (passaNaCarta[0] || passaNaCarta[1] || passaNaCarta[2] || passaNaCarta[3] || passaNaCarta[4])) { _ in
										withAnimation {
												scrollProxy?.scrollTo("atual", anchor: .bottom)
										}
									}
										//.scaleEffect(0.2)
								}
								.frame(width: geo.size.width / 3, height: geo.size.height)
						}
						.ignoresSafeArea()
				}
				if (clicaBloco) {
					BlocoView(path: $path, bloco: bloco, clicaNotas: $clicaBloco)
				}
			}
			.opacity(fadeIn ? 1 : 0)
			.animation(.easeIn(duration: 1), value: fadeIn)
			.opacity(fadeOut ? 0 : 1)
			.animation(.easeOut(duration: 2), value: fadeOut)
			.navigationBarBackButtonHidden()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
	
	func animacaoTexto() {
		tarefa?.cancel()
		tarefa = Task.detached {
			try? await Task.yield()
			await MainActor.run {
				texto = ""
			}
			for c in instrucao {
				await MainActor.run {
					texto.append(c)
				}
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 30_000_000)
			}
			try? await Task.sleep(nanoseconds: 30_000_000)
		}
	}
	
	func impactoPopDesc (pop: Int, desc: Int) {
			if (pop > 0) {
				if (contexto.popularidade + pop <= 10) {
					contexto.popularidade += pop
				}
			}
			else {
				if (contexto.popularidade + pop >= 0) {
					contexto.popularidade += pop
				}
			}
			if (desc > 0) {
				if (contexto.desconfianca + desc <= 10) {
					contexto.desconfianca += desc
				}
			}
			else {
				if (contexto.desconfianca + desc >= 0) {
					contexto.desconfianca += desc
				}
			}
			return
		}
	
	func carregaFalaToda() {
		tarefa?.cancel()
		Task {
			try? await Task.yield()
			texto = ""
			texto += instrucao
		}
		return
	}
	
}

#Preview {
    //CartasView()
}
