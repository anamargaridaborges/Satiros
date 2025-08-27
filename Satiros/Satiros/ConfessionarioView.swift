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
					ZStack {
						
						HStack(spacing: 0) {
							ZStack(alignment: .topLeading) {
									Image("grade confessionario")
											.resizable()
											.clipped()
											//.aspectRatio(1/1, contentMode: .fit)
									
									VStack(alignment: .leading, spacing: 10) {
											Image("popularidade")
													.resizable()
													.clipped()
													.frame(width: 50, height: 40)
													//.aspectRatio(16/10, contentMode: .fit)
											
											Image("desconfianca")
													.resizable()
													.clipped()
													.frame(width: 50, height: 40)
													.padding(.horizontal, 20)
													.aspectRatio(16/8, contentMode: .fit)
									}
									//.padding(.top, 10)
							}
								.frame(width: geo.size.width * 2/3, height: geo.size.height)
								
								ZStack {
										Image("aaa")
												.resizable()
												.clipped()
												.aspectRatio(3/5.75, contentMode: .fit)
										
										VStack(spacing: 10) {
											
											HStack(spacing: 150){
												Image("menu")
													.resizable()
													.clipped()
													.frame(width: 40, height: 40)
													
												VStack() {
														Text("Day \(contexto.dia)")
																.font(.appFont(selectedFont, size: 30))
														Text("Morning")
																.font(.appFont(selectedFont, size: 30))
												}

												Image("configuracoes")
													.resizable()
													.clipped()
													.frame(width: 35, height: 35)
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
									
								}
								.frame(width: geo.size.width / 3, height: geo.size.height)
						}
						.ignoresSafeArea()
				}
					
			}
			.navigationBarBackButtonHidden()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		} //fim body
}

#Preview {
    //ConfessionarioView()
}
