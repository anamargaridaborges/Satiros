//
//  MuralWidget.swift
//  MuralWidget
//
//  Created by Jordana Lourenço Santos on 04/09/25.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
			SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), imageName: "mural0")
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, imageName: carregarImagem())
    }
    
//    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
//        var entries: [SimpleEntry] = []
//				let currentDate = Date()
//
//        for hourOffset in 0 ..< 4 {
//					let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//
//        return Timeline(entries: entries, policy: .atEnd)
//    }
	
			func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
					let entry = SimpleEntry(date: Date(), configuration: configuration, imageName: carregarImagem())
					
					return Timeline(entries: [entry], policy: .atEnd)
			}
	
			private func carregarImagem() -> String {
					let defaults = UserDefaults(suiteName: "group.satiros.Satiros.MuralWidget")
					return defaults?.string(forKey: "widgetImage") ?? "mural0"
			}

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
	let imageName: String
}

struct MuralWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
			Image(entry.imageName)
			.resizable()
			.scaledToFill()
			.clipped()
    }
}

struct MuralWidget: Widget {
    let kind: String = "MuralWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            MuralWidgetEntryView(entry: entry)
                .containerBackground(.clear, for: .widget)
        }
				.supportedFamilies([.systemLarge])
    }
}
