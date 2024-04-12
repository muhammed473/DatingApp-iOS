//
//  MatchHeader.swift
//  DatingApp
//
//  Created by muhammed dursun on 11.04.2024.
//

import UIKit

private let cellIdentifer = "cell"

protocol MatchHeaderViewDelegate : class {
    func matchHeaderProtocol(matchHeaderView: MatchHeaderView, matchedUid:String)
}

class MatchHeaderView : UICollectionReusableView {
    
    weak var delegate : MatchHeaderViewDelegate?
    var matchModelValues = [MatchModel]() {
        didSet {myCollectionView.reloadData() }
    }
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("PRİNT: Eşleşilen kişinin uid'si :\(matchModelValues[indexPath.row].uid) ")
        let matchedUid = matchModelValues[indexPath.row].uid
        delegate?.matchHeaderProtocol(matchHeaderView: self, matchedUid: matchedUid)
    }
}

// MARK: - UICollectionViewDataSource

extension MatchHeaderView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matchModelValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifer,for: indexPath) as! MatchCellView
        let matchCellViewModel = MatchCellViewModel(matchModel: matchModelValues[indexPath.row])
        cell.matchCellViewModel = matchCellViewModel
        return cell
    }

    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MatchHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
