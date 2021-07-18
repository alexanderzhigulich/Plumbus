//
//  CharacterDetailsViewModel.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import Combine
import Kingfisher
import RickMortySwiftApi
import SwiftUI

/// Observable view model class for character details screen
class CharacterDetailsViewModel: ObservableObject, Identifiable {

    private let fetcher: RMFetchable
    private let item: RMCharacterModel

    var name: String {
        item.name
    }

    var status: String {
        if item.isAlive {
            return L10n.Characters.Details.Status.alive
        } else if item.isDead {
            return L10n.Characters.Details.Status.deceased
        }
        return L10n.Characters.Details.Status.unknown
    }

    var species: String {
        item.species
    }

    var type: String {
        item.type
    }

    var gender: String {
        item.gender
    }

    var image: URL? {
        URL(string: item.image)
    }

    var imageModifier: ImageModifier {
        item.isDead ? BWModifier() : VoidModifier()
    }

    var stampImage: UIImage {
        switch item.id % 3 {
        case 0:
            return Asset.approved.image
        case 1:
            return Asset.classified.image
        default:
            return Asset.topSecret.image
        }
    }

    var originLocationName: String {
        item.origin.name
    }

    var lastseenLocationName: String {
        item.location.name
    }

    init(fetcher: RMFetchable, item: RMCharacterModel) {
        self.fetcher = fetcher
        self.item = item
    }
}

extension CharacterDetailsViewModel {

    var originLocationView: some View {
        let viewModel = LocationViewModel(
            fetcher: fetcher,
            name: item.origin.name,
            url: item.origin.url
        )
        return LocationView(viewModel: viewModel)
    }

    var lastseenLocationView: some View {
        let viewModel = LocationViewModel(
            fetcher: fetcher,
            name: item.location.name,
            url: item.location.url
        )
        return LocationView(viewModel: viewModel)
    }
}
