//
//  TextPresets.swift
//  VocaableLocalizationTest
//
//  Created by Steve Foster on 4/09/20.
//  Copyright © 2020 WillowTree. All rights reserved.
//


import Foundation
import VocableLocalizationTest

// Top level JSON object
struct PresetData: Codable {

    let schemaVersion: Int
    let categories: [PresetCategory]
    let phrases: [PresetPhrase]

}

public struct PresetCategory: Codable {

    let id: String
    let localizedName: [String: String]
    let hidden: Bool

}

public struct PresetPhrase: Codable {

    let id: String
    let categoryIds: [String]
    let localizedUtterance: [String: String]

}

public struct TextPresets {

    static let savedSayingsIdentifier = "preset_user_favorites"
    static let numPadIdentifier = "preset_user_keypad"

    static var numPadPhrases: [PhraseViewModel] {
        var numbers = (1...9).map { PhraseViewModel(unpersistedPhrase: "\($0)")}
        numbers.append(PhraseViewModel(unpersistedPhrase: "0"))
        let responses = [PhraseViewModel(unpersistedPhrase: NSLocalizedString("No", comment: "'No' num pad response")),
                         PhraseViewModel(unpersistedPhrase: NSLocalizedString("Yes", comment: "'Yes' num pad response"))]
        return numbers + responses
    }

    static var presets: PresetData? {
        if let json = dataFromBundle() {
            do {
                return try JSONDecoder().decode(PresetData.self, from: json)
            } catch {
                assertionFailure("Error decoding PresetData: \(error)")
            }
        }

        return nil
    }

    private static func dataFromBundle() -> Data? {

        if let path = Bundle.main.path(forResource: "textpresets", ofType: "json") {
            print("PATH: \(path)")

            do {
                return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            } catch {
                assertionFailure("🚨 Cannot parse \(path)")
                return nil
            }
        }

        return nil
    }

}
