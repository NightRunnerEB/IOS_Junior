//
//  WrittenWishCell.swift
//  ebukharev_1PW2
//
//  Created by Евгений Бухарев on 10.10.2023.
//

import UIKit

final class WrittenWishCell: UITableViewCell{
    private enum Constants{
        static let wrapColor: UIColor = .systemGray6
        static let wrapRadius: CGFloat = 5
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wrapDefaultHeight: CGFloat = 30
        static let wishLabelOffset: CGFloat = 8
        
        static let buttonRadius: CGFloat = 5
        static let buttonHeight: CGFloat = 30
        static let buttonWidth: CGFloat = 30
        static let buttonTrailing: CGFloat = 10
    }
    
    static let reuseId: String = "WrittenWishCell"
    private let wishLabel: UILabel = UILabel()
    private var indexPath: IndexPath!
    private var deleteWishButton = UIButton()
    var deleteFunc: ((IndexPath) -> ())?
    
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with wish: String, indexPath: IndexPath){
        self.indexPath = indexPath
        wishLabel.text = wish
        configureButton()
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    private func configureUI(){
        selectionStyle = .none
        backgroundColor = .clear
        
        let wrap: UIView = UIView()
        addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
        wrap.setHeight(value: Constants.wrapDefaultHeight)
        
        wrap.addSubview(wishLabel)
        wishLabel.pin(to: wrap, Constants.wishLabelOffset)
        
        wrap.addSubview(deleteWishButton)
        deleteWishButton.pinRight(to: wrap.trailingAnchor, Constants.buttonTrailing)
    }
    
    private func configureButton(){
        deleteWishButton.setImage(UIImage(systemName: "arrow.up.trash"), for: .normal)
        deleteWishButton.isEnabled = true
        
        deleteWishButton.translatesAutoresizingMaskIntoConstraints = false
        deleteWishButton.layer.cornerRadius = Constants.buttonRadius
        deleteWishButton.setHeight(value: Constants.buttonHeight)
        deleteWishButton.setWidth(value: Constants.buttonWidth)
        
        deleteWishButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        
    }
    
    @objc
    private func deleteButtonTapped(_ sender: UIButton){
        deleteFunc!(indexPath)
    }
}
