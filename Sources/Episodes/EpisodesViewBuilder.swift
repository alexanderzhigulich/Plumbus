//
//  EpisodesViewBuilder.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import RickMortySwiftApi
import SwiftUI

/// Helper router class that creates views that can be navigate to from episodes screens
enum EpisodesViewBuilder {

    /// Makes episode details view
    /// - parameters:
    ///     - fetcher: RMFetchable implementation
    ///     - episode: episode model to be presented
    /// - returns: episode details view
    static func makeEpisodeDetailsView(
        fetcher: RMFetchable,
        episode: RMEpisodeModel
    ) -> some View {
        let viewModel = EpisodeDetailsViewModel(fetcher: fetcher, episode: episode)
        return EpisodeDetailsView(viewModel: viewModel)
    }

    /// Makes characters list view
    /// - parameters:
    ///     - fetcher: RMFetchable implementation
    ///     - episode: episode model to be presented
    ///     - showingModal: binding to control over modal presentation
    /// - returns: characters list view
    static func makeCharactersView(
        fetcher: RMFetchable,
        episode: RMEpisodeModel,
        showingModal: Binding<Bool>
    ) -> some View {
        let viewModel = CharactersViewModel(fetcher: fetcher, episode: episode)
        return CharactersView(viewModel: viewModel, showingModal: showingModal)
    }
}
