//
//  ContextoSalvo.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 19/08/25.
//

import Foundation
import SwiftData

@Model
class ContextoSalvo {
	var idDialogo: Int?
	var local: String?
	var dia: Int
	var horario: String
	var popularidade: Int
	var desconfianca: Int
	init(idDialogo: Int? = 0, local: String? = "tutorial", dia: Int = 1, horario: String = "manha", popularidade: Int = 5, desconfianca: Int = 5) {
		self.idDialogo = idDialogo
		self.local = local
		self.dia = dia
		self.horario = horario
		self.popularidade = popularidade
		self.desconfianca = desconfianca
	}
}
