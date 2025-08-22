//
//  RecuperaContexto.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 20/08/25.
//

import SwiftUI
import SwiftData

struct RecuperaContexto: View {
	
	@Environment(\.modelContext) private var modelContext
	@Query var contexto: [ContextoSalvo]
	
    var body: some View {
        
			
			
    }
}

#Preview {
    RecuperaContexto()
}
