//
//  EpisodeDetailsView.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import SwiftUI

struct EpisodeDetailsView: View {

    @ObservedObject var viewModel: EpisodeDetailsViewModel

    init(viewModel: EpisodeDetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.name)
                .shadow(radius: 4)
            Text(viewModel.airDate)
                .shadow(radius: 4)
            Text(viewModel.code)
                .shadow(radius: 4)
            Text(viewModel.created)
                .shadow(radius: 4)
        }
        .padding()
    }
}
