//
//  BotoesTelaInicio.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI
import SwiftData

struct BotoesTelaInicio: View {
	
	@Binding var path: [String]
	
    var body: some View {
			HStack {
				Button(action: {path.append("options")}) {
					Text("Options")
						.font(.appFont(size:20))
				}
				.padding()
				Button(action: {}) {
					Text("Achievements")
						.font(.appFont(size:20))
				}
				.padding()
				Button(action: {path.append("confirmarSair")}) {
					Text("Exit")
						.font(.appFont(size:20))
				}
				.padding()
			}
    }
}

#Preview {
    //BotoesTelaInicio()
}
