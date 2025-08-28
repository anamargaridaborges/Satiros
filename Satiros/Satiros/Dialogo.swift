//
//  Dialogo.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import Foundation

struct Dialogo: Decodable {
	var id: Int
	var personagem: String
	var texto: [String]
	var opcoes: [String]
	var id_que_opcao_leva: [Int]
	var impacto_opcao_pop: [Int]
	var impacto_opcao_desc: [Int]
	var local_fundo: String
	var resumo_notas: String
}
