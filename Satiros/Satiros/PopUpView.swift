//
//  PopUpView.swift
//  Satiros
//
//  Created by Jordana Lourenço Santos on 04/09/25.
//

import SwiftUI

struct PopUpView: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@Binding var path: [String]
	@Environment(\.modelContext) private var modelContext
	@Bindable var bloco: ContextoConfessionario3.Bloco
	
	var body: some View {
			ZStack {
					// Fundo clicável
					Button(action: { path.append("tutorial") }) {
							Rectangle()
									.fill(Color.gray)
									.aspectRatio(contentMode: .fill)
					}
					.buttonStyle(.plain)
					
					// Popup com texto dentro
					ZStack(alignment: .topLeading) {
							Image("popup")
									.frame(width: 700, height: 315)
									.clipped()
							
							VStack(alignment: .leading, spacing: 10) {
								Text("Tutorial")
									.font(.custom(selectedFont, size: 35))
																
									HStack(alignment: .top, spacing: 25) {
											Text("To move to the next line, press the return key.")
													.font(.custom(selectedFont, size: 25))
													.multilineTextAlignment(.leading)
													.padding(.top, 15)
											
											Image("enter")
													.resizable()
													.scaledToFit()
													.frame(width: 120, height: 50)
									}
								HStack(alignment: .top, spacing: 60) {
										Text("Popularity shows how much you’re liked and trusted. Don’t let it drop too low!")
												.font(.custom(selectedFont, size: 25))
												.multilineTextAlignment(.leading)
												.padding(.top, 15)
										
										Image("popularidade10")
												.resizable()
												.scaledToFit()
												.frame(width: 120, height: 50)
								}
								HStack(alignment: .top, spacing: 70) {
										Text("Distrust shows how close you are to being discovered. Don’t let it fill up!")
												.font(.custom(selectedFont, size: 25))
												.multilineTextAlignment(.leading)
												.padding(.top, 15)
										
										Image("desconfianca10")
												.resizable()
												.scaledToFit()
												.frame(width: 120, height: 50)
								}
							}
							.padding(30)
							.frame(width: 680, alignment: .leading)
					}
			}
			.navigationBarBackButtonHidden()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
	}

}

//#Preview {
//    PopUpView()
//}
