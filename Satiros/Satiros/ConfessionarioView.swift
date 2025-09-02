import SwiftUI
import SwiftData
struct ConfessionarioView: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario2.ContextoSalvo
	@Binding var path: [String]
	@FocusState private var estaFocado: Bool
	@State var texto: String = ""
	//@State var idFala: Int = 0
	@State var opcoes: [String] = []
	@State var terminou: Bool = true
	@State private var tarefaOpcoes: Task<Void, Never>? = nil
	@Environment(\.modelContext) private var modelContext
	@Query(sort: \ContextoConfessionario2.ContextoConfessionario.momentoAdicionado, order: .forward) var dialogosConfessionario: [ContextoConfessionario2.ContextoConfessionario]
	@State var passaNoBotao: [Bool] = [false, false, false]
	@State var checaImprimiu: Bool = false
	@State private var scrollProxy: ScrollViewProxy? = nil
	@State private var tempo: Int = 0
	
		var body: some View {
			GeometryReader { geo in
					ZStack {
						
						HStack(spacing: 0) {
							SombraView(contexto: contexto)
								.frame(width: geo.size.width * 2/3, height: geo.size.height)
								
								ZStack {
										Image("aaa")
												.resizable()
												.clipped()
												.aspectRatio(3/5.75, contentMode: .fit)
										
									VStack(spacing: 0) {
										
										MenuzinhoView(contexto: contexto, path: $path)
											.padding(.top, 10)
											.frame(maxWidth: .infinity)
										
										ScrollView {
											ScrollViewReader { proxy in
												VStack {
													ForEach (dialogosConfessionario) { dialogoConf in
														if (dialogoConf.personagem + ": " + dialogoConf.dialogo != dialogos[contexto.idDialogo].personagem + ": " + dialogos[contexto.idDialogo].texto[contexto.parteDialogo]) {
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
											
										if (contexto.parteDialogo == dialogos[contexto.idDialogo ?? 0].texto.count - 1 && dialogos[contexto.idDialogo ?? 0].opcoes.count > 0) {
												// se é a última parte da fala
												ForEach(opcoes.indices, id: \.self) { index in
													if (opcoes[index] != ""){
														Button {
															selecionaOpcao(index: index)
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
											if (contexto.parteDialogo < dialogos[contexto.idDialogo].texto.count - 1) {
												salvaBD(personagem: dialogos[contexto.idDialogo].personagem, dialogo: dialogos[contexto.idDialogo].texto[contexto.parteDialogo], momentoAdicionado: tempo)
												contexto.parteDialogo += 1
												//idFala += 1
												reiniciarOpcoes()
												return .handled
											}
											if (terminou == false && !dialogos[contexto.idDialogo].opcoes.isEmpty) {
												carregaFalaToda()
												salvaBD(personagem: dialogos[contexto.idDialogo].personagem, dialogo: dialogos[contexto.idDialogo].texto[contexto.parteDialogo], momentoAdicionado: tempo)
												return .handled
											}
											salvaBD(personagem: dialogos[contexto.idDialogo].personagem, dialogo: dialogos[contexto.idDialogo].texto[contexto.parteDialogo], momentoAdicionado: tempo)
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
	
	func selecionaOpcao (index: Int) {
			contexto.desconfianca += dialogos[contexto.idDialogo].impacto_opcao_desc[index]
			contexto.popularidade += dialogos[contexto.idDialogo].impacto_opcao_pop[index]
			let inicio = opcoes[index].index(texto.startIndex, offsetBy: 3)
			/*let opcaoAtual = opcoes[index][inicio...]*/
			salvaBD(personagem: "You", dialogo: String(opcoes[index][inicio...]), momentoAdicionado: tempo)
			proximaFala(index: index)
			terminou = true
			checaImprimiu = false
			return
	}
	
	func salvaBD (personagem: String, dialogo: String, momentoAdicionado: Int) {
		if (dialogosConfessionario.isEmpty == false) {
			tempo = dialogosConfessionario.last!.momentoAdicionado + 1
		}
		modelContext.insert(ContextoConfessionario2.ContextoConfessionario(personagem: personagem, dialogo: dialogo, momentoAdicionado: tempo))
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
			for dialogo in dialogosConfessionario {
				modelContext.delete(dialogo)
			}
			contexto.local = "cartas"
			contexto.parteDialogo = 0
			path.append("cartas")
			reiniciarOpcoes()
			return
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
		let opc = dialogos[contexto.idDialogo].opcoes
		let fala = dialogos[contexto.idDialogo].texto[contexto.parteDialogo]
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
