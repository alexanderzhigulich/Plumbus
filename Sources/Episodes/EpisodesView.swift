//
//  EpisodesView.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import SwiftUI

struct EpisodesView: View {

    @ObservedObject var viewModel: EpisodesViewModel

    private let episodesModel: EpisodesModel

    init(viewModel: EpisodesViewModel, episodesModel: EpisodesModel) {
        self.viewModel = viewModel
        self.episodesModel = episodesModel

        UIScrollView.appearance().keyboardDismissMode = .interactive
    }

    var body: some View {
        NavigationView {
            List {
                searchField

                if viewModel.episodes.isEmpty, !viewModel.name.isEmpty {
                    emptySection
                } else {
                    episodesSection
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(L10n.Episodes.title)
        }
        .onAppear {
            viewModel.sink()
        }
    }
}

private extension EpisodesView {

    var searchField: some View {
        HStack(alignment: .center) {
            TextField(L10n.Episodes.Search.placeholder, text: $viewModel.name)
        }
    }

    var episodesSection: some View {
        Section {
            ForEach(viewModel.episodes) { episode in
                NavigationLink(destination: viewModel.episodeDetailsView(for: episode.item)) {
                    EpisodeRow(viewModel: episode, episodesModel: episodesModel)
                }
            }
        }
    }

    var emptySection: some View {
        Section {
            Text(L10n.Episodes.Search.fail(viewModel.name))
                .foregroundColor(.gray)
        }
    }
}

// import RickMortySwiftApi
// struct EpisodesViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        EpisodesView(viewModel: EpisodesViewModel(fetcher: RMFetcher(client: RMClient())))
//    }
// }
