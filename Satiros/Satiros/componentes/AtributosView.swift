//
//  AtributosView.swift
//  Satiros
//
//  Created by Jordana Lourenço Santos on 03/09/25.
//

import SwiftUI

struct AtributosView: View {
	
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@State var passaNoAsset: [Bool] = [false, false] //[popularidade, desconfianca]
	@State var mostrarBalao:  [Bool] = [false, false]
	
		var body: some View {
					VStack(alignment: .leading) {
						HStack {
							let pop = "popularidade" + String(contexto.popularidade)
							Image(pop)
								.resizable()
								.clipped()
								.aspectRatio(2/1, contentMode: .fit)
								.frame(width: 100, height: 50)
								.padding(.leading, 15)
								.aspectRatio(16/10, contentMode: .fit)
							
							Text(String(contexto.popularidade))
								.font(.appFont(selectedFont, size: 30))
								.foregroundStyle(.white)
								//.shadow(radius: 5)

						}
						.scaleEffect(passaNoAsset[0] ? 1.1 : 1.0)
						.onHover { over in
							passaNoAsset[0] = over
							mostrarBalao[0] = over
						}
						.overlay(alignment: .leading) {
							if mostrarBalao[0] {
								ZStack {
									Image("balaoAtributos")
											.resizable()
											.frame(width: 400, height: 100)
									Text("Popularity shows how much you’re liked and trusted. Don’t let it drop too low!")
										.font(.appFont(selectedFont, size: 20))
											.foregroundColor(.black)
											.padding()
								}
								.offset(x: 180, y: 20)
								.transition(.opacity)
							}
						}
							
						HStack {
							let des = "desconfianca" + String(contexto.desconfianca)
							Image(des)
								.resizable()
								.clipped()
								.aspectRatio(2/1, contentMode: .fit)
								.frame(width: 100, height: 50)
								.padding(.leading, 40)
							
							Text(String(contexto.desconfianca))
								.font(.appFont(selectedFont, size: 30))
								.foregroundStyle(.white)
								.padding(.top, 25)
								//.shadow(radius: 5)

						}
						.scaleEffect(passaNoAsset[1] ? 1.1 : 1.0)
						.onHover { over in
							passaNoAsset[1] = over
							mostrarBalao[1] = over
						}
						.overlay(alignment: .leading) {
							if mostrarBalao[1] {
								ZStack {
									Image("balaoAtributos")
											.resizable()
											.frame(width: 400, height: 100)
                  
									Text("Distrust shows how much people doubt you. Don’t let it fill up!")
										  .font(.appFont(selectedFont, size: 20))
											.foregroundColor(.black)
											.padding()
								}
								.offset(x: 200, y: 10)
								.transition(.opacity)
							}
						}
					}
					.padding(.top, 20)
		}
}

#Preview {
		//SombraView()
}
