//
//  creditos.swift
//  Satiros
//
//  Created by Jordana Lourenço Santos on 24/09/25.
//

import SwiftUI

struct CreditosView: View {
	
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@State var defaults = UserDefaults.standard
	@Binding var path: [Caminhos]
	
	var body: some View {
		ZStack {
			Image("fundoMural")
				.resizable()
				.scaledToFill()
				.ignoresSafeArea()
			
			// Botão voltar
			VStack {
				HStack {
					Button(action: { path.removeLast() }) {
						Image(systemName: "chevron.left")
							.font(.title)
							.fontWeight(.bold)
							.foregroundColor(.white)
					}
					.buttonStyle(.plain)
					.padding(.top, 10)
					.padding(.leading)

					Spacer()
				}
				Spacer()
			}
			
			// Conteúdo principal
			ZStack {
				// Balão
				ZStack {
					Image("balaoSatyr")
						.resizable()
						.frame(width: 350, height: 80)
					
					Text("Satyr Studios")
						.font(.appFont(selectedFont, size: 40))
						.foregroundColor(.black)
				}
				.offset(y: -300)
				
				// Polaroids
				PolaroidView(imageName: "shaya", name: "Shaya")
					.offset(x: -500, y: -200)
				
				PolaroidView(imageName: "uli", name: "Ulisses")
					.offset(x: 500, y: -200)
				
				PolaroidView(imageName: "lima", name: "Lima")
					.offset(x: -400, y: 200)
				
				PolaroidView(imageName: "meg", name: "Meg")
					.offset(x: 420, y: 220)
				
				PolaroidView(imageName: "jo", name: "Jordana")
					.offset(y: 50)
				

			}
		}
		.navigationBarBackButtonHidden()
	}
}


struct PolaroidView: View {
		@AppStorage("selectedFont") private var selectedFont: String = "VT323"
		var imageName: String
		var name: String
		
		var body: some View {
			ZStack(alignment: .bottom){
				Image(imageName)
					.resizable()
					.scaledToFit()
					.frame(width: 300, height: 350)

				Text(name)
					.font(.appFont(selectedFont, size: 30))
					.bold()
					.foregroundColor(.black)
					.padding(.bottom, 30)
			}
		}
}
