//
//  ContextoConfessionario.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 27/08/25.
//

import Foundation
import SwiftData

@Model
class ContextoConfessionario: Identifiable {
	var id: UUID
	var personagem: String
	var dialogo: String
	init(personagem: String, dialogo: String) {
		self.id = UUID()
		self.personagem = personagem
		self.dialogo = dialogo
	}
}
