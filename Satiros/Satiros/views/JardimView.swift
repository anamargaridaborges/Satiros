//
//  TutorialView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI
import SwiftData

struct JardimView: View {
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
	@State var passaNoAsset: Bool = false
	
		var body: some View {
			ZStack(alignment: .topLeading){
				
				Image(dialogos[contexto.idDialogo].local_fundo)
						.resizable()
						.scaleEffect((dialogos[contexto.idDialogo].personagem == "Thomas") ? 0.7 : 1.0)
						.aspectRatio(16 / 10, contentMode: .fit)
						.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
				if (contexto.idDialogo != 15) {
					FalaView( path: $path, contexto: contexto, bloco: bloco, falaNome: defineFalaNome())
					
					AtributosView(contexto: contexto)
						.offset(x: (dialogos[contexto.idDialogo].personagem == "Thomas") ? 328: 0, y: (dialogos[contexto.idDialogo].personagem == "Thomas") ? 205 : 0)
					HStack(alignment: .top){
						Spacer()
						Button (action: {path.removeAll()}){
							Image("sair")
								.resizable()
								.clipped()
								.frame(width: 50, height: 50)
								.padding(20)
								.scaleEffect(passaNoAsset ? 1.1 : 1.0)
								.onHover {over in
									passaNoAsset = over
								}
						}
						.buttonStyle(.plain)
					}
					.offset(x: (dialogos[contexto.idDialogo].personagem == "Thomas") ? -328: 0, y: (dialogos[contexto.idDialogo].personagem == "Thomas") ? 205 : 0)
				}
				
			}
			.aspectRatio(16/10, contentMode: .fill)
			.opacity(fadeIn ? 1 : 0)
			.animation(.easeIn(duration: 1), value: fadeIn)
			.opacity(fadeOut ? 0 : 1)
			.animation(.easeOut(duration: 2), value: fadeOut)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.navigationBarBackButtonHidden()
			.onChange(of: contexto.idDialogo) {
				defineFalaNome()
				if (contexto.idDialogo == 29) {
					//FalaView(contexto: contexto, bloco: bloco, falaNome: defineFalaNome()).cancelarTarefa()
					//withAnimation { fadeOut = true }
					//DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
							contexto.horario = "noite"
							contexto.local = "quarto"
							contexto.parteDialogo = 0
							path.append("quarto")
					//}
				}
//				if (contexto.idDialogo == 0 && terminou) {
//					fadeOut = false
//					DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//						withAnimation { fadeOut = true }
//					}
//
//				}
//				if (contexto.idDialogo == 80) {
//					fadeIn = false
//					DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//						withAnimation { fadeIn = true }
//					}
//				}
			}
			.onAppear {
				withAnimation { fadeIn = true }
			}
		}
	
	func defineFalaNome() -> Binding<Bool> {
		if (dialogos[contexto.idDialogo].personagem == "Thomas" || dialogos[contexto.idDialogo].personagem == "You") {
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
