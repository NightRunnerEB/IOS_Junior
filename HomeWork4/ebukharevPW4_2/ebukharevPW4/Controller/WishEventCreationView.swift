//
//  WishEventCreationView.swift
//  ebukharevPW4
//
//  Created by Евгений Бухарев on 05.02.2024.
//

import UIKit

class WishEventCreationView: UIViewController{
    private enum Constants{
        static let labelFont: UIFont = .boldSystemFont(ofSize: 22)
        static let textViewFont: UIFont = .systemFont(ofSize: 15)
        static let errorLabelFont: UIFont = .systemFont(ofSize: 11)
        static let buttonFont: UIFont = .boldSystemFont(ofSize: 14)
        static let buttonFontSize: CGFloat = 12
        
        static let textViewCornerRadius: CGFloat = 12
        static let buttonConerRadius: CGFloat = 15
        
        static let textViewWidthDelta: CGFloat = 30
        
        static let nameTextViewHeight: CGFloat = 40
        static let descriptionTextViewHeight: CGFloat = 60
        
        static let buttonTextColor: UIColor = .white
        static let buttonHeight: CGFloat = 50
        static let buttonWidth: CGFloat = 150
        
        static let stackSpacing: CGFloat = 10
        static let stackPin: CGFloat = 15
    }
    
    private var nameLabel: UILabel = UILabel()
    private var nameTextView = UITextView()
    private var descriptionLabel: UILabel = UILabel()
    private  var descriptionTextView = UITextView()
    private var startDateLabel = UILabel()
    private var startDateTextView = UITextView()
    private var endDateLabel = UILabel()
    private var endDateTextView = UITextView()
    private var addEventButton = UIButton()
    private var emptyFieldsLabel: UILabel = UILabel()
    private var errorDateLabel: UILabel = UILabel()
    
    var addEvent: ((WishEventModel) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        view.backgroundColor = .purple
        configureLabel()
        configureTextView()
        configureButton()
        
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel, nameTextView,
            descriptionLabel, descriptionTextView,
            startDateLabel, startDateTextView,
            endDateLabel, endDateTextView,
            addEventButton,
            errorDateLabel, emptyFieldsLabel])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        stackView.distribution = .fill
        stackView.alignment = .center
        view.addSubview(stackView)
        stackView.pinTop(to: view, Constants.stackPin)
        stackView.pinXCenter(to: view)
    }
    
    private func configureLabel(){
        nameLabel.text = "Event name"
        nameLabel.font = Constants.labelFont
        
        descriptionLabel.text = "Describtion"
        descriptionLabel.font = Constants.labelFont
        
        startDateLabel.text = "Start date"
        startDateLabel.font = Constants.labelFont
        
        endDateLabel.text = "End date"
        endDateLabel.font = Constants.labelFont
        
        errorDateLabel.text = "Date pattern: DD.MM.YYYY"
        errorDateLabel.font = Constants.errorLabelFont
        errorDateLabel.isHidden = true
        errorDateLabel.textColor = .red
        
        emptyFieldsLabel.text = "You must fill in all fields!!"
        emptyFieldsLabel.font = Constants.errorLabelFont
        emptyFieldsLabel.isHidden = true
        emptyFieldsLabel.textColor = .red
    }
    
    private func configureTextView(){
        nameTextView.font = Constants.textViewFont
        nameTextView.backgroundColor = .systemGray6
        nameTextView.setHeight(value: Constants.nameTextViewHeight)
        nameTextView.layer.cornerRadius = Constants.textViewCornerRadius
        nameTextView.setWidth(value: view.frame.width - Constants.textViewWidthDelta)
        
        descriptionTextView.font = Constants.textViewFont
        descriptionTextView.backgroundColor = .systemGray6
        descriptionTextView.setHeight(value: Constants.descriptionTextViewHeight)
        descriptionTextView.layer.cornerRadius = Constants.textViewCornerRadius
        descriptionTextView.setWidth(value: view.frame.width - Constants.textViewWidthDelta)
        
        startDateTextView.font = Constants.textViewFont
        startDateTextView.backgroundColor = .systemGray6
        startDateTextView.setHeight(value: Constants.nameTextViewHeight)
        startDateTextView.layer.cornerRadius = Constants.textViewCornerRadius
        startDateTextView.setWidth(value: view.frame.width - Constants.textViewWidthDelta)
        
        endDateTextView.font = Constants.textViewFont
        endDateTextView.backgroundColor = .systemGray6
        endDateTextView.setHeight(value: Constants.nameTextViewHeight)
        endDateTextView.layer.cornerRadius = Constants.textViewCornerRadius
        endDateTextView.setWidth(value: view.frame.width - Constants.textViewWidthDelta)
    }
    
    private func configureButton(){
        addEventButton.setTitle("Add new event", for: .normal)
        addEventButton.titleLabel?.font = Constants.buttonFont
        addEventButton.setTitleColor(Constants.buttonTextColor, for: .normal)
        addEventButton.backgroundColor = .systemBlue
        addEventButton.layer.cornerRadius = Constants.buttonConerRadius
        addEventButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        addEventButton.isEnabled = true
        addEventButton.translatesAutoresizingMaskIntoConstraints = false
        addEventButton.setHeight(value: Constants.buttonHeight)
        addEventButton.setWidth(value: Constants.buttonWidth)
    }
    
    @objc
    private func addButtonTapped(_ sender: UIButton) {
        let name = nameTextView.text!
        let description = descriptionTextView.text!
        let startDate = startDateTextView.text!
        let endDate = endDateTextView.text!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if(description.isEmpty || startDate.isEmpty || endDate.isEmpty || name.isEmpty){
            showEmptyFieldsError()
            return
        }
        emptyFieldsLabel.isHidden = true
        if let startDate = dateFormatter.date(from: startDate), let endDate = dateFormatter.date(from: endDate){
            addEvent!(WishEventModel(title: name, description: description, startDate: startDate, endDate: endDate))
        }
        else{
            showErrorDate()
            return
        }
        
        nameTextView.text = ""
        descriptionTextView.text = ""
        startDateTextView.text = ""
        endDateTextView.text = ""
        errorDateLabel.isHidden = true
        emptyFieldsLabel.isHidden = true
    }
    
    private func showErrorDate(){
        errorDateLabel.isHidden = false
    }
    
    private func showEmptyFieldsError(){
        emptyFieldsLabel.isHidden = false
    }
}




