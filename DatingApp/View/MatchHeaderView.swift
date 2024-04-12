//
//  MatchHeader.swift
//  DatingApp
//
//  Created by muhammed dursun on 11.04.2024.
//

import UIKit

private let cellIdentifer = "cell"

class MatchHeaderView : UICollectionReusableView {
    
    private let newMatchLabel : UILabel = {
       let label = UILabel()
        label.text = "Yeni Eşleşmeleler"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        return label
    }()
    
    private lazy var myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MatchCellView.self, forCellWithReuseIdentifier: cellIdentifer)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(newMatchLabel)
        newMatchLabel.anchor(top:topAnchor,left:leftAnchor,paddingTop: 50,paddingLeft: 10)
        addSubview(myCollectionView)
        myCollectionView.anchor(top: newMatchLabel.bottomAnchor,left:leftAnchor,bottom:bottomAnchor, right: rightAnchor, paddingTop: 6,paddingLeft: 10,paddingBottom: 10,paddingRight:10)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UICollectionViewDelegate

extension MatchHeaderView : UICollectionViewDelegate{
    
}

// MARK: - UICollectionViewDataSource

extension MatchHeaderView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifer,for: indexPath) as! MatchCellView
        return cell
    }

    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MatchHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 78, height: 95)
    }
}
