//
//  ConfirmarNovoJogo.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 20/08/25.
//

import SwiftUI

struct ConfirmarNovoJogo: View {
	
	@Binding var path: [Int]
	
    var body: some View {
			VStack {
				Text("Confirm new game?")
					.font(.VT323(size:50))
					.padding()
				Text("All your progress in the current game will be lost.")
					.font(.VT323(size:20))
					.padding()
				HStack {
					Button(action: {}) {
						Text("Yes, I confirm")
							.font(.VT323(size:30))
					}
					.padding()
					Button(action: {}) {
						Text("No, I decline")
							.font(.VT323(size:30))
					}
					.padding()
				}
			}
    }
}

#Preview {
   // ConfirmarNovoJogo()
}
