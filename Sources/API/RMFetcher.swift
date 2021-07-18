//
//  RMFetcher.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import Combine
import Foundation
import RickMortySwiftApi

/// Default RMFetchable implementation
class RMFetcher: RMFetchable {

    private let client: RMClient
    private var allEpisodesCache: [RMEpisodeModel]?
    private var allCharactersCache: [RMCharacterModel] = []
    private var allLocationsCache: [String: RMLocationModel] = [:]

    init(client: RMClient) {
        self.client = client
    }

    // MARK: - Public API

    func allEpisodes(forName name: String) -> AnyPublisher<[RMEpisodeModel], Error> {
        allEpisodesOrCache
            .map {
                $0.filter {
                    $0.name.components(separatedBy: .symbols).contains { $0.starts(with: name) }
                }
            }
            .eraseToAnyPublisher()
    }

    func allCharacters(
        forEpisode episode: RMEpisodeModel,
        andName name: String
    ) -> AnyPublisher<[RMCharacterModel], Error> {
        allCharactersOrCache(byIds: episode.charactersIds)
            .map {
                $0.filter {
                    $0.name.components(separatedBy: .symbols).contains { $0.starts(with: name) }
                }
            }
            .eraseToAnyPublisher()
    }

    func location(byUrl url: String) -> AnyPublisher<RMLocationModel, Error> {
        if let inCache = allLocationsCache[url] {
            return Just(inCache)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        return client.location().getLocationByURL(url: url).eraseToAnyPublisher()
    }

    // MARK: - Private methods

    private var allEpisodesOrCache: AnyPublisher<[RMEpisodeModel], Error> {
        guard let cache = allEpisodesCache else {
            return client.episode().getAllEpisodes()
                .map { [weak self] episodes in
                    self?.allEpisodesCache = episodes
                    return episodes
                }
                .eraseToAnyPublisher()
        }
        return Just(cache)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    private func allCharactersOrCache(byIds ids: [Int]) -> AnyPublisher<[RMCharacterModel], Error> {
        let cachedCharacters = allCharactersCache.filter { ids.contains(Int($0.id)) }
        let cachedIds = cachedCharacters.map { Int($0.id) }
        let idsToFetch = ids.filter { !cachedIds.contains($0) }
        if idsToFetch.isEmpty {
            return Just(cachedCharacters)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return client.character().getCharactersByID(ids: idsToFetch)
                .map {
                    let result = cachedCharacters + $0
                    return result.sorted { $0.id < $1.id }
                }
                .eraseToAnyPublisher()
        }
    }
}

private extension RMEpisodeModel {

    var charactersIds: [Int] {
        characters.compactMap {
            guard let url = URL(string: $0) else { return nil }
            return Int(url.lastPathComponent)
        }
    }
}
