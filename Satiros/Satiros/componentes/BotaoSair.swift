
// AtributosView.swift
// Satiros
//
// Created by Jordana Lourenço Santos on 03/09/25.
//
import SwiftUI
struct BotaoSair: View {
	
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	//@Bindable var contexto: ContextoConfessionario2.ContextoSalvo
	@State var passaNoAsset: Bool = false
	@State var mostrarBalao: Bool = false
	@Binding var path: [Caminhos]
	@Binding var clicaBloco: Bool
	@State var passaBloco: Bool = false
	
		var body: some View {
					VStack(alignment: .trailing) {
						HStack(alignment: .top){
							Spacer()
							Button (action: {path.removeAll()}){
								Image("sair")
									.resizable()
									.clipped()
									.frame(width: 50, height: 50)
									.padding(20)
									.scaleEffect(passaNoAsset ? 1.1 : 1.0)
									.onHover {over in
										passaNoAsset = over
									}
							}
							.buttonStyle(.plain)
							Button (action: {clicaBloco = true}) {
								Image("notas")
									.resizable()
									.clipped()
									.frame(width: 50, height: 50)
									.scaleEffect(passaBloco ? 1.1 : 1.0)
									.onHover {over in
										passaBloco = over
										mostrarBalao = over
									}
									.overlay(alignment: .leading) {
										if mostrarBalao {
											ZStack {
												Image("balaoAtributos")
														.resizable()
														.frame(width: 400, height: 100)
												Text("The notebook shows important findings. Check out what you have discovered so far!")
													.font(.appFont(selectedFont, size: 20))
														.foregroundColor(.black)
														.padding()
											}
											.offset(x: -430, y: 20)
											
											.transition(.opacity)
										}
									}
							}
							.buttonStyle(.plain)
							.padding()
							//					.focusable()
							//					.focusEffectDisabled()
							//					.focused($estaFocado, equals: FocusKey.escape)
							//					.onKeyPress(.escape) {
							//						path.removeAll()
							//						return .handled
							//					}
							//					.onChange(of: estaFocado) {
							//						estaFocado = FocusKey.escape
							//					}
						}
					}
					.padding(.top, 20)
		}
}
#Preview {
		//SombraView()
}
