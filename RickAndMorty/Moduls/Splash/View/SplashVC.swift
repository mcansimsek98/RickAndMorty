//
//  SplashVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 28.02.2023.
//

import UIKit
import RxSwift

class SplashVC: BaseVC<SplashVM> {
    
    private var imgView : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "splash")
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.topNavBar.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            self.viewModel?.goMain.onNext(())
        })
    }

    override func setUpView() {
        view.addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imgView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}
