//
//  SettingsCellsViews.swift
//  DatingApp
//
//  Created by muhammed dursun on 21.03.2024.
//

import UIKit

class SettingsCellsView : UITableViewCell {
    
    // MARK: - Properties
    
    lazy var inputField : UITextField = {
       let txtField = UITextField()
        txtField.font = UIFont.systemFont(ofSize: 15)
        txtField.borderStyle = .none
        txtField.placeholder = "Uygun bilgilerinizi giriniz."
        let paddingView = UIView()
        paddingView.setDimensions(height: 48, width: 26)
        txtField.leftView = paddingView
        txtField.leftViewMode = .always
        
        return txtField
    }()
    let ageMinLabel = UILabel()
    let ageMaxLabel = UILabel()
    lazy var minAgeSlider = ageRangeSliderCreate()
    lazy var maxAgeSlider = ageRangeSliderCreate()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(inputField)
        inputField.fillSuperview()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Assistans
    
    func ageRangeSliderCreate() -> UISlider{
        let slider = UISlider()
        slider.maximumValue = 60
        slider.minimumValue = 18
        slider.addTarget(self, action: #selector(touchAgeRangeChanged), for: .valueChanged)
        return slider
    }
    
    // MARK: - Actions
    
    @objc func touchAgeRangeChanged(){
        
    }
    
}
