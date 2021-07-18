//
//  CharactersViewModel.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import Combine
import RickMortySwiftApi
import SwiftUI

/// Observable view model class for characters view screen
class CharactersViewModel: ObservableObject {

    /// Published to bind with search field
    @Published var name: String = ""

    /// Published to bind with list
    @Published var characters: [CharacterRowViewModel] = []

    private let fetcher: RMFetchable
    private let episode: RMEpisodeModel
    private var disposables = Set<AnyCancellable>()
    private var publisher: AnyPublisher<String, Never>?

    init(
        fetcher: RMFetchable,
        episode: RMEpisodeModel
    ) {
        self.fetcher = fetcher
        self.episode = episode

        publisher = $name
            // .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue(label: "CharactersViewModel"))
            .eraseToAnyPublisher()
    }

    /// Completes main publisher
    func sink() {
        publisher?
            .sink(receiveValue: fetchCharacters(forName:))
            .store(in: &disposables)
    }

    private func fetchCharacters(forName name: String) {
        fetcher.allCharacters(forEpisode: episode, andName: name)
            .map { response in
                response.map(CharacterRowViewModel.init)
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.characters = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] characters in
                    guard let self = self else { return }
                    self.characters = characters
                }
            )
            .store(in: &disposables)
    }
}

extension CharactersViewModel {

    /// Builds character details view
    /// - parameters:
    ///     - character: character for which to build view
    /// - returns: character details view
    func characterDetailsView(for character: RMCharacterModel) -> some View {
        CharactersViewBuilder.makeCharacterDetailsView(fetcher: fetcher, character: character)
    }
}
