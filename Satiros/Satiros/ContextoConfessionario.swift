//
//  ContextoConfessionario.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 27/08/25.
//

import Foundation
import SwiftData

@Model
class ContextoConfessionario {
	var personagem: String
	var dialogo: String
	init(personagem: String, dialogo: String) {
		self.personagem = personagem
		self.dialogo = dialogo
	}
}
