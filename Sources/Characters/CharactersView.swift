//
//  CharactersView.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import SwiftUI

struct CharactersView: View {

    @ObservedObject var viewModel: CharactersViewModel

    var showingModal: Binding<Bool>

    init(viewModel: CharactersViewModel, showingModal: Binding<Bool>) {
        self.viewModel = viewModel
        self.showingModal = showingModal

        UIScrollView.appearance().keyboardDismissMode = .interactive
    }

    var body: some View {
        NavigationView {
            List {
                searchField

                if viewModel.characters.isEmpty, !viewModel.name.isEmpty {
                    emptySection
                } else {
                    charactersSection
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(L10n.Characters.title)
            .navigationBarItems(trailing: Button("Done") {
                showingModal.wrappedValue = false
            })
        }
        .onAppear {
            viewModel.sink()
        }
    }
}

private extension CharactersView {

    var searchField: some View {
        HStack(alignment: .center) {
            TextField(L10n.Characters.Search.placeholder, text: $viewModel.name)
        }
    }

    var charactersSection: some View {
        Section {
            ForEach(viewModel.characters) { character in
                NavigationLink(destination: viewModel.characterDetailsView(for: character.item)) {
                    CharacterRow(viewModel: character)
                }
            }
        }
    }

    var emptySection: some View {
        Section {
            Text(L10n.Characters.Search.fail(viewModel.name))
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
