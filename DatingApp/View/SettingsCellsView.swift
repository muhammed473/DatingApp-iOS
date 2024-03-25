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
        let paddingView = UIView()
        paddingView.setDimensions(height: 48, width: 26)
        txtField.leftView = paddingView
        txtField.leftViewMode = .always
        
        return txtField
    }()
    let minAgeLabel = UILabel()
    let maxAgeLabel = UILabel()
    lazy var minAgeSlider = ageRangeSliderCreate()
    lazy var maxAgeSlider = ageRangeSliderCreate()
    var sliderStack = UIStackView()
    var settingsViewModel : SettingsViewModel! {
        didSet {configure() }
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        minAgeLabel.text = "Min: 18"
        maxAgeLabel.text = "Max: 65"
        addSubview(inputField)
        inputField.fillSuperview()
        let minStack = UIStackView(arrangedSubviews: [minAgeLabel ,minAgeSlider])
        minStack.spacing = 23
        let maxStack = UIStackView(arrangedSubviews: [maxAgeLabel,maxAgeSlider])
        maxStack.spacing = 23
        sliderStack = UIStackView(arrangedSubviews: [minStack,maxStack])
        sliderStack.axis = .vertical
        sliderStack.spacing = 15
        addSubview(sliderStack)
        sliderStack.centerY(inView: self)
        sliderStack.anchor(left: leftAnchor,right: rightAnchor,paddingLeft: 23,
        paddingRight: 23)
        
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
    
    func configure() {
        inputField.isHidden = settingsViewModel.inputFieldHidingStatus
        sliderStack.isHidden = settingsViewModel.sliderHidingStatus
        inputField.placeholder = settingsViewModel.placeHolder
        inputField.text = settingsViewModel.value
    }
    
    @objc func touchAgeRangeChanged(){
        
    }
    
}
