//
//  SettingsController.swift
//  DatingApp
//
//  Created by muhammed dursun on 17.03.2024.
//

import UIKit
import JGProgressHUD

private let cellClassIdentifer = "SettingsCell"

protocol SettingsControllerDelegate: class {
    func updatingSettingsController(settingsController:SettingsController,updateUserModel : UserModel)
    func LogOutSettingsController(settingsController : SettingsController)
}

class SettingsController : UITableViewController {
    
    // MARK: - Properties
    
    private lazy var headerPhotosViews = HeaderPhotosViews(userModel: userModel)
    private let settingsFooterView = SettingsFooterView()
    private let imagePicker = UIImagePickerController()
    private var imageIndex = 0
    private var userModel : UserModel
    weak var delegate : SettingsControllerDelegate?
    
    // MARK: - Lifecycle
    
    init(userModel : UserModel) {
        self.userModel = userModel
        super.init(style: .plain)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Assistants
    
    func configureUI(){
        headerPhotosViews.delegate = self
        imagePicker.delegate = self
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(touchCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(touchDone))
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerPhotosViews
        tableView.register(SettingsCellsView.self, forCellReuseIdentifier: cellClassIdentifer)
        tableView.tableFooterView = settingsFooterView
        tableView.backgroundColor = .systemGroupedBackground
        headerPhotosViews.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        settingsFooterView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 70)
        settingsFooterView.delegate = self
    }
    
    func setHeaderImages(image: UIImage?){
        headerPhotosViews.allButtons[imageIndex].setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    // MARK: - Actions
    
    @objc func touchCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func touchDone() {
        view.endEditing(true)
        let hud = JGProgressHUD()
        hud.textLabel.text = "Veriler Kaydediliyor.."
        hud.show(in: view)
        Service.saveUserData(userModel: userModel) { error in
            self.delegate?.updatingSettingsController(settingsController: self, updateUserModel: self.userModel)
        }
        
    }
    
    // MARK: - Firebase Connections
    
    func uploadOtherImage(image: UIImage){
        let hud = JGProgressHUD()
        hud.textLabel.text = "Resim yükleniyor.."
        hud.show(in: view)
        Service.uploadImage(image: image) { imageUrl in
            self.userModel.imageURLS.append(imageUrl)
            hud.dismiss()
        }
    }
    
}

// MARK: - HeaderForDelegates

extension SettingsController: HeaderPhotosViewsDelegate{
    func setHeaderPhotosViews(headerPhotos: HeaderPhotosViews, didSelect index: Int) {
        print("PRİNT: SettingsController scriptinden fotoğraf seçiliyor.Button indexi : \(index)")
        self.imageIndex = index
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension SettingsController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        uploadOtherImage(image: selectedImage)
        setHeaderImages(image: selectedImage)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension SettingsController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellClassIdentifer, for: indexPath) as! SettingsCellsView
        cell.delegate = self
        guard let section = SettingsSection(rawValue: indexPath.section) else{return cell}
        let settingsViewModel = SettingsViewModel(userModel: self.userModel, sections: section)
        cell.settingsViewModel = settingsViewModel
        cell.backgroundColor = .yellow
        cell.contentView.isUserInteractionEnabled = false
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension SettingsController{
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = SettingsSection(rawValue: section) else { return nil }
        return section.description
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return 0 }
        return section == .ageRange ? 95 : 45
    }
}

// MARK: - SettingsCellViewDelegate

extension SettingsController:SettingsCellViewDelegate {
    func updatingSettingsCell(_ cell: SettingsCellsView, sender: UISlider) {
        if sender == cell.minAgeSlider {
            userModel.minSeekingAge = Int(sender.value)
        }
        else {
            userModel.maxSeekingAge = Int(sender.value)
        }
        
    }
    
    func updatingSettingsCellTextField(_ cell: SettingsCellsView,value: String,section: SettingsSection) {
        switch section {
        case .name:
            userModel.name = value
        case .job:
            userModel.job = value 
        case .age:
            userModel.age = Int(value) ?? userModel.age
        case .bio:
            userModel.bio = value
        case .ageRange:
            break
        }
    }
    
}

// MARK: - SettingsFooterDelegate

extension SettingsController : SettingsFooterDelegate {
    func logOutProtocol() {
        delegate?.LogOutSettingsController(settingsController: self)
    }
    
    
}

