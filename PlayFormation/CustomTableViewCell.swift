//
//  CustomTableViewCell.swift
//  PlayFormation PlayFormation PlayFormation
//
//  Created by cmgjnmac on 6/14/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    let checkbox = UIButton(type: .system)
    let formationLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        formationLabel.translatesAutoresizingMaskIntoConstraints = false
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(formationLabel)
        contentView.addSubview(checkbox)
        
        checkbox.setTitle("☐", for: .normal)
        
        NSLayoutConstraint.activate([
            checkbox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkbox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkbox.widthAnchor.constraint(equalToConstant: 30),
            checkbox.heightAnchor.constraint(equalToConstant: 30),
            
            formationLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            formationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            formationLabel.trailingAnchor.constraint(equalTo: checkbox.leadingAnchor, constant: -8)
        ])
    }
}


