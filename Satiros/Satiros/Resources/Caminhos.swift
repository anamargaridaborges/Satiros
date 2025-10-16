//
//  Caminhos.swift
//  Satiros
//
//  Created by Jordana Lourenço Santos on 15/09/25.
//

import Foundation
import SwiftUI

enum Caminhos: String, Hashable, Codable, RawRepresentable {
	case novoJogo
	case tutorial
	case confessionario
	case confirmarSair
	case options
	case cartas
	case menu
	case popUpIntro
	case popUpMapa
	case mapa
	case falaIntro
	case jardim
	case quarto
	case biblioteca
	case mural
	case fimDia1
	case creditos
}

extension Caminhos {
	@ViewBuilder
	func view(
		contexto: [ContextoConfessionario3.ContextoSalvo],
		path: Binding<[Caminhos]>,
		bloco: [ContextoConfessionario3.Bloco],
		_estaFocado: FocusState<FocusKey?>,
		clicaNotas: Binding<Bool>
	) -> some View {
		switch self {
			case .novoJogo:
					ConfirmarNovoJogo(contexto: contexto[0], path: path, bloco: bloco[0])

			case .tutorial:
					TutorialView(contexto: contexto[0], path: path, bloco: bloco[0])

			case .confessionario:
					ConfessionarioView(contexto: contexto[0], path: path, estaFocado: _estaFocado, bloco: bloco[0], clicaNotas: clicaNotas)

			case .confirmarSair:
					ConfirmarSair(path: path)

			case .options:
					OptionsView(path: path)

			case .cartas:
					CartasView(contexto: contexto[0], path: path, clicaBloco: clicaNotas, bloco: bloco[0])

			case .menu:
					IntroducaoView()

			case .popUpIntro:
					PopUpIntro(contexto: contexto[0], path: path, bloco: bloco[0], estaFocado: _estaFocado)

			case .popUpMapa:
					PopUpMapa(contexto: contexto[0], path: path, bloco: bloco[0], estaFocado: _estaFocado)

			case .mapa:
					MapaView(contexto: contexto[0], path: path, bloco: bloco[0])

			case .falaIntro:
					FalaIntroView(contexto: contexto[0], path: path)

			case .jardim:
					JardimView(contexto: contexto[0], path: path, bloco: bloco[0])

			case .quarto:
					QuartoView(contexto: contexto[0], path: path, bloco: bloco[0])

			case .biblioteca:
					BibliotecaView(contexto: contexto[0], path: path, bloco: bloco[0])

			case .mural:
					MuralView(path: path)

			case .fimDia1:
			FimDia1(contexto: contexto[0], path: path)
			
		case .creditos:
			CreditosView(path: path)
		}
	}
}
