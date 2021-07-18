//
//  CharacterRowViewModel.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import Kingfisher
import RickMortySwiftApi
import SwiftUI
import UIKit

/// View model class for character row on characters view screen
struct CharacterRowViewModel: Identifiable {

    private(set) var item: RMCharacterModel

    var id: String {
        "\(item.id)"
    }

    var name: String {
        item.name
    }

    var image: URL? {
        URL(string: item.image)
    }

    var imageModifier: ImageModifier {
        item.isDead ? BWModifier() : VoidModifier()
    }

    var dead: UIImage? {
        item.isDead ? Asset.dead.image : nil
    }

    var alien: UIImage? {
        item.isAlien ? Asset.alien.image : nil
    }

    init(item: RMCharacterModel) {
        self.item = item
    }
}

extension CharacterRowViewModel: Hashable {

    static func == (lhs: CharacterRowViewModel, rhs: CharacterRowViewModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
