//
//  ConfessionarioView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 19/08/25.
//

import SwiftUI
import SwiftData

struct ConfessionarioView: View {
	
	@Bindable var contexto: ContextoSalvo
	@Binding var path: [String]
	
    var body: some View {
			VStack {
				Text("Confessionário")
					.font(.appFont(size:60))
				Text(String(contexto.popularidade))
					.font(.appFont(size:60))
			}
			.navigationBarBackButtonHidden()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    //ConfessionarioView()
}
