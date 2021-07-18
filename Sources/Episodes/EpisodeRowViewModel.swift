//
//  EpisodeRowViewModel.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import RickMortySwiftApi
import SwiftUI

struct EpisodeRowViewModel: Identifiable {

    private let fetcher: RMFetchable
    private(set) var item: RMEpisodeModel

    var id: String {
        "\(item.id)"
    }

    var name: String {
        item.name
    }

    var code: String {
        item.episode
    }

    var airDate: String {
        item.airDate
    }

    var created: String {
        item.created
    }

    init(fetcher: RMFetchable, item: RMEpisodeModel) {
        self.fetcher = fetcher
        self.item = item
    }
}

extension EpisodeRowViewModel {

    /// Builds characters view
    /// - parameters:
    ///     - showingModal: binding to control over modal view lifecycle (dismiss)
    /// - returns: characters view
    func charactersView(showingModal: Binding<Bool>) -> some View {
        EpisodesViewBuilder.makeCharactersView(fetcher: fetcher, episode: item, showingModal: showingModal)
    }
}

extension EpisodeRowViewModel: Hashable {

    static func == (lhs: EpisodeRowViewModel, rhs: EpisodeRowViewModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
