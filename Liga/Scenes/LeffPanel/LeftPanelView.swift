//
//  LeftPanelView.swift
//  Liga
//
//  Created by Maxim Savchenko on 16.10.2021.
//

import UIKit


protocol ToolbarDelegate: AnyObject {
    func goToPointsList()
    func goToGeozones()
    func goToSettings()
}

final class LeftPanelView: UIView {
    
    // MARK: - Acrch
    
    weak var delegate: ToolbarDelegate?
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .none
        return $0
    }(UITableView())
    
    /// Кнопки
    
    lazy var toolButtonGlass: UIImageView = {
        $0.tag = 1
        $0.image = #imageLiteral(resourceName: "ZoomGlassRegular")
        setupApperance(for: $0)
        setupTouch(for: $0)
        return $0
    }(UIImageView())
    
    
    lazy var toolButtonPoint: UIImageView = {
        $0.tag = 2
        $0.image = #imageLiteral(resourceName: "PointRegular")
        setupApperance(for: $0)
        setupTouch(for: $0)
        return $0
    }(UIImageView())
    
    lazy var toolButtonGeozone: UIImageView = {
        $0.tag = 3
        $0.image = #imageLiteral(resourceName: "GeozoneRegular")
        setupApperance(for: $0)
        setupTouch(for: $0)
        return $0
    }(UIImageView())
    
    lazy var toolButtonHand: UIImageView = {
        $0.tag = 4
        $0.image = #imageLiteral(resourceName: "HandRegular")
        setupApperance(for: $0)
        setupTouch(for: $0)
        return $0
    }(UIImageView())
    
    lazy var toolButtonCooment: UIImageView = {
        $0.tag = 5
        $0.image = #imageLiteral(resourceName: "CommentRegular")
        setupApperance(for: $0)
        return $0
    }(UIImageView())
    
    lazy var toolButtonSettings: UIImageView = {
        $0.tag = 6
        $0.image = #imageLiteral(resourceName: "SettingsRegular")
        setupApperance(for: $0)
        setupTouch(for: $0)
        return $0
    }(UIImageView())
    
    lazy var toolButtonPDF: UIImageView = {
        $0.tag = 7
        $0.image = #imageLiteral(resourceName: "pdfRegular")
        setupApperance(for: $0)
        return $0
    }(UIImageView())
    
    
    
    lazy var dataSource: LeftPanelDataSource = {
        return $0
    }(LeftPanelDataSource())
    
    // MARK: - View lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Open methods
    
    func didSelectedTool(with index: Int) {
        toolButtonGlass.image = #imageLiteral(resourceName: "ZoomGlassRegular")
        toolButtonPoint.image = #imageLiteral(resourceName: "PointRegular")
        toolButtonGeozone.image = #imageLiteral(resourceName: "GeozoneRegular")
        toolButtonHand.image = #imageLiteral(resourceName: "HandRegular")
        toolButtonCooment.image = #imageLiteral(resourceName: "CommentRegular")
        switch index {
        case 1: toolButtonGlass.image = #imageLiteral(resourceName: "ZoomGlassSelected")
        case 2: toolButtonPoint.image = #imageLiteral(resourceName: "PointSelected")
        case 3: toolButtonGeozone.image = #imageLiteral(resourceName: "GeozoneSelected")
        case 4: toolButtonHand.image = #imageLiteral(resourceName: "HandSelected")
        case 5: toolButtonCooment.image = #imageLiteral(resourceName: "CommentSelected")
        default: fatalError("No such index")
        }
    }
    
    // MARK: - Private
    
    private func commonInit() {
        prepareLayout()
        prepareTouches()
    }
    
    private func prepareLayout() {
        
        backgroundColor = .white
        
        self.addSubview(toolButtonGlass)
        self.addSubview(toolButtonPoint)
        self.addSubview(toolButtonGeozone)
        self.addSubview(toolButtonHand)
        self.addSubview(toolButtonCooment)
        self.addSubview(toolButtonSettings)
        self.addSubview(toolButtonPDF)
        
        toolButtonGlass.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100.0)
            make.width.equalTo(48.0)
            make.height.equalTo(48.0)
        }
        
        toolButtonPoint.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(toolButtonGlass.snp.bottom).offset(16.0)
            make.width.equalTo(48.0)
            make.height.equalTo(48.0)
        }
        
        toolButtonGeozone.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(toolButtonPoint.snp.bottom).offset(56.0)
            make.width.equalTo(48.0)
            make.height.equalTo(48.0)
        }
        
        toolButtonHand.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(toolButtonGeozone.snp.bottom).offset(16.0)
            make.width.equalTo(48.0)
            make.height.equalTo(48.0)
        }
        
        toolButtonCooment.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(toolButtonHand.snp.bottom).offset(16.0)
            make.width.equalTo(48.0)
            make.height.equalTo(48.0)
        }
        
        toolButtonSettings.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(48.0)
            make.height.equalTo(48.0)
            make.bottom.equalTo(toolButtonPDF.snp.top).offset(-16.0)
        }
        
        toolButtonPDF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(48.0)
            make.height.equalTo(48.0)
            make.bottom.equalToSuperview().offset(-32.0)
        }
    }
    
    private var didAddedShadow: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !didAddedShadow {
            shadow()
        }
    }
    
    func shadow() {
        didAddedShadow = true
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 0)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowColor = UIColor(red: 0, green: 0.078, blue: 0.263, alpha: 0.12).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 12
        layer.shadowOffset = CGSize(width: 10, height: 4)
    }
    
    private func prepareTouches() {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(didTappedGeoZones))
        toolButtonPoint.addGestureRecognizer(tap)
    }
    
    @objc func didTappedGeoZones(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        switch tag {
        case 1: delegate?.goToPointsList()
        case 2: delegate?.goToGeozones()
        case 3: break
        case 4: break
        case 5: break
        case 6: delegate?.goToSettings()
        default: break
        }
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
    
    private func setupApperance(for toolButton: UIImageView) {
        toolButton.isUserInteractionEnabled = true
        toolButton.backgroundColor = .clear
        toolButton.tintColor = .clear
        toolButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTouch(for view: UIView) {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(didTappedGeoZones(_:)))
        view.addGestureRecognizer(tap)
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
