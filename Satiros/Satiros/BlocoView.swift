//
//  BlocoView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 03/09/25.
//

import SwiftUI

struct BlocoView: View {
	
	@Binding var path: [String]
	@Bindable var bloco: ContextoConfessionario3.Bloco
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	
    var body: some View {
			ZStack {
				Image("BlocoSemSetas")
					.scaleEffect(6.0)
				ForEach (bloco.textoPorDia.indices, id: \.self) { index in
					VStack {
						Text("Dia \(index)")
						Text(bloco.textoPorDia[index])
							.foregroundColor(.black)
							.font(.appFont(selectedFont, size: 30))
					}
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    //BlocoView()
}
