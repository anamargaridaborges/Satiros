import SwiftUI
import WidgetKit

struct BotaoSair: View {
	
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@Binding var path: [Caminhos]
	@State private var passaNoAsset: Bool = false
	//@FocusState private var estaFocado: FocusKey?
	
	var body: some View {
		HStack(alignment: .top){
			Spacer()
			Button (action: {path.removeAll()}){
				Image("sair")
					.resizable()
					.clipped()
					.frame(width: 45, height: 45)
					.scaleEffect(passaNoAsset ? 1.1 : 1.0)
					.onHover {over in
						passaNoAsset = over
					}
					.padding(20)
			}
			.buttonStyle(.plain)
//			.focusable()
//			.focusEffectDisabled()
//			.focused($estaFocado, equals: FocusKey.escape)
//			.onKeyPress(.escape) {
//				path.removeAll()
//				return .handled
//			}
//			.onChange(of: estaFocado) {
//				estaFocado = FocusKey.escape
//			}

		}
	}
}
