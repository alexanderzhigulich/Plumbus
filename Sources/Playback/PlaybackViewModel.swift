//
//  PlaybackViewModel.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 18.07.21.
//

import AVKit
import Combine

class PlaybackViewModel: ObservableObject {

    @Published var player = AVPlayer()
    @Published var endPlayback = false

    private let didEndPlayback: () -> Void

    private var disposables: Set<AnyCancellable> = []
    private var fakeUrl: String = "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8"

    init(didEndPlayback: @escaping () -> Void) {
        self.didEndPlayback = didEndPlayback
    }

    func play() {
        guard let url = URL(string: fakeUrl) else { return }

        player = AVPlayer(url: url)

        NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)
            .sink { [weak self] _ in
                self?.endPlayback = true
                self?.didEndPlayback()
            }
            .store(in: &disposables)

        player.play()
    }
}
