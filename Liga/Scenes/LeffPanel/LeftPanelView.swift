//
//  LeftPanelView.swift
//  Liga
//
//  Created by Maxim Savchenko on 16.10.2021.
//

import UIKit

final class LeftPanelView: UIView {
    
    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .none
        return $0
    }(UITableView())
    
    lazy var iconImageView: UIImageView = {
        $0.isUserInteractionEnabled = true
        $0.image = #imageLiteral(resourceName: "image_2021-10-16_18-00-59")
        $0.backgroundColor = .clear
        $0.tintColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    lazy var dataSource: LeftPanelDataSource = {
        return $0
    }(LeftPanelDataSource())
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        prepareLayout()
//        prepareDataSource()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareLayout()
//        prepareDataSource()
    }
    
    private func prepareLayout() {
        
        self.backgroundColor = .white
//        self.addSubview(tableView)
//
//        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.addSubview(iconImageView)
        
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        iconImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    private func prepareDataSource() {
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        tableView.register(DragImageCell.self, forCellReuseIdentifier: DragImageCell.reuseIdentifier)
        
        dataSource.updateModel([DragImageViewModel(image: #imageLiteral(resourceName: "image_2021-10-16_18-00-59")),
                                DragImageViewModel(image: #imageLiteral(resourceName: "image_2021-10-16_18-00-59")),
                                DragImageViewModel(image: #imageLiteral(resourceName: "image_2021-10-16_18-00-59")),
                                DragImageViewModel(image: #imageLiteral(resourceName: "image_2021-10-16_18-00-59")),
                                DragImageViewModel(image: #imageLiteral(resourceName: "image_2021-10-16_18-00-59"))])
    }
    
    /// Для но
    func dragCurrentImageView() {
        
        
        
    }
    
}

protocol LeftPanelDelegate: AnyObject {
}

final class LeftPanelDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    var model: [CommonEntity] = []
    
    var delegate: LeftPanelDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = model[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
        
        (cell as? Setupable)?.setup(row)
        (cell as? Delegatable)?.delegate = delegate
        
        return cell
    }
    
    func updateModel(_ model: [CommonEntity]) {
        self.model = model
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? DragImageCell
        
    }
   
}
