import SwiftUI
import WidgetKit

struct BotaoNotas: View {
	
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@Binding var path: [Caminhos]
	@State var passaNoAsset: Bool = false
	@State var mostrarBalao:  Bool = false
	@Binding var clicaBloco: Bool
	@State var passaBloco: Bool = false
	
		var body: some View {
			VStack(alignment: .trailing){
				HStack(alignment: .top){
					Spacer()
					Button (action: {clicaBloco = true}) {
						Image("notas")
							.resizable()
							.clipped()
							.frame(width: 55, height: 55)
							.padding(15)
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
				}
			}
		}
}
