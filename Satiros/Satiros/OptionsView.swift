//
//  OptionsView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI

struct OptionsView: View {
	
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@State var defaults = UserDefaults.standard
	@Binding var path: [String]
	
    var body: some View {
			ZStack{
				Image("fundo pixel")
						.resizable()
						.clipped()
						.aspectRatio(16/10, contentMode: .fill)
				
				VStack {
					HStack {
						Button(action: {path.removeLast()}) {
							Image(systemName: "chevron.left")
								.font(.title)
								.fontWeight(.bold)
								.foregroundColor(.white)
						}
						.buttonStyle(.plain)
						.padding()
						Spacer()
					}
					.padding(.top, 8)
					.padding(.leading, 12)
					
					Spacer()
					Text("Options")
						.font(.appFont(selectedFont, size: 60))
						.padding(20)
					Button(action: {if selectedFont == "SFPro" {
						selectedFont = "VT323"
					} else{
							selectedFont = "SFPro"
						};
						defaults.set(selectedFont, forKey: "selectedFont")}) {
						HStack {
							Text("Font")
								.font(.appFont(selectedFont,size: 30))
								.padding()
							Spacer()
							Text((selectedFont == "SFPro" ? "Smooth" : "Squared"))
								.font(.appFont(selectedFont,size: 30))
								.padding()
						}
					}
					.padding(20)
					Spacer()
				}
				.navigationBarBackButtonHidden()
				//.frame(maxWidth: .infinity, maxHeight: .infinity)
			}
			
    }
}

#Preview {
    //OptionsView()
}
