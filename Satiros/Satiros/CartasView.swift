//
//  CartasView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 28/08/25.
//

import SwiftUI

struct CartasView: View {
	
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoSalvo
	@Binding var path: [String]
	@State var passaNaCarta: [Bool] = [false, false, false, false, false]
	
    var body: some View {
			GeometryReader { geo in
					ZStack {
						HStack(spacing: 0) {
							ZStack(alignment: .topLeading) {
									Image("carta")
											.resizable()
											.clipped()
											//.aspectRatio(1/1, contentMode: .fit)
									
								VStack(alignment: .leading) {
											HStack {
												Image("popularidade")
													.resizable()
													.clipped()
													.aspectRatio(2/1, contentMode: .fit)
													.frame(width: 80, height: 40)
													.padding(.leading, 10)
												//.aspectRatio(16/10, contentMode: .fit)
												Text(String(contexto.popularidade))
													.font(.appFont(selectedFont, size: 25))
													.foregroundStyle(.white)
													.padding(.top, 15)
											}
											
											HStack {
												Image("desconfianca")
													.resizable()
													.clipped()
													.aspectRatio(2/1, contentMode: .fit)
													.frame(width: 80, height: 40)
													.padding(.leading, 30)
												Text(String(contexto.desconfianca))
													.font(.appFont(selectedFont, size: 25))
													.foregroundStyle(.white)
													.padding(.top, 15)
											}
										
									VStack (alignment: .center){
										HStack {
											Button (action: { if (contexto.horario == "confissao1") {
												contexto.desconfianca -= 1
												contexto.horario = "confissao2"
												path.removeLast()
											}
												else {
													contexto.popularidade += 1
													path.append("menu")
												}}) {
												ZStack {
													Image("moses")
														.resizable()
														.clipped()
													//.aspectRatio(2/1, contentMode: .fit)
														.frame(width: 160, height: 226)
														.scaleEffect(passaNaCarta[0] ? 1.1 : 1.0)
														.padding()
														.onHover { over in
															passaNaCarta[0] = over
														}
													if (passaNaCarta[0]) {
														Image("seta")
															.resizable()
															.clipped()
															.frame(width: 40, height: 40)
															.padding(.top, -180)
													}
												}
											}
											.buttonStyle(.plain)
											Button (action: { if (contexto.horario == "confissao1") {
												contexto.desconfianca += 1
												contexto.popularidade -= 1
												contexto.horario = "confissao2"
												path.removeLast()
											}
												else {
													contexto.popularidade += 1
													contexto.desconfianca -= 1
													path.append("menu")
												}
												}) {
												ZStack {
													Image("solomon")
														.resizable()
														.clipped()
													//.aspectRatio(2/1, contentMode: .fit)
														.frame(width: 160, height: 226)
														.scaleEffect(passaNaCarta[1] ? 1.1 : 1.0)
														.padding()
														.onHover { over in
															passaNaCarta[1] = over
														}
													if (passaNaCarta[1]) {
														Image("seta")
															.resizable()
															.clipped()
															.frame(width: 40, height: 40)
															.padding(.top, -180)
													}
												}
											}
											.buttonStyle(.plain)
											Button (action: {if (contexto.horario == "confissao1") {
												contexto.popularidade += 1
												contexto.horario = "confissao2"
												path.removeLast()
											}
												else {
													contexto.desconfianca -= 1
													path.append("menu")
												}}) {
												ZStack {
													Image("david")
														.resizable()
														.clipped()
													//.aspectRatio(2/1, contentMode: .fit)
														.frame(width: 160, height: 226)
														.scaleEffect(passaNaCarta[2] ? 1.1 : 1.0)
														.padding()
														.onHover { over in
															passaNaCarta[2] = over
														}
													if (passaNaCarta[2]) {
														Image("seta")
															.resizable()
															.clipped()
															.frame(width: 40, height: 40)
															.padding(.top, -180)
													}
												}
											}
											.buttonStyle(.plain)
										}
											.padding(40)
											HStack {
												Button (action: {if (contexto.horario == "confissao1") {
												 contexto.horario = "confissao2"
												 path.removeLast()
											 }
												 else {
													 path.append("menu")
												 }}) {
													ZStack {
														Image("joseph")
															.resizable()
															.clipped()
														//.aspectRatio(2/1, contentMode: .fit)
															.frame(width: 160, height: 226)
															.scaleEffect(passaNaCarta[3] ? 1.1 : 1.0)
															.padding()
															.onHover { over in
																passaNaCarta[3] = over
															}
														if (passaNaCarta[3]) {
															Image("seta")
																.resizable()
																.clipped()
																.frame(width: 40, height: 40)
																.padding(.top, -180)
														}
													}
												}
												.buttonStyle(.plain)
												Button (action: {if (contexto.horario == "confissao1") {
													contexto.desconfianca -= 1
												 contexto.popularidade += 1
												 contexto.horario = "confissao2"
												 path.removeLast()
											 }
												 else {
													 contexto.popularidade -= 1
													 contexto.desconfianca += 1
													 path.append("menu")
												 }}) {
													ZStack {
														Image("noah")
															.resizable()
															.clipped()
														//.aspectRatio(2/1, contentMode: .fit)
															.frame(width: 160, height: 226)
															.scaleEffect(passaNaCarta[4] ? 1.1 : 1.0)
															.padding()
															.onHover { over in
																passaNaCarta[4] = over
															}
														if (passaNaCarta[4]) {
															Image("seta")
																.resizable()
																.clipped()
																.frame(width: 40, height: 40)
																.padding(.top, -180)
														}
													}
												}
												.buttonStyle(.plain)
											}
										}
									.position(x: geo.size.width * 1/3 , y: geo.size.height * 1/2.5)
									}
									.padding(.top, 10)
								
							}
							.frame(width: geo.size.width * 2/3, height: geo.size.height)
								
								ZStack {
										Image("aaa")
												.resizable()
												.clipped()
												.aspectRatio(3/5.75, contentMode: .fit)
										
									VStack(spacing: 0) {
										
										HStack(spacing: 150){
											Image("menu")
												.resizable()
												.clipped()
												.frame(width: 40, height: 40)
											
											VStack() {
												Text("Day \(contexto.dia)")
													.foregroundColor(.white)
													.font(.appFont(selectedFont, size: 30))
												Text("Morning")
													.foregroundColor(.white)
													.font(.appFont(selectedFont, size: 30))
											}
											Button (action: {path.append("options")}){
												Image("configuracoes")
													.resizable()
													.clipped()
													.frame(width: 35, height: 35)
											}
											.buttonStyle(.plain)
										}
										.padding(.top, 10)
										.frame(maxWidth: .infinity)
										
										Text("Now you must apply penance, the cards laid in front of you are mysteriously selected and shall indicate proper action in the confessions for the day. But be careful, once you give a card away, you cannot use again until the morrow. Use them wisely, or they might begin to question your judgment.")
											.foregroundColor(.white)
											.font(.appFont(selectedFont, size: 30))
											.padding()
										Spacer()
										if (passaNaCarta[0] || passaNaCarta[1] || passaNaCarta[2] || passaNaCarta[3] || passaNaCarta[4] ) {
											ZStack (alignment: .bottom){
												Image("tentativaDeatlhe")
													.resizable()
													.clipped()
													.frame(width: 505, height: 161)
												VStack () {
													if (passaNaCarta[0]) {
														Spacer()
														Text("Moses")
															.foregroundColor(.white)
															.font(.appFont(selectedFont, size: 50))
														Text("Control, Faith, Honor")
															.foregroundColor(.white)
															.font(.appFont(selectedFont, size: 30))
															//.padding()
													}
													if (passaNaCarta[1]) {
														Spacer()
														Text("Solomon")
															.foregroundColor(.white)
															.font(.appFont(selectedFont, size: 50))
														Text("Control, Honor, Providence")
															.foregroundColor(.white)
															.font(.appFont(selectedFont, size: 30))
															//.padding()
													}
													if (passaNaCarta[2]) {
														Spacer()
														Text("David")
															.foregroundColor(.white)
															.font(.appFont(selectedFont, size: 50))
														Text("Perseverance, Faith, Providence")
															.foregroundColor(.white)
															.font(.appFont(selectedFont, size: 30))
															//.padding()
													}
													if (passaNaCarta[3]) {
														Spacer()
														Text("Joseph")
															.foregroundColor(.white)
															.font(.appFont(selectedFont, size: 50))
														Text("Loss, Perseverance, Providence")
															.foregroundColor(.white)
															.font(.appFont(selectedFont, size: 30))
															//.padding()
													}
													if (passaNaCarta[4]) {
														Spacer()
														Text("Noah")
															.foregroundColor(.white)
															.font(.appFont(selectedFont, size: 50))
														Text("Perseverance, Faith, Renunciation")
															.foregroundColor(.white)
															.font(.appFont(selectedFont, size: 30))
															//.padding()
													}
												}
												.padding(.bottom, 25)
											}
										}
										}
									.background(Color("Fundo"))
									.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
										//.scaleEffect(0.2)
								}
								.frame(width: geo.size.width / 3, height: geo.size.height)
						}
						.ignoresSafeArea()
				}
					
			}
			.navigationBarBackButtonHidden()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    //CartasView()
}
