//
//  SettingsCellsViews.swift
//  DatingApp
//
//  Created by muhammed dursun on 21.03.2024.
//

import UIKit

protocol SettingsCellViewDelegate : class {
    func updatingSettingsCell(_ cell: SettingsCellsView, value:String,section:SettingsSection)
}

class SettingsCellsView : UITableViewCell{
    
    // MARK: - Properties
    weak var delegate : SettingsCellViewDelegate?
    lazy var inputField : UITextField = {
       let tf = UITextField()
         print(tf.isEnabled)
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 15)
        let paddingView = UIView()
        paddingView.setDimensions(height: 48, width: 26)
        tf.leftView = paddingView
        tf.leftViewMode = .always
         tf.addTarget(SettingsCellsView.self, action: #selector(touchUpdateUserInfos), for:.editingDidEnd)
        return tf
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
        backgroundColor = .red
        addSubview(inputField)
        inputField.fillSuperview()
        minAgeLabel.text = "Min: 18"
        maxAgeLabel.text = "Max: 65"
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
    
    @objc func touchUpdateUserInfos(sender:UITextField){
        guard let value = sender.text else {return}
        delegate?.updatingSettingsCell(self, value: value, section: settingsViewModel.sections)
    }
    
}



