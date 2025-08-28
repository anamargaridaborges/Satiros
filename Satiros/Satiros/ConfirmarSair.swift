//
//  ConfirmarSair.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI
import SwiftData

struct ConfirmarSair: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Binding var path: [String]
	
    var body: some View {
			ZStack{
				Image("fundo pixel")
						.resizable()
						.clipped()
						.aspectRatio(16/10, contentMode: .fit)
				VStack {
					Text("Confirm exit?")
						.font(.appFont(selectedFont, size:50))
						.padding()
					HStack {
						
						Button(action: {exit(-1)}) {
							ZStack {
								Image("botao continue")
										.resizable()
										.scaledToFit()
										.frame(width: 200, height: 100)
								
								Text("Yes, I confirm")
									.font(.appFont(selectedFont, size: 25))
										.foregroundColor(.white)
							}
						}
						.buttonStyle(.plain)
						.padding()
						
						Button(action: {path.removeAll()}) {
							ZStack {
								Image("botao continue")
										.resizable()
										.scaledToFit()
										.frame(width: 200, height: 100)
								
								Text("No, I decline")
									.font(.appFont(selectedFont, size: 25))
										.foregroundColor(.white)
							}
						}
						.buttonStyle(.plain)
						.padding()
					}
				}
			}
			
			.navigationBarBackButtonHidden()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    //ConfirmarSair()
}
