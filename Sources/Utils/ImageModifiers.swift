//
//  ImageModifiers.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 17.07.21.
//

import Kingfisher

class BWModifier: ImageModifier {

    func modify(_ image: KFCrossPlatformImage) -> KFCrossPlatformImage {
        image.bw ?? image
    }
}

class InvertModifier: ImageModifier {

    func modify(_ image: KFCrossPlatformImage) -> KFCrossPlatformImage {
        image.invert ?? image
    }
}

class VoidModifier: ImageModifier {

    func modify(_ image: KFCrossPlatformImage) -> KFCrossPlatformImage {
        image
    }
}
