//
//  FimDia1.swift
//  Satiros
//
//  Created by Jordana Lourenço Santos on 16/10/25.
//

import SwiftUI
import SwiftData

struct FimDia1: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@Binding var path: [Caminhos]
	@FocusState private var estaFocado: FocusKey?
	@State private var fadeIn = false
	@State private var fadeOut = false
	
		var body: some View {
			ZStack(alignment: .center){
				Image("fundo pixel")
					.resizable()
					.aspectRatio(16/10, contentMode: .fill)
				
				Text("The first day is done. \nConfess what you have seen, and rest before the next trial. \nThank you for joining us in Forgive Me, Father — your voice will guide what comes next.")
					.font(.appFont(selectedFont, size: 30))
					.foregroundStyle(.white)
					.padding(.bottom, 30)
					.lineSpacing(20)
					.multilineTextAlignment(.center)
				
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
					path.removeAll()
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
