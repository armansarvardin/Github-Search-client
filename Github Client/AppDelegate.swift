//
//  AppDelegate.swift
//  Github Client
//
//  Created by Arman Sarvardin on 25.05.2023.
//

import Foundation
import UIKit
import Combine
import Domain

var cancellables = Set<AnyCancellable>()

final class AppDelegate: NSObject,  UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        let service = SearchService()
        service.search(by: "")
        return true
    }
}
