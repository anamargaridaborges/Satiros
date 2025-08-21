//
//  TutorialView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI

struct TutorialView: View {
	
	@Bindable var contexto: ContextoSalvo
	@Binding var path: [ContextoSalvo]
	
    var body: some View {
			VStack {
				Text("Tutorial")
					.font(.VT323(size:60))
				Button(action: {contexto.local = "confessionario"; path.append(contexto)}) {
					Text("Ir pro confessionário")
						.font(.VT323(size:30))
				}
				Text(String(contexto.popularidade))
					.font(.VT323(size:60))
				Button(action: {contexto.popularidade += 1}) {
					Text("Aumentar popularidade")
						.font(.VT323(size:30))
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.navigationBarBackButtonHidden()
    }
}

#Preview {
    //TutorialView()
}
