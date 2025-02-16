//
//  DataFetch.swift
//  FetchMobileTakeHomeProjectTests
//
//  Created by Ricardo Garza on 2/13/25.
//

import XCTest
@testable import FetchMobileTakeHomeProject


final class RecipeAPITests: XCTestCase {
    
    func testFetchRecipe_Success() async throws {
        let viewModel = await RecipesViewModel()
        
        do {
            let recipes = try await viewModel.fetchRecipe()
            XCTAssertFalse(recipes.isEmpty, "Fetched recipes should not be empty")
        } catch {
            XCTFail("Fetching recipes failed with error: \(error)")
        }
    }
}


