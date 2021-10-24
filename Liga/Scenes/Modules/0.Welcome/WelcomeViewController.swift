//
//  WelcomeViewController.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 22.10.2021.
//

import Foundation
import UIKit
import Combine
import SnapKit


final class WelcomeViewController: UIViewController {
    
    // MARK: - Views
    
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
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        layout()
        GoButton.isHidden = true
        
        bindings()
    }
   
    // MARK: - Combine
    
    func bindings() {
        // Тянем начальную рабочую зону, и указываем интерактору какую юзать
        globalInteractor.$workZones.sink { _ in } receiveValue: { _model in
            if let first = _model.first {
                self.GoButton.isHidden = false
                globalInteractor.setup(wokGeoSpace: first)
            }
        }.store(in: &cancellable)
    }
    
    // MARK: - Actions
    
    @objc func enter() {
        let vc = MapViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Private UI
    
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
            maker.centerX.equalToSuperview()
        }
        
    }
    
}
