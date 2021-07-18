//
//  SceneDelegate.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 15.07.21.
//

import RickMortySwiftApi
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let rmClient = RMClient()
        let fetcher = RMFetcher(client: rmClient)
        let episodesModel = EpisodesModel()
        let viewModel = EpisodesViewModel(fetcher: fetcher)
        let episodesView = EpisodesView(viewModel: viewModel, episodesModel: episodesModel)

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: episodesView)
        window.makeKeyAndVisible()
        self.window = window
    }
}
