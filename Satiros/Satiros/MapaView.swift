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
	@Binding var path: [String]
	@FocusState private var estaFocado: FocusKey?
	@State var texto: String = ""
	@State var opcoes: [String] = []
	@State var terminou: Bool = true
	@State private var tarefaOpcoes: Task<Void, Never>? = nil
	@Bindable var bloco: ContextoConfessionario3.Bloco
	
		var body: some View {
			ZStack(alignment: .bottom){
				Image("paredeMapa")
					.resizable()
					.aspectRatio(16/10, contentMode: .fit)
				
				Image("portaMapa")
					//.clipped()
					//.padding(.bottom, 10)
					.frame(width: 550, height: 960)
				
				AtributosView(contexto: contexto)
				
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.navigationBarBackButtonHidden()
		}
}


//#Preview {
//    MapaView()
//}
