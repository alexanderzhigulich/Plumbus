//
//  CharacterDetailsView.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import Kingfisher
import SwiftUI

struct CharacterDetailsView: View {

    @ObservedObject var viewModel: CharacterDetailsViewModel

    @State private var isOriginActive: Bool = false
    @State private var isLastseenActive: Bool = false

    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                ZStack {
                    if geometry.frame(in: .global).minY <= 0 {
                        KFImage(viewModel.image)
                            .imageModifier(viewModel.imageModifier)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .offset(y: geometry.frame(in: .global).minY / 9)
                            .clipped()
                    } else {
                        KFImage(viewModel.image)
                            .imageModifier(viewModel.imageModifier)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                            .clipped()
                            .offset(y: -geometry.frame(in: .global).minY)
                    }
                }
            }
            .frame(height: 200)

            VStack {
                HStack {
                    ZStack {
                        KFImage(viewModel.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 200)
                            .clipped()
                            .cornerRadius(10)
                            .shadow(radius: 10)

                        Image(uiImage: viewModel.stampImage)
                    }
                    .padding(.bottom, 20)
                    .padding(.trailing, 20)

                    VStack(alignment: .leading, spacing: 10) {
                        infoRow(
                            title: L10n.Characters.Details.originLocationName,
                            info: viewModel.originLocationName,
                            orientaiton: .vert
                        )
                        .onTapGesture {
                            isOriginActive = true
                        }
                        .sheet(isPresented: $isOriginActive) {
                            viewModel.originLocationView
                        }

                        infoRow(
                            title: L10n.Characters.Details.lastseenLocationName,
                            info: viewModel.lastseenLocationName,
                            orientaiton: .vert
                        )
                        .onTapGesture {
                            isLastseenActive = true
                        }
                        .sheet(isPresented: $isLastseenActive) {
                            viewModel.lastseenLocationView
                        }
                    }
                }

                VStack(spacing: 10) {
                    infoRow(title: L10n.Characters.Details.name, info: viewModel.name)
                    infoRow(title: L10n.Characters.Details.status, info: viewModel.status)
                    infoRow(title: L10n.Characters.Details.species, info: viewModel.species)
                    infoRow(title: L10n.Characters.Details.type, info: viewModel.type)
                    infoRow(title: L10n.Characters.Details.gender, info: viewModel.gender)
                }
            }
            .padding(.all, 20)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

private extension CharacterDetailsView {

    enum InfoRowOrientation {
        case vert
        case horiz
    }

    func infoRow(title: String, info: String, orientaiton: InfoRowOrientation = .horiz) -> some View {
        switch orientaiton {
        case .horiz:
            return AnyView(HStack {
                Text(title)
                    .font(.footnote)
                Spacer()
                Text(info)
                    .font(.body)
            })
        case .vert:
            return AnyView(VStack(alignment: .leading) {
                Text(title)
                    .font(.footnote)
                Text(info)
                    .font(.body)
            })
        }
    }
}
