//
//  RMCharacterModel+Convenience.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 17.07.21.
//

import RickMortySwiftApi

extension RMCharacterModel {

    public var isDead: Bool {
        status.compare("dead", options: .caseInsensitive) == .orderedSame
    }

    public var isAlive: Bool {
        status.compare("alive", options: .caseInsensitive) == .orderedSame
    }

    public var isAlien: Bool {
        species.compare("human", options: .caseInsensitive) != .orderedSame
    }
}
