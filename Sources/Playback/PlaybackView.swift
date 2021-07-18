//
//  PlaybackView.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 18.07.21.
//

import AVKit
import Combine
import SwiftUI

struct PlaybackView: View {

    @ObservedObject var viewModel: PlaybackViewModel

    init(viewModel: PlaybackViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VideoPlayer(player: viewModel.player)
            .onAppear {
                viewModel.play()
            }
    }
}

// struct PlaybackView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        PlaybackView()
//    }
// }
