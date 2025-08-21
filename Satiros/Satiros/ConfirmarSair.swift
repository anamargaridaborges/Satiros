//
//  ConfirmarSair.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI
import SwiftData

struct ConfirmarSair: View {
	
	@Binding var path: [String]
	
    var body: some View {
			VStack {
				Text("Confirm exit?")
					.font(.appFont(size:50))
					.padding()
				HStack {
					Button(action: {exit(-1)}) {
						Text("Yes, I confirm")
							.font(.appFont(size:30))
					}
					.padding()
					Button(action: {path.removeAll()}) {
						Text("No, I decline")
							.font(.appFont(size:30))
					}
					.padding()
				}
			}
			.navigationBarBackButtonHidden()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    //ConfirmarSair()
}
