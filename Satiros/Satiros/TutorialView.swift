//
//  TutorialView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI
import SwiftData

struct TutorialView: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@Binding var path: [String]
	@FocusState private var estaFocado: FocusKey?
	@State var texto: String = ""
	//@State var idFala: Int = 0
	@State var opcoes: [String] = []
	@State var terminou: Bool = true
	@State private var tarefaOpcoes: Task<Void, Never>? = nil
	@Bindable var bloco: ContextoConfessionario3.Bloco
	
    var body: some View {
			ZStack(alignment: .topLeading){
				Image("fundo pixel")
					.resizable()
					.clipped()
					.aspectRatio(16/10, contentMode: .fit)
				
				AtributosView(contexto: contexto)
				FalaView(contexto: contexto, bloco: bloco)
				
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.navigationBarBackButtonHidden()
			.onChange(of: contexto.idDialogo) {
				if (contexto.idDialogo == 15) {
					contexto.horario = "confissao1"
					contexto.local = "confessionario"
					contexto.parteDialogo = 0
					path.append("confessionario")
				}
			}
    }
}

#Preview {
    //TutorialView()
}
