//
//  SombraView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 02/09/25.
//

import SwiftUI

struct SombraView: View {
	
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	
    var body: some View {
			ZStack(alignment: .topLeading) {
					Image("sombra sombria")
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
					}
					.padding(.top, 10)
			}
    }
}

#Preview {
    //SombraView()
}
