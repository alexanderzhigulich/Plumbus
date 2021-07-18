//
//  CharactersViewBuilder.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import RickMortySwiftApi
import SwiftUI

/// Helper router class that creates views that can be navigate to from characters screens
enum CharactersViewBuilder {

    /// Makes character details view
    /// - parameters:
    ///     - fetcher: RMFetchable implementation
    ///     - character: character model to be presented
    /// - returns: character details view
    static func makeCharacterDetailsView(
        fetcher: RMFetchable,
        character: RMCharacterModel
    ) -> some View {
        let viewModel = CharacterDetailsViewModel(fetcher: fetcher, item: character)
        return CharacterDetailsView(viewModel: viewModel)
    }
}
