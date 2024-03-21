//
//  SettingsCellsViews.swift
//  DatingApp
//
//  Created by muhammed dursun on 21.03.2024.
//

import UIKit

class SettingsCellsViews : UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemYellow
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
