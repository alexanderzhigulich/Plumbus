//
//  CharacterRow.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import Kingfisher
import SwiftUI

struct CharacterRow: View {

    private let viewModel: CharacterRowViewModel

    init(viewModel: CharacterRowViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            ZStack {
                if let image = viewModel.image {
                    KFImage(image)
                        .imageModifier(viewModel.imageModifier)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipped()
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }

                if let dead = viewModel.dead {
                    Image(uiImage: dead)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
            .padding(.trailing, 10)

            VStack {
                Text(viewModel.name)
                    .font(.body)
                    .lineLimit(2)
            }

            Spacer()

            if let image = viewModel.alien {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
            }
        }
    }
}

// import RickMortySwiftApi
// struct CharacterRow_Previews: PreviewProvider {
//    static var previews: some View {
//        let item = RMCharacterModel()
//        return CharacterRow(viewModel: CharacterRowViewModel(item: item))
//    }
// }
