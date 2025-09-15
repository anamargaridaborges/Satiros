//
//  MuralView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 11/09/25.
//

import SwiftUI

struct MuralView: View {
	
	@State var passaNaFoto: [Bool] = [false, false, false, false, false, false, false]
	@State var clicaFoto: [Bool] = [false, false, false, false, false, false, false]
	@Binding var path: [Caminhos]
	
    var body: some View {
			GeometryReader { geometry in
				ZStack {
					Image("fundoMural")
						.resizable()
						.scaledToFit()
						.frame(width: geometry.size.width, height: geometry.size.height)
						.clipped()
					Button (action: {clicaFoto[0] = true}) {
						Image("BenedictPolaroid")
							.resizable()
							.scaledToFit()
							.frame(width: geometry.size.width * 0.1)
							//.contentShape(Rectangle())
							.onHover {over in
								passaNaFoto[0] = over
							}
					}
					.scaleEffect(passaNaFoto[0] ? 1.1 : 1)
					.buttonStyle(.plain)
					.offset(x: -geometry.size.width * 0.15, y: -geometry.size.height * 0.3)
					Button (action: {clicaFoto[1] = true}) {
						Image("LorganPolaroid")
							.resizable()
							.scaledToFit()
							.frame(width: geometry.size.width * 0.1)
							//.contentShape(Rectangle())
							.onHover {over in
								passaNaFoto[1] = over
							}
					}
					.scaleEffect(passaNaFoto[1] ? 1.1 : 1)
					.buttonStyle(.plain)
					.offset(x: geometry.size.width * 0.15, y: -geometry.size.height * 0.3)
					Button (action: {clicaFoto[2] = true}) {
						Image("DesmondPolaroid")
							.resizable()
							.scaledToFit()
							.frame(width: geometry.size.width * 0.1)
							//.contentShape(Rectangle())
							.onHover {over in
								passaNaFoto[2] = over
							}
					}
					.scaleEffect(passaNaFoto[2] ? 1.1 : 1)
					.buttonStyle(.plain)
					.offset(x: -geometry.size.width * 0.3, y: 0)
					Button (action: {clicaFoto[3] = true}) {
						Image("StephanoPolaroid")
							.resizable()
							.scaledToFit()
							.frame(width: geometry.size.width * 0.1)
							//.contentShape(Rectangle())
							.onHover {over in
								passaNaFoto[3] = over
							}
					}
					.scaleEffect(passaNaFoto[3] ? 1.1 : 1)
					.buttonStyle(.plain)
					.offset(x: 0, y:0)
					Button (action: {clicaFoto[4] = true}) {
						Image("ThomasPolaroid")
							.resizable()
							.scaledToFit()
							.frame(width: geometry.size.width * 0.1)
							//.contentShape(Rectangle())
							.onHover {over in
								passaNaFoto[4] = over
							}
					}
					.scaleEffect(passaNaFoto[4] ? 1.1 : 1)
					.buttonStyle(.plain)
					.offset(x: geometry.size.width * 0.3, y: 0)
					Button (action: {clicaFoto[5] = true}) {
						Image("SamuelPolaroid")
							.resizable()
							.scaledToFit()
							.frame(width: geometry.size.width * 0.1)
							//.contentShape(Rectangle())
							.onHover {over in
								passaNaFoto[5] = over
							}
					}
					.scaleEffect(passaNaFoto[5] ? 1.1 : 1)
					.buttonStyle(.plain)
					.offset(x: -geometry.size.width * 0.15, y: geometry.size.height * 0.3)
					Button (action: {clicaFoto[6] = true}) {
						Image("EdgarPolaroid")
							.resizable()
							.scaledToFit()
							.frame(width: geometry.size.width * 0.1)
							//.contentShape(Rectangle())
							.onHover {over in
								passaNaFoto[6] = over
							}
					}
					.scaleEffect(passaNaFoto[6] ? 1.1 : 1)
					.buttonStyle(.plain)
					.offset(x: geometry.size.width * 0.15, y: geometry.size.height * 0.3)
					if (clicaFoto[0]) {
						SuspeitoView(suspeito: "Benedict", clicaFoto: $clicaFoto[0], path: $path)
					}
					if (clicaFoto[1]) {
						SuspeitoView(suspeito: "Fr. Lorgan", clicaFoto: $clicaFoto[1], path: $path)
					}
					if (clicaFoto[2]) {
						SuspeitoView(suspeito: "S. Desmond", clicaFoto: $clicaFoto[2], path: $path)
					}
					if (clicaFoto[3]) {
						SuspeitoView(suspeito: "Steffano", clicaFoto: $clicaFoto[3], path: $path)
					}
					if (clicaFoto[4]) {
						SuspeitoView(suspeito: "Thomas", clicaFoto: $clicaFoto[4], path: $path)
					}
					if (clicaFoto[5]) {
						SuspeitoView(suspeito: "Samuel", clicaFoto: $clicaFoto[5], path: $path)
					}
					if (clicaFoto[6]) {
						SuspeitoView(suspeito: "Edgar", clicaFoto: $clicaFoto[6], path: $path)
					}
						}
					}
				}
			}

#Preview {
    //MuralView()
}
