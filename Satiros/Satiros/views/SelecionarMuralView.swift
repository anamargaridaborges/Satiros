//
//  TutorialView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI
import SwiftData

struct SelecionarMuralView: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Binding var path: [Caminhos]
	@State private var fadeIn = false
	@State private var fadeOut = false
	@State var passaMural: Bool = false
	
	var body: some View {
		GeometryReader { geometry in
		ZStack(alignment: .topLeading){
			Image("Quarto")
				.resizable()
				.aspectRatio(16 / 10, contentMode: .fit)
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			
			Button (action: {path.append(.mural)}) {
						Image("muralzinho")
							.resizable()
							.scaledToFit()
							.frame(width: geometry.size.width * 0.25)
						//.contentShape(Rectangle())
							.onHover {over in
								passaMural = over
							}
					}
					.scaleEffect(passaMural ? 1.2 : 1)
					.buttonStyle(.plain)
					.offset(x: 650, y:200)
			
		}
	}
		.aspectRatio(16/10, contentMode: .fit)
			.opacity(fadeIn ? 1 : 0)
			.animation(.easeIn(duration: 1), value: fadeIn)
			.opacity(fadeOut ? 0 : 1)
			.animation(.easeOut(duration: 2), value: fadeOut)
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			.navigationBarBackButtonHidden()
			.onAppear {
				withAnimation { fadeIn = true }
			}
		}
	
}

#Preview {
		//TutorialView()
}
