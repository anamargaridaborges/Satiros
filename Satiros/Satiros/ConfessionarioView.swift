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
	
    var body: some View {
			GeometryReader { geo in
					ZStack {
						
						HStack(spacing: 0) {
							ZStack(alignment: .topLeading) {
									Image("grade confessionario")
											.resizable()
											.clipped()
											//.aspectRatio(1/1, contentMode: .fit)
									
									VStack(alignment: .leading, spacing: 10) {
											Image("popularidade")
													.resizable()
													.clipped()
													.frame(width: 50, height: 40)
													//.aspectRatio(16/10, contentMode: .fit)
											
											Image("desconfianca")
													.resizable()
													.clipped()
													.frame(width: 50, height: 40)
													.padding(.horizontal, 20)
													.aspectRatio(16/8, contentMode: .fit)
									}
									//.padding(.top, 10)
							}
								.frame(width: geo.size.width * 2/3, height: geo.size.height)
								
								ZStack {
										Image("aaa")
												.resizable()
												.clipped()
												.aspectRatio(3/5.75, contentMode: .fit)
										
									VStack(spacing: 0) {
										
										HStack(spacing: 150){
											Image("menu")
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
											
											Image("configuracoes")
												.resizable()
												.clipped()
												.frame(width: 35, height: 35)
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
															let inicio = opcoes[index].index(texto.startIndex, offsetBy: 3)
															/*let opcaoAtual = opcoes[index][inicio...]*/
															dialogosConfessionario.append(ContextoConfessionario(personagem: "You", dialogo: String(opcoes[index][inicio...]))); proximaFala(index: index)
															reiniciarOpcoes()
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
														}
														.buttonStyle(PlainButtonStyle())
														//.background(passaNoBotao[index] ? Color("Selecionado") : Color("Fundo"))
														//.cornerRadius(10)
														.onHover { over in
															passaNoBotao[index] = over
														}
													}
												}
												.padding(5)
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
											reiniciarOpcoes()
											return .handled
											
										}
										.onAppear {
											estaFocado = true
											reiniciarOpcoes()
										}
										.onChange(of: texto) { _ in
											withAnimation {
													scrollProxy?.scrollTo("atual", anchor: .bottom)
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
		contexto.idDialogo = dialogos[contexto.idDialogo ?? 0].id_que_opcao_leva[index]
		idFala = 0
		return
	}
	
	func animacaoOpcoes() {
		// imprime a fala e as opcoes com animação
		//tarefaAtual?.cancel()
		tarefaOpcoes?.cancel()
		let opc = dialogos[contexto.idDialogo ?? 0].opcoes
		let fala = dialogos[contexto.idDialogo ?? 0].texto[idFala]
		var cont: Int = 1
		tarefaOpcoes = Task {
			terminou = false
			try? await Task.yield()
			texto = ""
			for c in fala {
				texto.append(c)
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 50_000_000)
			}
			try? await Task.sleep(nanoseconds: 50_000_000)
			for opcao in opc {
				opcoes[cont-1].append(String(cont))
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 50_000_000)
				opcoes[cont-1].append(".")
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 50_000_000)
				opcoes[cont-1].append(" ")
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 50_000_000)
				for c in opcao {
					opcoes[cont-1].append(c)
					if Task.isCancelled {
						return
					}
					try? await Task.sleep(nanoseconds: 50_000_000)
				}
				cont += 1
			}
		}
	}

	
}

#Preview {
    //ConfessionarioView()
}
