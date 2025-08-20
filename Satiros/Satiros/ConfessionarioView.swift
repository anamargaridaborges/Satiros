//
//  ConfessionarioView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 19/08/25.
//

import SwiftUI

struct ConfessionarioView: View {
	
	@Bindable var contexto: ContextoSalvo
	
    var body: some View {
        Text("Confessionário")
				Button("Voltar") {
					contexto.local = "introducao"
			}
    }
}

#Preview {
    //ConfessionarioView()
}
