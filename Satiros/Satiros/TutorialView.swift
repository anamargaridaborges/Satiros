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
	@State var falaNome: Bool = false
	
    var body: some View {
			ZStack(alignment: .topLeading){
				Image(dialogos[contexto.idDialogo ?? 0].local_fundo)
					.resizable()
					.aspectRatio(16/10, contentMode: .fill)
				
				AtributosView(contexto: contexto)
				FalaView(contexto: contexto, bloco: bloco, falaNome: defineFalaNome())

			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.navigationBarBackButtonHidden()
			.onChange(of: contexto.idDialogo) {
				defineFalaNome()
				if (contexto.idDialogo == 15) {
					contexto.horario = "confissao1"
					contexto.local = "confessionario"
					contexto.parteDialogo = 0
					path.append("confessionario")
				}
			}
    }
	func defineFalaNome() -> Binding<Bool> {
		if (dialogos[contexto.idDialogo].personagem == "Sister Desmond" || dialogos[contexto.idDialogo].personagem == "You") {
			falaNome = true
		} else {
			falaNome = false
		}
		return $falaNome
	}
	
}

#Preview {
    //TutorialView()
}
