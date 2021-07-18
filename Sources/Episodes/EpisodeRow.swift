//
//  EpispdeRow.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import AVKit
import Combine
import SwiftUI

struct EpisodeRow: View {

    private let viewModel: EpisodeRowViewModel

    @ObservedObject var episodesModel: EpisodesModel

    @State private var isCharactersActive = false
    @State private var isPlaybackActive = false

    private var disposables: Set<AnyCancellable> = []

    init(viewModel: EpisodeRowViewModel, episodesModel: EpisodesModel) {
        self.viewModel = viewModel
        self.episodesModel = episodesModel
    }

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(viewModel.id)
                        .multilineTextAlignment(.center)
                        .padding(.top, 5)

                    Spacer()

                    Button(action: {
                        isCharactersActive = true
                    }) {
                        Image(uiImage: Asset.group.image)
                            .resizable()
                            .frame(width: 48, height: 48)
                            .padding(.bottom, 5)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .sheet(isPresented: $isCharactersActive) {
                        viewModel.charactersView(showingModal: $isCharactersActive)
                    }
                }
                .padding(.leading, 5)
                .padding(.trailing, 10)

                Text(viewModel.name)
                    .font(.body)
                    .lineLimit(2)

                Spacer()

                VStack {
                    Button(action: {
                        isPlaybackActive.toggle()
                        episodesModel.episodeIdInPlayback = isPlaybackActive ? viewModel.item.id : nil
                    }) {
                        Image(uiImage: canPlay ? Asset.stop.image : Asset.play.image)
                            .resizable()
                            .frame(width: 48, height: 48)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.top, 5)

                    Spacer()

                    Text(viewModel.code)
                        .multilineTextAlignment(.trailing)
                        .font(.footnote)
                        .padding(.bottom, 5)
                }
            }

            if canPlay {
                let playbackViewModel = PlaybackViewModel {
                    isPlaybackActive = false
                    episodesModel.episodeIdInPlayback = nil
                }
                PlaybackView(viewModel: playbackViewModel)
                    .frame(width: 300, height: 200)
            }
        }
        .onDisappear {
            if isPlaybackActive {
                isPlaybackActive = false
                episodesModel.episodeIdInPlayback = nil
            }
        }
        .onAppear {
            isPlaybackActive = episodesModel.episodeIdInPlayback == viewModel.item.id
        }
    }
}

private extension EpisodeRow {

    var canPlay: Bool {
        isPlaybackActive && episodesModel.episodeIdInPlayback == viewModel.item.id
    }
}

// struct EpisodeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        EpisodeRow()
//            .previewLayout(.fixed(width: 320, height: 70))
//    }
// }
