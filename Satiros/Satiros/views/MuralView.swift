//
//  MuralView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 11/09/25.
//

import SwiftUI

struct MuralView: View {
    var body: some View {
			ZStack {
				Image("fundoMural")
					.aspectRatio(contentMode: .fit)
					.scaleEffect(0.79)
				VStack {
					HStack {
						Spacer()
						Image("LorganPolaroid")
							.scaleEffect(0.6)
							.padding()
						Image("EdgarPolaroid")
							.scaleEffect(0.6)
							.padding()
						Spacer()
					}
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    MuralView()
}
