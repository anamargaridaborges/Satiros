//
//  ContextoConfessionario.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 27/08/25.
//

import Foundation
import SwiftData

//typealias ContextoConfessionario = ContextoConfessionario2.ContextoConfessionario
//typealias ContextoSalvo = ContextoConfessionario2.ContextoSalvo

enum ContextoConfessionario1: VersionedSchema {
		static var versionIdentifier = Schema.Version(1, 0, 0)

		static var models: [any PersistentModel.Type] {
			[ContextoConfessionario.self, ContextoSalvo.self]
		}

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
	
	@Model
	class ContextoSalvo: Identifiable {
			var idDialogo: Int?
			var local: String?
			var dia: Int
			var horario: String
			var popularidade: Int
			var desconfianca: Int
			init(idDialogo: Int? = 15, local: String? = "confessionario", dia: Int = 1, horario: String = "confissao1", popularidade: Int = 5, desconfianca: Int = 5) {
				self.idDialogo = idDialogo
				self.local = local
				self.dia = dia
				self.horario = horario
				self.popularidade = popularidade
				self.desconfianca = desconfianca
			}
		}
}

enum ContextoConfessionario2: VersionedSchema {
		static var versionIdentifier = Schema.Version(2, 0, 0)

		static var models: [any PersistentModel.Type] {
			[ContextoConfessionario.self, ContextoSalvo.self]
		}

		@Model
		class ContextoConfessionario: Identifiable {
			var momentoAdicionado: Int
			var personagem: String
			var dialogo: String
			init(personagem: String, dialogo: String, momentoAdicionado: Int) {
				self.momentoAdicionado = momentoAdicionado
				self.personagem = personagem
				self.dialogo = dialogo
			}
		}
	
	@Model
	class ContextoSalvo: Identifiable {
			var idDialogo: Int
			var local: String
			var dia: Int
			var horario: String
			var popularidade: Int
			var desconfianca: Int
			var parteDialogo: Int
			init(idDialogo: Int = 15, local: String = "confessionario", dia: Int = 1, horario: String = "confissao1", popularidade: Int = 5, desconfianca: Int = 5, parteDialogo: Int = 0) {
				self.idDialogo = idDialogo
				self.local = local
				self.dia = dia
				self.horario = horario
				self.popularidade = popularidade
				self.desconfianca = desconfianca
				self.parteDialogo = parteDialogo
			}
		}
}

enum ConfessionarioMigracao: SchemaMigrationPlan {
	static var schemas: [any VersionedSchema.Type] {
			[ContextoConfessionario1.self, ContextoConfessionario2.self]
	}
	
	static let migracao1pro2 = MigrationStage.custom(
			fromVersion: ContextoConfessionario1.self,
			toVersion: ContextoConfessionario2.self,
			willMigrate: { context in
					let dialogos = try context.fetch(FetchDescriptor<ContextoConfessionario1.ContextoConfessionario>())
					let contexto = try context.fetch(FetchDescriptor<ContextoConfessionario1.ContextoSalvo>())
					var tempo: Int = 0
					for dialogo in dialogos {
						context.delete(dialogo)
						context.insert(ContextoConfessionario2.ContextoConfessionario(personagem: dialogo.personagem, dialogo: dialogo.dialogo, momentoAdicionado: tempo))
						tempo += 1
					}
				for cont in contexto {
					context.delete(cont)
					context.insert(ContextoConfessionario2.ContextoSalvo(idDialogo: (cont.idDialogo ?? 23), local: (cont.local ?? "confessionario"), dia: cont.dia, horario: cont.horario, popularidade: cont.popularidade, desconfianca: cont.desconfianca, parteDialogo: 0))
				}
				try context.save()
			}, didMigrate: nil
	)
	
	static var stages: [MigrationStage] {
			[migracao1pro2]
	}
	
}
