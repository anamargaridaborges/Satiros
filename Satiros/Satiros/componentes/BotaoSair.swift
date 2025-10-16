
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
	
		var body: some View {
					VStack(alignment: .trailing) {
						HStack(alignment: .top){
							Spacer()
							Button (action: {path.removeAll()}){
								Image("sair")
									.resizable()
									.clipped()
									.frame(width: 50, height: 50)
									.padding(15)
									.scaleEffect(passaNoAsset ? 1.1 : 1.0)
									.onHover {over in
										passaNoAsset = over
									}
							}
							.buttonStyle(.plain)
							
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
		}
}
#Preview {
		//SombraView()
}
