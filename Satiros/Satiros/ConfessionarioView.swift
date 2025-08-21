//
//  ConfessionarioView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 19/08/25.
//

import SwiftUI

struct ConfessionarioView: View {
	
	@Bindable var contexto: ContextoSalvo
	@Binding var path: [Int]
	
    var body: some View {
			VStack {
				Text("Confessionário")
					.font(.VT323(size:60))
			}
			.navigationBarBackButtonHidden()
    }
}

#Preview {
    //ConfessionarioView()
}
