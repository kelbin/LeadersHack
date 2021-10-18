//
//  DragImageCell.swift
//  Liga
//
//  Created by Maxim Savchenko on 16.10.2021.
//

import UIKit

final class DragImageCell: UITableViewCell, Delegatable {
    
    weak var delegate: AnyObject?
    
    lazy var iconImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareLayout()
    }
    
    private func prepareLayout() {
        
        self.addSubview(iconImageView)
        
        iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        iconImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
}

extension DragImageCell: Setupable {
    
    func setup(_ object: Any) {
        guard let model = object as? DragImageViewModel else { return  }
        iconImageView.image = model.image
    }
    
}

struct DragImageViewModel: CommonEntity {
    var identifier: String {
        DragImageCell.reuseIdentifier
    }
    
    var height: CGFloat = 50
    let image: UIImage
}
