//
//  RecipeModel.swift
//  FetchMobileTakeHomeProject
//
//  Created by Ricardo Garza on 2/12/25.
//

import SwiftUI

struct RecipeModel: Hashable, Codable {
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let uuid: String
    let youtubeUrl: String?
}

struct RecipeResponse: Codable {
    let recipes: [RecipeModel]
}

