import SwiftUI
import SwiftData
struct ConfessionarioView: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@Binding var path: [String]
	@FocusState var estaFocado: FocusKey?
	@State var texto: String = ""
	//@State var idFala: Int = 0
	@State var opcoes: [String] = []
	@State var terminou: Bool = true
	@State private var tarefaOpcoes: Task<Void, Never>? = nil
	@Environment(\.modelContext) private var modelContext
	@Query(sort: \ContextoConfessionario3.ContextoConfessionario.momentoAdicionado, order: .forward) var dialogosConfessionario: [ContextoConfessionario3.ContextoConfessionario]
	@State var passaNoBotao: [Bool] = [false, false, false]
	@State private var scrollProxy: ScrollViewProxy? = nil
	@State private var frameIndex = 0
	@State var isSpeaking: Bool = false
	@State private var tempo: Int = 0
	@Bindable var bloco: ContextoConfessionario3.Bloco
	@Binding var clicaNotas: Bool
	@State private var fadeIn = false
	@State private var fadeOut = false
	
		var body: some View {
			GeometryReader { geo in
					ZStack {
						
						HStack(spacing: 0) {
							SombraView(contexto: contexto, isSpeaking: $isSpeaking)
								.frame(width: geo.size.width * 2/3, height: geo.size.height)
								
								ZStack {
									VStack(spacing: 0) {
										MenuzinhoView(contexto: contexto, path: $path, estaFocado: _estaFocado, clicaBloco: $clicaNotas)
										.padding(.top, 10)
										.frame(maxWidth: .infinity)
										
										ScrollView {
											ScrollViewReader { proxy in
												VStack {
													ForEach (dialogosConfessionario) { dialogoConf in
														// dialogos antigos salvos no array de swiftdata
														if (dialogoConf.personagem + ": " + dialogoConf.dialogo != dialogos[contexto.idDialogo].personagem + ": " + dialogos[contexto.idDialogo].texto[contexto.parteDialogo]) {
															Text(dialogoConf.personagem + ": " + dialogoConf.dialogo)
																.frame(maxWidth: .infinity, alignment: .leading)
																.foregroundColor(.white)
																.font(.appFont(selectedFont, size:30))
																.padding()
														}
													}
													
													Text(dialogos[contexto.idDialogo].personagem + ": " + texto)
													// dialogo atual, que está sendo inserido na variável texto
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
											
										if (contexto.parteDialogo == dialogos[contexto.idDialogo].texto.count - 1 && dialogos[contexto.idDialogo].opcoes.count > 0) {
												// se é a última parte da fala
											// se temos um número de opções maior que zero
												ForEach(opcoes.indices, id: \.self) { index in
													// aqui tenho os botões das opções
													if (opcoes[index] != ""){
														Button {
															carregaFalaToda()
															selecionaOpcao(index: index)
															} label: {
																		Text(opcoes[index])
																	.foregroundColor(passaNoBotao[index] ? .white: .orange)
																		.font(.appFont(selectedFont, size: 25))
																		.scaleEffect(passaNoBotao[index] ? 1.1 : 1.0)
																		.multilineTextAlignment(.center)
																		.lineLimit(nil)
																		.fixedSize(horizontal: false, vertical: true)
																		.padding()
																		.frame(maxWidth: .infinity)
																		.background(Color("FundoOpcoes"))
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
									.background(Color("FundoConfissao"))
									.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
										.focusable()
										.focusEffectDisabled()
										.focused($estaFocado, equals: FocusKey.enter)
										.onKeyPress(.return) {
											withAnimation {
													scrollProxy?.scrollTo("atual", anchor: .bottom)
											}
											if (contexto.parteDialogo < dialogos[contexto.idDialogo].texto.count - 1) {
												salvaBD(personagem: dialogos[contexto.idDialogo].personagem, dialogo: dialogos[contexto.idDialogo].texto[contexto.parteDialogo], momentoAdicionado: tempo)
												contexto.parteDialogo += 1
												//idFala += 1
												reiniciarOpcoes()
												return .handled
											}
											if (terminou == false && !dialogos[contexto.idDialogo].opcoes.isEmpty) {
												if let ultimaOpcao = opcoes.last,
													 let ultimaDialogo = dialogos[contexto.idDialogo].opcoes.last,
													 ultimaOpcao.contains(ultimaDialogo) {
														return .handled
												}
												carregaFalaToda()
												salvaBD(personagem: dialogos[contexto.idDialogo].personagem, dialogo: dialogos[contexto.idDialogo].texto[contexto.parteDialogo], momentoAdicionado: tempo)
												return .handled
											}
											salvaBD(personagem: dialogos[contexto.idDialogo].personagem, dialogo: dialogos[contexto.idDialogo].texto[contexto.parteDialogo], momentoAdicionado: tempo)
											proximaFala()
											return .handled
											
										}
										.onAppear {
											//withAnimation { fadeIn = true }
											estaFocado = FocusKey.enter
											if (contexto.horario == "confissao2" && contexto.idDialogo == 23) {
												for dialogo in dialogosConfessionario {
													modelContext.delete(dialogo)
												}
											}
											texto = ""
											reiniciarOpcoes()
										}
										.onChange(of: texto) { _ in
											withAnimation {
													scrollProxy?.scrollTo("atual", anchor: .bottom)
											}
											if (texto == dialogos[contexto.idDialogo].texto[contexto.parteDialogo]) {
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
						
						if (clicaNotas) {
							BlocoView(path: $path, bloco: bloco, clicaNotas: $clicaNotas)
						}
						
				}
					
			}
			//.opacity(fadeIn ? 1 : 0)
			//.animation(.easeIn(duration: 1), value: fadeIn)
			.opacity(fadeOut ? 0 : 1)
			.animation(.easeOut(duration: 1), value: fadeOut)
			.navigationBarBackButtonHidden()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
	
	func addBlocoDeNotas (resumo: String) {
		if (bloco.textoPorDia.count < contexto.dia) {
			bloco.textoPorDia.append(dialogos[contexto.idDialogo].resumo_notas + "\n" + "\n")
			try? modelContext.save()
			return
		}
		else {
			if !bloco.textoPorDia[contexto.dia-1].contains(resumo) {
					print(bloco.textoPorDia[contexto.dia-1])
					bloco.textoPorDia[contexto.dia-1] += resumo + "\n" + "\n"
				try? modelContext.save()
			}
			return
		}
	}
	
	func selecionaOpcao (index: Int) {
			contexto.desconfianca += dialogos[contexto.idDialogo].impacto_opcao_desc[index]
			contexto.popularidade += dialogos[contexto.idDialogo].impacto_opcao_pop[index]
			let inicio = opcoes[index].index(texto.startIndex, offsetBy: 3)
			/*let opcaoAtual = opcoes[index][inicio...]*/
			salvaBD(personagem: "You", dialogo: String(opcoes[index][inicio...]), momentoAdicionado: tempo)
			proximaFala(index: index)
			terminou = true
			return
	}
	
	func salvaBD (personagem: String, dialogo: String, momentoAdicionado: Int) {
		if (dialogosConfessionario.isEmpty == false) {
			tempo = dialogosConfessionario.last!.momentoAdicionado + 1
		}
		modelContext.insert(ContextoConfessionario3.ContextoConfessionario(personagem: personagem, dialogo: dialogo, momentoAdicionado: tempo))
		try? modelContext.save()
		return
	}
	
	func reiniciarOpcoes() {
		opcoes.removeAll()
		for i in dialogos[contexto.idDialogo].opcoes {
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
			texto += dialogos[contexto.idDialogo].texto[contexto.parteDialogo]
			var cont: Int = 0
			for opc in dialogos[contexto.idDialogo].opcoes {
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
		if (dialogos[contexto.idDialogo].id_que_opcao_leva[index] == -10) {
			contexto.idDialogo = 23
			contexto.local = "cartas"
			contexto.parteDialogo = 0
			withAnimation { fadeOut = true }
			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
					path.append("cartas")
			}
			reiniciarOpcoes()
			return
		}
		if (dialogos[contexto.idDialogo].resumo_notas != "") {
			addBlocoDeNotas(resumo: dialogos[contexto.idDialogo].resumo_notas)
		}
		contexto.idDialogo = dialogos[contexto.idDialogo].id_que_opcao_leva[index]
		try? modelContext.save()
		contexto.parteDialogo = 0
		reiniciarOpcoes()
		return
	}
	
	func animacaoOpcoes() {
		// imprime a fala e as opcoes com animação
		//tarefaAtual?.cancel()
		tarefaOpcoes?.cancel()
		if (dialogos[contexto.idDialogo].personagem == "Shadow"){
			isSpeaking = true
		}
		let opc = dialogos[contexto.idDialogo].opcoes
		let fala = dialogos[contexto.idDialogo].texto[contexto.parteDialogo]
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
				try? await Task.sleep(nanoseconds: 30_000_000)
			}
			try? await Task.sleep(nanoseconds: 30_000_000)
			
			for opcao in opc {
				await MainActor.run {
					opcoes[cont-1].append(String(cont))
				}
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 30_000_000)
				await MainActor.run {
					opcoes[cont-1].append(".")
				}
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 30_000_000)
				await MainActor.run {
					opcoes[cont-1].append(" ")
				}
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 30_000_000)
				for c in opcao {
					if Task.isCancelled {
						return
					}
					await MainActor.run {
						opcoes[cont-1].append(c)
					}
					if Task.isCancelled {
						return
					}
					try? await Task.sleep(nanoseconds: 30_000_000)
				}
				cont += 1
			}
		}
	}
}
#Preview {
		//ConfessionarioView()
}
