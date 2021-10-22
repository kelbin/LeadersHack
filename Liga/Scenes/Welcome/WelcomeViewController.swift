//
//  WelcomeViewController.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 22.10.2021.
//

import Foundation
import UIKit
import Combine

final class WelcomeViewController: UIViewController {
    
    lazy private var welcomePlaceholder: UILabel = {
        $0.text = "Добро пожаловать"
        $0.textAlignment = .center
        return $0.appereance(.medium)
    }(UILabel())
    
    lazy private var GoButton: UIButton = {
        $0.setTitle("Войти", for: .normal)
        $0.addTarget(self, action: #selector(enter), for: .touchUpInside)
        return $0.appereance(.primary)
    }(UIButton())
    
    override func viewDidLoad() {
        layout()
        GoButton.isHidden = true
        globalInteractor.$workZones.sink { _ in } receiveValue: { _model in
            print(_model)
            if let first = _model.first {
                print(first)
                self.GoButton.isHidden = false
                globalInteractor.setup(wokGeoSpace: first)
            }
        }.store(in: &cancellable)

        
        //globalInteractor.setup(workingFrame: box)
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    @objc func enter() {
        let vc = MapViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    private func layout() {
        view.addSubview(welcomePlaceholder)
        view.addSubview(GoButton)
        welcomePlaceholder.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(200.0)
            maker.leading.trailing.equalToSuperview()
        }
        
        GoButton.snp.makeConstraints { maker in
            maker.top.equalTo(welcomePlaceholder.snp.bottom).offset(140.0)
            maker.height.equalTo(44.0)
            maker.width.equalTo(142.0)
        }
        
    }
    
}
