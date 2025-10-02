//
//  TutorialView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI
import SwiftData

struct BibliotecaView: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@Binding var path: [Caminhos]
	@FocusState private var estaFocado: FocusKey?
	@State var texto: String = ""
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
	@State var clicaBloco = false
	
	var body: some View {
		ZStack(alignment: .topLeading){
			Image("Biblioteca")
				.resizable()
				.scaleEffect((dialogos[contexto.idDialogo].personagem == "Edgar" && !clicaBloco) ? 0.93 : 1.0)
			//.aspectRatio(16 / 10, contentMode: .fit)
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			
			if (!clicaBloco) {
				if (contexto.idDialogo != 15) {
					FalaView(path: $path, contexto: contexto, bloco: bloco, falaNome: defineFalaNome())
					
					AtributosView(contexto: contexto)
						.offset(x: (dialogos[contexto.idDialogo].personagem == "Edgar") ? 65: 0, y: (dialogos[contexto.idDialogo].personagem == "Edgar") ? 38 : 0)
					BotaoSair(contexto: contexto, path: $path, clicaBloco: $clicaBloco)
						.offset(x: (dialogos[contexto.idDialogo].personagem == "Edgar") ? -65: 0, y: (dialogos[contexto.idDialogo].personagem == "Edgar") ? 38 : 0)
				}
				else {
					BlocoView(path: $path, bloco: bloco, clicaNotas: $clicaBloco)
					//.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
				}
				
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
						contexto.horario = "noite"
						contexto.local = .quarto
						contexto.parteDialogo = 0
						path.append(.quarto)
					}
				}
				.onAppear {
					withAnimation { fadeIn = true }
				}
		}
		
		func defineFalaNome() -> Binding<Bool> {
			if (dialogos[contexto.idDialogo].personagem == "Edgar" || dialogos[contexto.idDialogo].personagem == "You") {
				falaNome = true
			} else {
				falaNome = false
			}
			return $falaNome
		}
		
	}
	
