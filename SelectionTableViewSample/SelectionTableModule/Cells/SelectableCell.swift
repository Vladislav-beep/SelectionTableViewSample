//
//  SelectableCell.swift
//  SelectionTableViewSample
//
//  Created by Владислав Сизонов on 21.02.2023.
//

import UIKit

final class SelectableCell: UITableViewCell {
    
    // MARK: Public data structures
    
    struct DisplayData: Hashable {
        let title: String
        let image: String
        let isSelected: Bool
        let isSelectionModeOn: Bool
    }
    
    // MARK: Private properties
    
    private let leftIconView: UIImageView = {
        let leftIconView = UIImageView()
        leftIconView.clipsToBounds = true
        leftIconView.translatesAutoresizingMaskIntoConstraints = false
        return leftIconView
    }()
    
    private var selectableIcon: UIImageView = {
        let selectableIcon = UIImageView()
        selectableIcon.clipsToBounds = true
        selectableIcon.translatesAutoresizingMaskIntoConstraints = false
        return selectableIcon
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    
    private func setupViews() {
        contentView.addSubview(leftIconView)
        NSLayoutConstraint.activate([
            leftIconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leftIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leftIconView.heightAnchor.constraint(equalToConstant: 40),
            leftIconView.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        contentView.addSubview(selectableIcon)
        NSLayoutConstraint.activate([
            selectableIcon.centerYAnchor.constraint(equalTo: leftIconView.centerYAnchor),
            selectableIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            selectableIcon.heightAnchor.constraint(equalToConstant: 30),
            selectableIcon.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: leftIconView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leftIconView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: selectableIcon.leadingAnchor, constant: -12)
        ])
    }
    
    private func configureIcon(displayData: DisplayData) {
        if displayData.isSelectionModeOn {
            selectableIcon.isHidden = false
        } else {
            selectableIcon.isHidden = true
        }
        
        if displayData.isSelected {
            selectableIcon.image = UIImage(systemName: "checkmark.circle.fill") ?? UIImage()
        } else {
            selectableIcon.image = UIImage(systemName: "circle") ?? UIImage()
        }
    }

    // MARK: Public
    
    func configure(with displayData: DisplayData) {
        titleLabel.text = displayData.title
        leftIconView.image = UIImage(named: displayData.image)
        configureIcon(displayData: displayData)
    }
}
