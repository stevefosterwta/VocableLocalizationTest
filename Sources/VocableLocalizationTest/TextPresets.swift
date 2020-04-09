//
//  TextPresets.swift
//  VocaableLocalizationTest
//
//  Created by Steve Foster on 4/09/20.
//  Copyright © 2020 WillowTree. All rights reserved.
//

import Foundation

// Top level JSON object
public struct PresetData: Codable {

    let schemaVersion: Int
    public let categories: [PresetCategory]
    public let phrases: [PresetPhrase]

}

public struct PresetCategory: Codable {

    public let id: String
    public let localizedName: [String: String]
    public let hidden: Bool

}

public struct PresetPhrase: Codable {

    public let id: String
    public let categoryIds: [String]
    public let localizedUtterance: [String: String]

}

public struct TextPresets {

    public static let savedSayingsIdentifier = "preset_user_favorites"
//    public static let numPadIdentifier = "preset_user_keypad"

    public static var presets: PresetData? {
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

        if let path = Bundle.main.path(forResource: "../textpresets", ofType: "json") {
            do {
                return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            } catch {
                assertionFailure("🚨 Cannot parse \(path)")
                return nil
            }
        }

        assertionFailure("Missing data")
        return nil
    }

}
