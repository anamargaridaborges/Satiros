//
//  BlocoView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 03/09/25.
//

import SwiftUI

struct SuspeitoView: View {
	
	var suspeito: String
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Binding var clicaFoto: Bool
	@Binding var path: [Caminhos]
	
		var body: some View {
			GeometryReader { geo in
				ZStack {
					Image("Fundo preto")
						.opacity(0.5)
					
					if (suspeito == "Benedict") {
						VStack{
							Image("BenedictPolaroid")
								.resizable()
								.scaledToFit()
								.frame(width: geo.size.width * 0.2)
								.offset(x: -600, y: -150)
							botaoSuspeito()
						}
					}
					
					if (suspeito == "Steffano") {
						VStack{
							Image("StephanoPolaroid")
								.resizable()
								.scaledToFit()
								.frame(width: geo.size.width * 0.2)
								.offset(x: -600, y: -150)
							botaoSuspeito()
						}
					}
					
					if (suspeito == "Thomas") {
						VStack{
							Image("ThomasPolaroid")
								.resizable()
								.scaledToFit()
								.frame(width: geo.size.width * 0.2)
								.offset(x: -600, y: -150)
							botaoSuspeito()
						}
					}
					
					if (suspeito == "Edgar") {
						VStack{
							Image("EdgarPolaroid")
								.resizable()
								.scaledToFit()
								.frame(width: geo.size.width * 0.2)
								.offset(x: -600, y: -150)
							botaoSuspeito()
						}
					}
					
					if (suspeito == "Samuel") {
						VStack{
							Image("SamuelPolaroid")
								.resizable()
								.scaledToFit()
								.frame(width: geo.size.width * 0.2)
								.offset(x: -600, y: -150)
							botaoSuspeito()
						}
					}
					
					if (suspeito == "S. Desmond") {
						Image("DesmondPolaroid")
							.resizable()
							.scaledToFit()
							.frame(width: geo.size.width * 0.2)
							.offset(x: -600, y: -150)
					}
					
					if (suspeito == "Fr. Lorgan") {
						Image("LorganPolaroid")
							.resizable()
							.scaledToFit()
							.frame(width: geo.size.width * 0.2)
							.offset(x: -600, y: -150)
					}
					
					ZStack {
						Image("BlocoGRANDAO")
							.resizable()
							.scaledToFit()
							.frame(width: geo.size.width * 0.9)
							.position(x: geo.size.width * 2 / 3, y: geo.size.height * 1 / 2)

							Text(suspeito)
								.foregroundColor(.black)
								.font(.appFont(selectedFont, size: 50))
								.position(x: geo.size.width * 2 / 3, y: geo.size.height * 2.3 / 7)
						
						if (suspeito == "Benedict") {
							Text("Aristocrat turned zealot. Left his\nwealth and comfort for the Lord’s work.")
								.foregroundColor(.black)
								.font(.appFont(selectedFont, size: 30))
								.position(x: geo.size.width * 2 / 3, y: geo.size.height * 1 / 2)
						}
						if (suspeito == "Steffano") {
							Text("Endlessly devout. Natural scholar.\nNot an easy talker…")
								.foregroundColor(.black)
								.font(.appFont(selectedFont, size: 30))
								.position(x: geo.size.width * 2 / 3, y: geo.size.height * 1 / 2)
						}
						if (suspeito == "Thomas") {
							Text("Lives in his own world, the family sent\nhim here for “treatment”, turns out he is\nactually a good evangelist ")
								.foregroundColor(.black)
								.font(.appFont(selectedFont, size: 30))
								.position(x: geo.size.width * 2 / 3, y: geo.size.height * 1 / 2)
						}
						if (suspeito == "Edgar") {
							Text("Sly as a fox. A very close friend to Lorgan.")
								.foregroundColor(.black)
								.font(.appFont(selectedFont, size: 30))
								.position(x: geo.size.width * 2 / 3, y: geo.size.height * 1 / 2)
						}
						if (suspeito == "Samuel") {
							Text("The closest to graduating, a natural charmer.")
								.foregroundColor(.black)
								.font(.appFont(selectedFont, size: 30))
								.position(x: geo.size.width * 2 / 3, y: geo.size.height * 1 / 2)
						}
						if (suspeito == "Fr. Lorgan") {
							Text("Why did he disappear?\nOr, who was responsible for it?")
								.foregroundColor(.black)
								.font(.appFont(selectedFont, size: 30))
								.position(x: geo.size.width * 2 / 3, y: geo.size.height * 1 / 2)
						}
						if (suspeito == "S. Desmond") {
							Text("Seems to know everything that's happening\naround here. Thinks one of the boys is\nresponsiblefor Lorgan vanishing.")
								.foregroundColor(.black)
								.font(.appFont(selectedFont, size: 30))
								.position(x: geo.size.width * 2 / 3, y: geo.size.height * 1 / 2)
						}
					}
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					//.position(x: geo.size.width * 1 / 2, y: geo.size.height * 1 / 2)
					
					HStack {
						Button(action: {clicaFoto = false}) {
							Image("botaoFechar 1")
						}
						.buttonStyle(.plain)
					}
					.position(x: geo.size.width * 1 / 10, y: geo.size.height * 1.2 / 7)
					
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
	
	func	botaoSuspeito() -> some View {
		Button(action: {path.append(.fimDia1)}) {
			ZStack {
				Image("BotaoDenunciar")
					.resizable()
					.scaledToFit()
					.frame(width: 300)
				Text("Appoint suspect")
					.foregroundColor(.black)
					.font(.appFont(selectedFont, size: 30))
			}
		}
		.buttonStyle(.plain)
		.offset(x: -600, y: -120)
	}
	
}



#Preview {
		//BlocoView()
}
