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
			VStack {
				Text("Options")
					.font(.appFont(selectedFont, size: 60))
					.padding()
				Button(action: { if selectedFont == "SFPro" {
					selectedFont = "VT323"
				}
					else {
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
					.padding()
			}
			//.navigationBarBackButtonHidden()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    //OptionsView()
}
