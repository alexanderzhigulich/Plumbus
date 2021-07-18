//
//  LocationView.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 19.07.21.
//

import SwiftUI

struct LocationView: View {

    @ObservedObject private var viewModel: LocationViewModel

    init(viewModel: LocationViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.name)
                .shadow(radius: 4)
            Text(viewModel.type)
                .shadow(radius: 4)
            Text(viewModel.dimension)
                .shadow(radius: 4)
            Text(viewModel.created)
                .shadow(radius: 4)
        }
        .padding()
        .onAppear {
            viewModel.sink()
        }
    }
}
