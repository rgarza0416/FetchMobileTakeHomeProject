//
//  RecipeView.swift
//  FetchMobileTakeHomeProject
//
//  Created by Ricardo Garza on 2/12/25.
//

import SwiftUI


struct RecipesView: View {
    
    @StateObject var viewModel = RecipesViewModel()
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading Recipes...")
                } else if viewModel.isEmptyState {
                    VStack {
                        Image(systemName: "tray.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .foregroundColor(.gray)
                        Text("No recipes available.")
                            .foregroundColor(.gray)
                            .padding()
                    }
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                        Button("Retry") {
                            Task {
                                await viewModel.refreshRecipes()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.recipes, id: \.self) { item in
                                NavigationLink {
                                    DetailView(nameOfDish: item.name, cuisineType: item.cuisine, imageUrl: item.photoUrlLarge, recipeLink: item.sourceUrl, youtubeLink: item.youtubeUrl)
                                } label: {
                                    RecipeItemView(recipe: item.uuid, nameOfRecipe: item.name, cuisineType: item.cuisine, imageUrl: item.photoUrlSmall)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .refreshable {
                await viewModel.refreshRecipes()
            }
            .navigationTitle(Text("Recipes"))
        }
    }
}

#Preview {
    RecipesView()
}
