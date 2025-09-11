//
//  AppIntent.swift
//  MuralWidget
//
//  Created by Jordana Lourenço Santos on 04/09/25.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is an example widget." }

//    // An example configurable parameter.
			//Nao adicionar o @Parameter significa que o app intent é estatico
//    @Parameter(title: "Favorite Emoji", default: "😃")
//    var favoriteEmoji: String
}
