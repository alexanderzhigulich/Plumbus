//
//  LocationViewModel.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 19.07.21.
//

import Combine
import Foundation
import RickMortySwiftApi

/// Observable view model class for location details screen
class LocationViewModel: ObservableObject {

    private(set) var name: String
    private let url: String
    private let fetcher: RMFetchable

    private var disposables = Set<AnyCancellable>()

    @Published var type: String = ""
    @Published var dimension: String = ""
    @Published var created: String = ""

    init(fetcher: RMFetchable, name: String, url: String) {
        self.fetcher = fetcher
        self.name = name
        self.url = url
    }

    /// Completes main publisher
    func sink() {
        fetcher.location(byUrl: url)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.type = ""
                        self.dimension = ""
                        self.created = ""
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] location in
                    guard let self = self else { return }
                    self.type = location.type
                    self.dimension = location.dimension
                    self.created = location.created
                }
            )
            .store(in: &disposables)
    }
}
