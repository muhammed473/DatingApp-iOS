//
//  SettingsController.swift
//  DatingApp
//
//  Created by muhammed dursun on 17.03.2024.
//

import UIKit

private let cellClassIdentifer = "SettingsCell"

class SettingsController : UITableViewController {
    
    // MARK: - Properties
    
    private let headerPhotosViews = HeaderPhotosViews()
    private let imagePicker = UIImagePickerController()
    private var imageIndex = 0
    private let userModel : UserModel
    
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
    
    // MARK: Assistants
    
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
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(SettingsCellsView.self, forCellReuseIdentifier: cellClassIdentifer)
        headerPhotosViews.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
    }
    
    func setHeaderImages(image: UIImage?){
        headerPhotosViews.allButtons[imageIndex].setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    // MARK: - Actions
    
    @objc func touchCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func touchDone() {
        print("Done button was clicked.")
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
        let selectedImage = info[.originalImage] as? UIImage
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
        guard let section = SettingsSection(rawValue: indexPath.section) else{return cell}
        let settingsViewModel = SettingsViewModel(userModel: self.userModel, sections: section)
        cell.settingsViewModel = settingsViewModel
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SettingsController {
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
