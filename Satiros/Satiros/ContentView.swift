//
//  ContentView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 19/08/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
		@AppStorage("selectedFont") private var selectedFont: String = "VT323"

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
						.font(.appFont(size: 20))
        }
			
			
			VStack { //teste escolha fonte
								 Text("Exemplo de Fonte no macOS")
										 .font(.appFont(size: 20))

								 Picker("Fonte", selection: $selectedFont) {
										 Text("VT323").tag("VT323")
										 Text("SF Pro").tag("SFPro")
								 }
								 .pickerStyle(.radioGroup) // Mais natural no macOS
								 .padding()
						 }
						 .frame(width: 300, height: 150)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

extension Font {
		static func appFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
				let selectedFont = UserDefaults.standard.string(forKey: "selectedFont") ?? "VT323"

				switch selectedFont {
				case "SFPro":
						return .system(size: size, weight: weight)
				default:
						return .custom("VT323-Regular", size: size)
				}
		}
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
