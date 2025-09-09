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
	@State private var fadeIn = false
	@State private var fadeOut = false
	let frames = ["cut1", "cut2", "cut3", "cut4", "cut5"]
	@State private var frameIndex = 0
	@State var tick: Bool = false
	@State private var animationFinished = false
	
    var body: some View {
			ZStack(alignment: .topLeading){
				if (dialogos[contexto.idDialogo].local_fundo == "animacaoCutscene"){
					Image(frames[frameIndex])
						.resizable()
						.aspectRatio(16/10, contentMode: .fill)
						.onChange(of: tick) { _, _ in
							if frameIndex < frames.count - 1 {
									frameIndex += 1
									DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
											tick.toggle()
									}
							} else {
								animationFinished = true
								fadeOut = false
							}
						}
						.task { tick.toggle() }

				} else {
					Image(dialogos[contexto.idDialogo].local_fundo)
						.resizable()
						.aspectRatio(16/10, contentMode: .fill)
				}
				
				
				AtributosView(contexto: contexto)
				FalaView(contexto: contexto, bloco: bloco, falaNome: defineFalaNome())
			}
			.opacity(fadeIn ? 1 : 0)
			.animation(.easeIn(duration: 1), value: fadeIn)
			.opacity(fadeOut ? 0 : 1)
			.animation(.easeOut(duration: 2), value: fadeOut)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.navigationBarBackButtonHidden()
			.onChange(of: contexto.idDialogo) {
				defineFalaNome()
				if (contexto.idDialogo == 15) {
					withAnimation { fadeOut = true }
					DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
							path.append("confessionario")
					}
					contexto.horario = "confissao1"
					contexto.local = "confessionario"
					contexto.parteDialogo = 0
				}
				if (contexto.idDialogo == 0 && terminou) {
					fadeOut = false
					DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
						withAnimation { fadeOut = true }
					}
					
				}
				if (contexto.idDialogo == 80) {
					fadeIn = false
					DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
						withAnimation { fadeIn = true }
					}
					
				}
			}
			.onAppear {
				withAnimation { fadeIn = true }
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
