//
//  TutorialView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI

struct TutorialView: View {
	
	@Bindable var contexto: ContextoSalvo
	@Binding var path: [Int]
	
    var body: some View {
			VStack {
				Text("Tutorial")
					.font(.VT323(size:60))
			}
			.navigationBarBackButtonHidden()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    //TutorialView()
}
