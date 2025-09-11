//
//  TutorialView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI
import SwiftData

struct FalaIntroView: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@Binding var path: [String]
	@FocusState private var estaFocado: FocusKey?
	@State var texto: String = ""
	//@State var idFala: Int = 0
	@State var opcoes: [String] = []
	@State var terminou: Bool = true
	@State private var tarefaOpcoes: Task<Void, Never>? = nil
	@Bindable var bloco: ContextoConfessionario3.Bloco
	@State var falaNome: Bool = false
	@State private var fadeIn = false
	@State private var fadeOut = false
	
		var body: some View {
			ZStack(alignment: .center){
				Image("fundo pixel")
					.resizable()
					.aspectRatio(16/10, contentMode: .fill)
				
				VStack{
					Text("The Lord detests lying lips, but He delights in those who tell the truth.")
						.font(.appFont(selectedFont, size: 30))
						.foregroundStyle(.white)
						.padding(.bottom, 30)
					
					Text("Proverbs 12:22")
						.font(.appFont(selectedFont, size: 25))
						.foregroundStyle(.white)
				}
			}
			.opacity(fadeIn ? 1 : 0)
			.animation(.easeIn(duration: 1), value: fadeIn)
			.opacity(fadeOut ? 0 : 1)
			.animation(.easeOut(duration: 1), value: fadeOut)
			.focusable()
			.focusEffectDisabled()
			.focused($estaFocado, equals: FocusKey.enter)
			.onKeyPress(.return) {
				withAnimation { fadeOut = true }
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
						path.append("tutorial")
				}
				return .handled
			}
			.onAppear() {
				estaFocado = FocusKey.enter
				withAnimation { fadeIn = true }
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.navigationBarBackButtonHidden()
			
		}
	
	
}

//#Preview {
//		//TutorialView()
//}
