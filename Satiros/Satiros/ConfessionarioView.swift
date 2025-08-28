//
//  ConfessionarioView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 19/08/25.
//

import SwiftUI
import SwiftData

struct ConfessionarioView: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoSalvo
	@Binding var path: [String]
	
    var body: some View {
			GeometryReader { geo in
				HStack() {
					//LADO ESQUERDO
					ZStack(alignment: .topLeading) {
						AnimatedImageBackground()
						
//						Image("sombra sombria")
//								.resizable()
//								.clipped()
//								//.aspectRatio(1/1, contentMode: .fit)
						
						VStack(alignment: .leading) {
							HStack{
								Image("popularidade")
										.resizable()
										.clipped()
										.aspectRatio(2/1, contentMode: .fit)
										.frame(width: 80, height: 40)
										.padding(.leading, 10)
								
								Text(String(contexto.popularidade))
										.font(.appFont(selectedFont, size: 25))
										.padding(.top, 15)
							}
							
							HStack{
								Image("desconfianca")
										.resizable()
										.clipped()
										.aspectRatio(2/1, contentMode: .fit)
										.frame(width: 80, height: 40)
										.padding(.leading, 30)
								
								
								Text(String(contexto.desconfianca))
										.font(.appFont(selectedFont, size: 25))
										.padding(.top, 15)
							}
						}
						.padding(10)
					}
					.frame(width: geo.size.width * 2/3, height: geo.size.height)
					
					//LADO DIREITO
					VStack() {
						HStack(spacing: 150){
							Image("menu")
								.resizable()
								.clipped()
								.aspectRatio(1/1, contentMode: .fit)
								.frame(width: 40, height: 40)
								
								
							VStack() {
								Text("Day \(contexto.dia)")
										.font(.appFont(selectedFont, size: 30))
								Text("Morning")
										.font(.appFont(selectedFont, size: 30))
							}
							
							Button(action: {path.append("options")}) { 
								Image("configuracoes")
										.resizable()
										.scaledToFit()
										.aspectRatio(1/1, contentMode: .fit)
										.frame(width: 35, height: 35)
							}
							.buttonStyle(.plain)
							.padding()
							}
							.padding(.top, 10)
						
							Spacer()
							Text("Long paragraph of text that will wrap correctly above the image background...")
									.font(.appFont(selectedFont, size: 25))
									.multilineTextAlignment(.leading)
									.lineLimit(nil)
									.fixedSize(horizontal: false, vertical: true)
									.padding(.horizontal, 15)
							Spacer()
							Text("Another line of text here...")
									.font(.appFont(selectedFont, size: 25))
									.multilineTextAlignment(.leading)
									.lineLimit(nil)
									.fixedSize(horizontal: false, vertical: true)
									.padding(.horizontal, 15)
							Spacer()
					}
					.frame(width: geo.size.width / 3, height: geo.size.height)
				}
				.ignoresSafeArea()
					
			}
			.navigationBarBackButtonHidden()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
}

struct AnimatedImageBackground: View {
		@State private var frameIndex = 0
		let frames = ["sombra sombria", "grade confessionario"]
		let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
		
		var body: some View {
				Image(frames[frameIndex])
						.resizable()
						.scaledToFill()
						.ignoresSafeArea()
						.onReceive(timer) { _ in
								frameIndex = (frameIndex + 1) % frames.count
						}
		}
}


#Preview {
    //ConfessionarioView()
}
