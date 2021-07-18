//
//  EpisodeDetailsViewModel.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import Combine
import RickMortySwiftApi
import SwiftUI

/// Observable view model class for episode details screen
class EpisodeDetailsViewModel: ObservableObject, Identifiable {

    private let item: RMEpisodeModel
    private let fetcher: RMFetchable
    private var disposables = Set<AnyCancellable>()

    var name: String {
        item.name
    }

    var airDate: String {
        item.airDate
    }

    var code: String {
        item.episode
    }

    var created: String {
        item.created
    }

    init(fetcher: RMFetchable, episode: RMEpisodeModel) {
        self.fetcher = fetcher
        item = episode
    }
}
