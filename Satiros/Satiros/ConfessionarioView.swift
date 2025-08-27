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
	@Environment(\.modelContext) private var modelContext
	@Query var dialogosConfessionario: [ContextoConfessionario]
	
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
										
									VStack(spacing: 10) {
										
										HStack(spacing: 150){
											Image("menu")
												.resizable()
												.clipped()
												.frame(width: 40, height: 40)
											
											VStack() {
												Text("Day \(contexto.dia)")
													.font(.appFont(selectedFont, size: 30))
												Text("Morning")
													.font(.appFont(selectedFont, size: 30))
											}
											
											Image("configuracoes")
												.resizable()
												.clipped()
												.frame(width: 35, height: 35)
										}
										.padding(.top, 10)
										Spacer()
										ScrollView {
											ForEach (dialogosConfessionario, id: \.self) { dialogoConf in
												Text(dialogoConf.personagem + ": " + dialogoConf.dialogo)
											}
											Text(dialogos[contexto.idDialogo ?? 0].personagem + ": " + texto)
												.font(.appFont(selectedFont, size:30))
												.padding()
											if (idFala == dialogos[contexto.idDialogo ?? 0].texto.count - 1 && dialogos[contexto.idDialogo ?? 0].opcoes.count > 0) {
												// se é a última parte da fala
												ForEach(opcoes.indices, id: \.self) { index in
													if (opcoes[index] != ""){
														Button (action: {proximaFala(index: index); reiniciarOpcoes();
															terminou = true}) {
																Text(opcoes[index])
																	.font(.appFont(selectedFont, size:30))
															}
													}
												}
											}
										}
										.focusable()
										.focusEffectDisabled()
										.focused($estaFocado)
										.onKeyPress(.return) {
											if (idFala < dialogos[contexto.idDialogo ?? 0].texto.count - 1) {
												idFala += 1
												reiniciarOpcoes()
												return .handled
											}
											if (terminou == false && !dialogos[contexto.idDialogo ?? 0].opcoes.isEmpty) {
												carregaFalaToda()
												return .handled
											}
											proximaFala()
											reiniciarOpcoes()
											return .handled
											
										}
										.onAppear {
											estaFocado = true
											reiniciarOpcoes()
										}
										Spacer()
												/*Spacer()
												

												Text("Long paragraph of text that will wrap correctly above the image background...")
														.font(.appFont(selectedFont, size: 25))
														.multilineTextAlignment(.leading)
														.lineLimit(nil)
														.fixedSize(horizontal: false, vertical: true)
														.padding(.horizontal, 15)
												Spacer()
												Text("Another line of text here...")
														.font(.appFont(selectedFont, size: 25))
														.multilineTextAlignment(.leading)
														.lineLimit(nil)
														.fixedSize(horizontal: false, vertical: true)
														.padding(.horizontal, 15)
												Spacer()*/
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
		modelContext.insert(ContextoConfessionario(personagem: dialogos[contexto.idDialogo ?? 0].personagem, dialogo: dialogos[contexto.idDialogo ?? 0].texto.joined()))
		try? modelContext.save()
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
