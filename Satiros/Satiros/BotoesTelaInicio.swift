//
//  BotoesTelaInicio.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI

struct BotoesTelaInicio: View {
    var body: some View {
			HStack {
				Button(action: {}) {
					Text("Options")
						.font(.VT323(size:20))
				}
				.padding()
				Button(action: {}) {
					Text("Achievements")
						.font(.VT323(size:20))
				}
				.padding()
				Button(action: {}) {
					Text("Exit")
						.font(.VT323(size:20))
				}
				.padding()
			}
    }
}

#Preview {
    BotoesTelaInicio()
}
