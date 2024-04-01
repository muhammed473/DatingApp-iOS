//
//  SettingsCellsViews.swift
//  DatingApp
//
//  Created by muhammed dursun on 21.03.2024.
//

import UIKit

protocol SettingsCellViewDelegate : class {
    func updatingSettingsCellTextField(_ cell: SettingsCellsView, value: String,section : SettingsSection)
    func updatingSettingsCell(_ cell: SettingsCellsView,sender : UISlider)
}

class SettingsCellsView : UITableViewCell,UITextFieldDelegate{
    
    // MARK: - Properties
    weak var delegate : SettingsCellViewDelegate?
    lazy var inputFields : UITextField = {
       let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 15)
        let paddingView = UIView()
        paddingView.setDimensions(height: 48, width: 26)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        tf.addTarget(self, action: #selector(touchUpdateUserInfos), for: .editingDidEnd)
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
        selectionStyle = .none
        addSubview(inputFields)
        inputFields.fillSuperview()
        inputFields.textColor = .red
       
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
    
    func configure() {
        inputFields.isHidden = settingsViewModel.inputFieldHidingStatus
        sliderStack.isHidden = settingsViewModel.sliderHidingStatus
        inputFields.placeholder = settingsViewModel.placeHolder
        inputFields.text = settingsViewModel.value
        minAgeLabel.text = settingsViewModel.minAgeLabelSliderResult(value: settingsViewModel.minAgeSliderValue)
        maxAgeLabel.text = settingsViewModel.maxAgeLabelSliderResult(value: settingsViewModel.maxAgeSliderValue)
        minAgeSlider.setValue(settingsViewModel.minAgeSliderValue, animated: true)
        maxAgeSlider.setValue(settingsViewModel.maxAgeSliderValue, animated: true)
    
    }
    
    func ageRangeSliderCreate() -> UISlider{
        let slider = UISlider()
        slider.maximumValue = 60
        slider.minimumValue = 18
        slider.addTarget(self, action: #selector(touchAgeRangeChanged), for: .valueChanged)
        return slider
    }
    
    // MARK: - Actions
    
    @objc func touchAgeRangeChanged(sender: UISlider){
        if sender == minAgeSlider {
            minAgeLabel.text = settingsViewModel.minAgeLabelSliderResult(value: sender.value)
        }else{
            maxAgeLabel.text = settingsViewModel.maxAgeLabelSliderResult(value: sender.value)
        }
        delegate?.updatingSettingsCell(self, sender: sender)
    }
    
    @objc func touchUpdateUserInfos(sender:UITextField){
        guard let value = sender.text else {return}
      //  delegate?.updatingSettingsCell(self, value: value, section: settingsViewModel.sections)
        delegate?.updatingSettingsCellTextField(self, value: value, section: settingsViewModel.sections)
    }
    
 
    
    
}



