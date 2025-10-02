//
//  MapaView.swift
//  Satiros
//
//  Created by Jordana Lourenço Santos on 06/09/25.
//

import SwiftUI
import SwiftData

struct MapaView: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@Binding var path: [Caminhos]
	//@FocusState private var estaFocado: FocusKey?
	@Bindable var bloco: ContextoConfessionario3.Bloco
	@State var passaNaPlaca: [Bool] = [false, false, false, false]
	@State private var fadeIn = false
	@State private var fadeOut = false
	@State var clicaBloco = false
	
		var body: some View {
			ZStack(alignment: .topLeading){
				Image("paredeMapa")
					.resizable()
					.aspectRatio(16/10, contentMode: .fit)
				
				HStack{
					Spacer()
					VStack (spacing: 50){ //placas esquerda
						Button(action: {
							contexto.local = .jardim; contexto.idDialogo = 71; contexto.horario = "tarde"; contexto.parteDialogo = 0;
							withAnimation { fadeOut = true }
							DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
								path.append(.jardim)
							}
						}){
							ZStack(alignment: .bottomTrailing){
								Image("placaEsquerda")
									.resizable()
									.clipped()
									.frame(width: 295, height: 160)
									.padding()
								
								Text("Garden")
									.font(.custom(selectedFont, size: 40))
									.foregroundColor(.white)
									.offset(x: -50, y: -100)
								
								Image("setaEsquerda")
									.resizable()
									.clipped()
									.frame(width: 84, height: 46)
									.padding(.bottom, 30)
									.padding(.trailing, 50)

							}
							.scaleEffect(passaNaPlaca[0] ? 1.1 : 1.0)
							.onHover { over in
								passaNaPlaca[0] = over
							}
							
						}
						.buttonStyle(.plain)
						
						ZStack(alignment: .bottomTrailing){
							Image("placaEsquerda")
								.resizable()
								.clipped()
								.frame(width: 295, height: 160)
								.padding()
							
							Text("*********")
								.font(.custom(selectedFont, size: 40))
								.foregroundColor(.gray)
								.offset(x: -50, y: -100)
							
							Image("setaEsquerda")
								.resizable()
								.clipped()
								.frame(width: 84, height: 46)
								.padding(.bottom, 30)
								.padding(.trailing, 50)
						}
						.opacity(0.8)
						
						
					}
					.padding(50)
					
					VStack (){ //porta e cruz
						Spacer()
						Image("cruzMapa")
							.resizable()
							.clipped()
							.frame(width: 73, height: 110)
							.padding()
						
						Image("portaMapa")
							.resizable()
							.clipped()
							.frame(width: 440, height: 770)
					}
					
					VStack (spacing: 50){ //placas direita
						Button(action: {
							contexto.local = .biblioteca; contexto.idDialogo = 90; contexto.horario = "tarde"; contexto.parteDialogo = 0;
							withAnimation { fadeOut = true }
							DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
								path.append(.biblioteca)
							}
						}) {
							ZStack(alignment: .bottomLeading){
								Image("placaDireita")
									.resizable()
									.clipped()
									.frame(width: 295, height: 160)
									.padding()
								
								Text("Library")
									.font(.custom(selectedFont, size: 40))
									.foregroundColor(.white)
									.offset(x: 50, y: -100)
								
								Image("setaDireita")
									.resizable()
									.clipped()
									.frame(width: 84, height: 46)
									.padding(.bottom, 30)
									.padding(.leading, 50)
							}
							.scaleEffect(passaNaPlaca[3] ? 1.1 : 1.0)
							.onHover { over in
								passaNaPlaca[3] = over
							}
						}
						.buttonStyle(.plain)
						
						ZStack(alignment: .bottomLeading){
							Image("placaDireita")
								.resizable()
								.clipped()
								.frame(width: 295, height: 160)
								.padding()
							
							Text("******")
								.font(.custom(selectedFont, size: 40))
								.foregroundColor(.gray)
								.offset(x: 50, y: -100)
							
							Image("setaDireita")
								.resizable()
								.clipped()
								.frame(width: 84, height: 46)
								.padding(.bottom, 30)
								.padding(.leading, 50)
						}
						.opacity(0.8)
					}
					.padding(50)
					Spacer()
				}
				AtributosView(contexto: contexto)
				BotaoSair(contexto: contexto, path: $path, clicaBloco: $clicaBloco)
				
				if (clicaBloco) {
					BlocoView(path: $path, bloco: bloco, clicaNotas: $clicaBloco)
				}
			}
			.onAppear {
				withAnimation { fadeIn = true }
			}
			.opacity(fadeIn ? 1 : 0)
			.animation(.easeIn(duration: 1), value: fadeIn)
			.opacity(fadeOut ? 0 : 1)
			.animation(.easeOut(duration: 1), value: fadeOut)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.navigationBarBackButtonHidden()
		}
}


//#Preview {
//    MapaView()
//}
