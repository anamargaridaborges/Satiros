//
//  AssociaIdContexto.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 25/08/25.
//

import Foundation

func retornaID (dia: Int, horario: String, local: String) -> Int {
	if (dia == 1 && horario == "confissao1" && local == "confessionario") {
		return 15
	}
	else if (dia == 1 && horario == "confissao2" && local == "confessionario") {
		return 13
	}
	else if (dia == 1 && horario == "manha" && local == "tutorial") {
		return 0
	}
	else {
		return -1
	}
}
