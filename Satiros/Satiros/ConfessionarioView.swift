//
//  ConfessionarioView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 19/08/25.
//

import SwiftUI
import SwiftData

struct ConfessionarioView: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoSalvo
	@Binding var path: [String]
	@FocusState private var estaFocado: Bool
	@State var texto: String = ""
	@State var idFala: Int = 0
	@State var opcoes: [String] = []
	@State var terminou: Bool = true
	@State private var tarefaOpcoes: Task<Void, Never>? = nil
	@Environment(\.modelContext) private var modelContext1
	@State var dialogosConfessionario: [ContextoConfessionario] = []
	@State var passaNoBotao: [Bool] = [false, false, false]
	@State var checaImprimiu: Bool = false
	@State private var scrollProxy: ScrollViewProxy? = nil
	@State private var frameIndex = 0
	@State var isSpeaking: Bool = false
	
		var body: some View {
			GeometryReader { geo in
					ZStack {
						
						HStack(spacing: 0) {
							ZStack(alignment: .topLeading) {
								AnimatedImageBackground(isSpeaking: $isSpeaking)
								
									VStack(alignment: .leading) {
										HStack {
											let pop = "popularidade" + String(contexto.popularidade)
											Image(pop)
												.resizable()
												.clipped()
												.aspectRatio(2/1, contentMode: .fit)
												.frame(width: 80, height: 40)
												.padding(.leading, 10)
											//.aspectRatio(16/10, contentMode: .fit)
											Text(String(contexto.popularidade))
												.font(.appFont(selectedFont, size: 25))
												.foregroundStyle(.white)
												.padding(.top, 20)
										}
											
										HStack {
											let des = "desconfianca" + String(contexto.desconfianca)
											Image(des)
												.resizable()
												.clipped()
												.aspectRatio(2/1, contentMode: .fit)
												.frame(width: 80, height: 40)
												.padding(.leading, 30)
											Text(String(contexto.desconfianca))
												.font(.appFont(selectedFont, size: 25))
												.foregroundStyle(.white)
												.padding(.top, 15)
										}
									}
									.padding(.top, 40)
							}
								.frame(width: geo.size.width * 2/3, height: geo.size.height)
								
								ZStack {
										
									VStack(spacing: 0) {
										
										HStack(spacing: 150){
											Image("notas")
												.resizable()
												.clipped()
												.frame(width: 40, height: 40)
											
											VStack() {
												Text("Day \(contexto.dia)")
													.foregroundColor(.white)
													.font(.appFont(selectedFont, size: 30))
												Text("Morning")
													.foregroundColor(.white)
													.font(.appFont(selectedFont, size: 30))
											}
											Button (action: {path.removeAll()}){
												Image("sair")
													.resizable()
													.clipped()
													.frame(width: 35, height: 35)
											}
											.buttonStyle(.plain)
										}
										.padding(.top, 10)
										.frame(maxWidth: .infinity)
										
										ScrollView {
											ScrollViewReader { proxy in
												VStack {
													ForEach (dialogosConfessionario) { dialogoConf in
														if (dialogoConf.personagem + ": " + dialogoConf.dialogo != dialogos[contexto.idDialogo ?? 0].personagem + ": " + dialogos[contexto.idDialogo ?? 0].texto[idFala]) {
															Text(dialogoConf.personagem + ": " + dialogoConf.dialogo)
																.frame(maxWidth: .infinity, alignment: .leading)
																.foregroundColor(.white)
																.font(.appFont(selectedFont, size:30))
																.padding()
														}
													}
													
													Text(dialogos[contexto.idDialogo ?? 0].personagem + ": " + texto)
														.frame(maxWidth: .infinity, alignment: .leading)
														.foregroundColor(.white)
														.font(.appFont(selectedFont, size:30))
														.padding()
														//.id("atual")
														
												}
												.id("atual")
												.onAppear {
													scrollProxy = proxy
												}
											}
										}
										.padding()
										.frame(maxWidth: .infinity)
											
											if (idFala == dialogos[contexto.idDialogo ?? 0].texto.count - 1 && dialogos[contexto.idDialogo ?? 0].opcoes.count > 0) {
												// se é a última parte da fala
												ForEach(opcoes.indices, id: \.self) { index in
													if (opcoes[index] != ""){
														Button {
															contexto.desconfianca += dialogos[contexto.idDialogo ?? 0].impacto_opcao_desc[index]
															contexto.popularidade += dialogos[contexto.idDialogo ?? 0].impacto_opcao_pop[index]
															let inicio = opcoes[index].index(texto.startIndex, offsetBy: 3)
															/*let opcaoAtual = opcoes[index][inicio...]*/
															dialogosConfessionario.append(ContextoConfessionario(personagem: "You", dialogo: String(opcoes[index][inicio...]))); proximaFala(index: index)
															terminou = true
															checaImprimiu = false
															} label: {
																		Text(opcoes[index])
																		.foregroundColor(.white)
																		.font(.appFont(selectedFont, size: 25))
																		.scaleEffect(passaNoBotao[index] ? 1.1 : 1.0)
																		.multilineTextAlignment(.center)
																		.lineLimit(nil)
																		.fixedSize(horizontal: false, vertical: true)
																		.padding()
																		.frame(maxWidth: .infinity)
																		.background(Color.black)
														}
														.buttonStyle(PlainButtonStyle())
														//.background(passaNoBotao[index] ? Color("Selecionado") : Color("Fundo"))
														//.cornerRadius(10)
														.onHover { over in
															passaNoBotao[index] = over
														}
													}
												}
												
												//.padding(5)
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
											if (idFala < dialogos[contexto.idDialogo ?? 0].texto.count - 1) {
												dialogosConfessionario.append(ContextoConfessionario(personagem: dialogos[contexto.idDialogo ?? 0].personagem, dialogo: dialogos[contexto.idDialogo ?? 0].texto[idFala]))
												idFala += 1
												reiniciarOpcoes()
												return .handled
											}
											if (terminou == false && !dialogos[contexto.idDialogo ?? 0].opcoes.isEmpty) {
												carregaFalaToda()
												dialogosConfessionario.append(ContextoConfessionario(personagem: dialogos[contexto.idDialogo ?? 0].personagem, dialogo: dialogos[contexto.idDialogo ?? 0].texto[idFala]))
												
												return .handled
											}
											dialogosConfessionario.append(ContextoConfessionario(personagem: dialogos[contexto.idDialogo ?? 0].personagem, dialogo: dialogos[contexto.idDialogo ?? 0].texto[idFala]))
											proximaFala()
											return .handled
											
										}
										.onAppear {
											estaFocado = true
											texto = ""
											reiniciarOpcoes()
										}
										.onChange(of: texto) { _ in
											withAnimation {
													scrollProxy?.scrollTo("atual", anchor: .bottom)
											}
											if (texto == dialogos[contexto.idDialogo ?? 0].texto[idFala]) {
												isSpeaking = false
											}
										}
										.onChange(of: opcoes.joined()) { _ in
											withAnimation {
													scrollProxy?.scrollTo("atual", anchor: .bottom)
											}
										}
								}
								.frame(width: geo.size.width / 3, height: geo.size.height)
						}
						.ignoresSafeArea()
				}
					
			}
			.navigationBarBackButtonHidden()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		} //fim body
	
	func reiniciarOpcoes() {
		opcoes.removeAll()
		for i in dialogos[contexto.idDialogo ?? 0].opcoes {
			opcoes.append("")
		}
		animacaoOpcoes()
		return
	}
	
	func carregaFalaToda() {
		tarefaOpcoes?.cancel()
		Task {
			try? await Task.yield()
			texto = ""
			texto += dialogos[contexto.idDialogo ?? 0].texto[idFala]
			var cont: Int = 0
			for opc in dialogos[contexto.idDialogo ?? 0].opcoes {
				opcoes[cont] = ""
				opcoes[cont] += String(cont+1)
				opcoes[cont] += ". "
				opcoes[cont] += opc
				cont += 1
			}
		}
		return
	}
	
	func proximaFala(index: Int = 0) {
		if (dialogos[contexto.idDialogo ?? 0].id_que_opcao_leva[index] == -10) {
			contexto.idDialogo = 23
			dialogosConfessionario.removeAll()
			idFala = 0
			path.append("cartas")
			reiniciarOpcoes()
			return
		}
		contexto.idDialogo = dialogos[contexto.idDialogo ?? 0].id_que_opcao_leva[index]
		idFala = 0
		reiniciarOpcoes()
		return
	}
	
	func animacaoOpcoes() {
		// imprime a fala e as opcoes com animação
		//tarefaAtual?.cancel()
		tarefaOpcoes?.cancel()
		if (dialogos[contexto.idDialogo ?? 0].personagem == "Shadow"){
			isSpeaking = true
		}
		let opc = dialogos[contexto.idDialogo ?? 0].opcoes
		let fala = dialogos[contexto.idDialogo ?? 0].texto[idFala]
		var cont: Int = 1
		tarefaOpcoes = Task.detached {
			await MainActor.run {
				terminou = false
			}
			try? await Task.yield()
			await MainActor.run {
				texto = ""
			}
			for c in fala {
				await MainActor.run {
					texto.append(c)
				}
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 50_000_000)
			}
			try? await Task.sleep(nanoseconds: 50_000_000)
			
			for opcao in opc {
				await MainActor.run {
					opcoes[cont-1].append(String(cont))
				}
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 50_000_000)
				await MainActor.run {
					opcoes[cont-1].append(".")
				}
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 50_000_000)
				await MainActor.run {
					opcoes[cont-1].append(" ")
				}
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 50_000_000)
				for c in opcao {
					await MainActor.run {
						opcoes[cont-1].append(c)
					}
					if Task.isCancelled {
						return
					}
					try? await Task.sleep(nanoseconds: 50_000_000)
				}
				cont += 1
			}
		}
	}
	
	struct AnimatedImageBackground: View {
		@State private var frameIndex = 0
		
		let frames = ["fala1", "fala2", "fala3", "fala4", "fala5", "fala6"]
		//let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
		//var timer:Timer = Timer()
		@State var tick: Bool = false
		@Binding var isSpeaking: Bool
		
		var body: some View {
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
//				.onReceive(tick) { _ in
//					print("Recebi")
//						frameIndex = (frameIndex + 1) % frames.count
//				}
		}
	}

	
	
}

#Preview {
		//ConfessionarioView()
}
