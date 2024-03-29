//
//  AddEventCell.swift
//  ebukharevPW4
//
//  Created by Евгений Бухарев on 05.02.2024.
//

import UIKit

final class AddEventCell: UICollectionViewCell{
    private enum Constants{
        static let labelFont: UIFont = .boldSystemFont(ofSize: 15)
        static let textViewFont: UIFont = .systemFont(ofSize: 12)
        static let textViewCornerRadius: CGFloat = 12

        static let nameTextViewHeight: CGFloat = 20

        static let descriptionTextViewHeight: CGFloat = 20
        
        static let buttonFontSize: CGFloat = 12
        static let buttonConerRadius: CGFloat = 12
        static let buttonHeight: CGFloat = 30
        
        static let stackSpacing: CGFloat = 12
        static let stackPin: CGFloat = 15
    }
    
    static let reuseId: String = "AddEventCell"
    private var nameLabel: UILabel = UILabel()
    private var nameTextView = UITextView()
    private var descriptionLabel: UILabel = UILabel()
    private  var descriptionTextView = UITextView()
    private var startDateLabel = UILabel()
    private var startDateTextView = UITextView()
    private var endDateLabel = UILabel()
    private var endDateTextView = UITextView()
    private var addEventButton = UIButton()
    
    var addEvent: ((WishEventModel) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        print("setup view")
        configureLabels()
        configureTextViews()
        
        
        addEventButton.setTitle("Add new event", for: .normal)
        addEventButton.titleLabel?.font = .systemFont(ofSize: Constants.buttonFontSize)
        addEventButton.setTitleColor(.systemGray6, for: .normal)
        addEventButton.backgroundColor = .systemBlue
        addEventButton.layer.cornerRadius = Constants.buttonConerRadius
        addEventButton.setHeight(value: Constants.buttonHeight)
        addEventButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        addEventButton.isEnabled = true
        
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel, nameTextView,
            descriptionLabel, descriptionTextView,
            startDateLabel, startDateTextView,
            endDateLabel, endDateTextView,
            addEventButton])
        stackView.spacing = Constants.stackSpacing
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, Constants.stackPin)
        contentView.backgroundColor = .cyan
    }
    
    private func configureLabels(){
        nameLabel.text = "Event name"
        nameLabel.font = Constants.labelFont
        descriptionLabel.text = "Describe event"
        descriptionLabel.font = Constants.labelFont
        startDateLabel.text = "Set start date"
        startDateLabel.font = Constants.labelFont
        endDateLabel.text = "Set end date"
        endDateLabel.font = Constants.labelFont
    }
    
    private func configureTextViews(){
        nameTextView.font = Constants.textViewFont
        nameTextView.backgroundColor = .white
        nameTextView.setHeight(value: Constants.nameTextViewHeight)
        nameTextView.layer.cornerRadius = Constants.textViewCornerRadius
        
        descriptionTextView.font = Constants.textViewFont
        descriptionTextView.backgroundColor = .white
        descriptionTextView.setHeight(value: Constants.descriptionTextViewHeight)
        descriptionTextView.layer.cornerRadius = Constants.textViewCornerRadius
        
        startDateTextView.font = Constants.textViewFont
        startDateTextView.backgroundColor = .white
        startDateTextView.setHeight(value: Constants.nameTextViewHeight)
        startDateTextView.layer.cornerRadius = Constants.textViewCornerRadius
        
        endDateTextView.font = Constants.textViewFont
        endDateTextView.backgroundColor = .white
        endDateTextView.setHeight(value: Constants.nameTextViewHeight)
        endDateTextView.layer.cornerRadius = Constants.textViewCornerRadius
    }
    
    @objc
    private func addButtonTapped(_ sender: UIButton) {
        
    }
}
