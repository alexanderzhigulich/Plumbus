//
//  RMFetchable.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import Combine
import RickMortySwiftApi

/// Interface to wrap fetching data over RickMortySwiftApi API
protocol RMFetchable {

    /// Fetches all episodes and filters by name
    /// - parameters:
    ///     - name: pattern to filter results
    /// - returns: erased and not completed publisher
    func allEpisodes(forName name: String) -> AnyPublisher<[RMEpisodeModel], Error>

    /// Fetches all characters for episode and filters by name
    /// - parameters:
    ///     - episode: episode for which charactes will be requested
    ///     - name: pattern to filter results
    /// - returns: erased and not completed publisher
    func allCharacters(
        forEpisode episode: RMEpisodeModel,
        andName name: String
    ) -> AnyPublisher<[RMCharacterModel], Error>

    func location(byUrl url: String) -> AnyPublisher<RMLocationModel, Error>
}
