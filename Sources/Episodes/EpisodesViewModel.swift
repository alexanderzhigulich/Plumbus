//
//  EpisodesViewModel.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import Combine
import RickMortySwiftApi
import SwiftUI

/// Observable view model class for episodes view screen
class EpisodesViewModel: ObservableObject {

    /// Published to bind with search field
    @Published var name: String = ""

    /// Published to bind with list
    @Published var episodes: [EpisodeRowViewModel] = []

    private let fetcher: RMFetchable
    private var publisher: AnyPublisher<String, Never>?
    private var disposables = Set<AnyCancellable>()

    init(fetcher: RMFetchable) {
        self.fetcher = fetcher

        publisher = $name
            // .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue(label: "EpisodesViewModel"))
            .eraseToAnyPublisher()
    }

    /// Completes main publisher
    func sink() {
        publisher?
            .sink(receiveValue: fetchEpisodes(forName:))
            .store(in: &disposables)
    }

    private func fetchEpisodes(forName name: String) {
        fetcher.allEpisodes(forName: name)
            .map { [weak self] response -> [EpisodeRowViewModel] in
                guard let self = self else { return [EpisodeRowViewModel]() }
                return response.map { EpisodeRowViewModel(fetcher: self.fetcher, item: $0) }
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.episodes = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] episodes in
                    guard let self = self else { return }
                    self.episodes = episodes
                }
            )
            .store(in: &disposables)
    }
}

extension EpisodesViewModel {

    /// Builds episode details view
    /// - parameters:
    ///     - episode: episode for which to build view
    /// - returns: episode details view
    func episodeDetailsView(for episode: RMEpisodeModel) -> some View {
        EpisodesViewBuilder.makeEpisodeDetailsView(fetcher: fetcher, episode: episode)
    }
}
