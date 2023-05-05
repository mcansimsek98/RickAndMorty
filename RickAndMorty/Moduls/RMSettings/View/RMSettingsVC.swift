//
//  RMSettingsVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import UIKit
import SwiftUI
import SafariServices
import StoreKit

class RMSettingsVC: BaseVC<RMSettingsVM> {
    
    private var settingsSwiftUIViewController: UIHostingController<RMSettingView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwiftUIController()
    }

    override func setUpView() {
        self.topNavBar.title.text = ViewTitle.settings
        topNavBar.hasBackButton = false
        topNavBar.searchBtn.isHidden = true
    }

    private func addSwiftUIController() {
        let settingsSwiftUIViewController =  UIHostingController(
            rootView: RMSettingView(viewModel: RMSettingViewVM(cellViewVM: RMSettingsOption.allCases.compactMap({
                return RMSettingsTVCellVM(type: $0) { option in
                    self.handleTap(option)
                }
        }))))
        addChild(settingsSwiftUIViewController)
        settingsSwiftUIViewController.didMove(toParent: self)
        settingsSwiftUIViewController.view.backgroundColor = UIColor.clear
        view.addSubview(settingsSwiftUIViewController.view)
        settingsSwiftUIViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsSwiftUIViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            settingsSwiftUIViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsSwiftUIViewController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsSwiftUIViewController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        self.settingsSwiftUIViewController = settingsSwiftUIViewController
    }
    
    private func handleTap(_ option: RMSettingsOption) {
        guard Thread.current.isMainThread else { return }
        if let url = option.targetUrl {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: false)
        }else if option == .rateApp {
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
}
