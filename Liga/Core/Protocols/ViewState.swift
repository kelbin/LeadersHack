//
//  ViewState.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

protocol ViewState {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

extension ViewState {
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
}
