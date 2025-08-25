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
			VStack {
				HStack{
					Circle()
						.frame(width: 50, height: 50)
						.padding(.leading, 10)
					
					Spacer()
					Text("Day \(contexto.dia) - Morning")
						.font(.appFont(selectedFont,size:30))
					
					Spacer()
					VStack{
						Rectangle() //popularidade
							.frame(width: 200, height: 30)
							.padding(.top, 10)
							.padding(.trailing, 20)
						
						Rectangle()//desconfiança
							.frame(width: 200, height: 30)
							.padding(.trailing, 20)
					}
				}
				HStack{ //bloco de notas
					Spacer()
					Rectangle()
						.frame(width: 120, height: 120)
						.padding(20)
				}
				
	
				Spacer()
				Rectangle()
						.frame(width: 800, height: 200)
						.overlay(
								Text("texto da confissao")
										.font(.appFont(selectedFont, size: 30))
										.foregroundColor(.black),
								alignment: .center
						)
						.overlay(
								Rectangle()
										.frame(width: 40, height: 30)
										.foregroundColor(.gray)
										.padding(10),
								alignment: .bottomTrailing
						)
						.padding(.bottom, 50)

			}
			.navigationBarBackButtonHidden()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
}

#Preview {
    //ConfessionarioView()
}
