//
//  WishMakerViewController.swift
//  ebukharevPW4
//
//  Created by Евгений Бухарев on 05.02.2024.
//

import UIKit

class WishMakerViewController: UIViewController {
    
    enum Constants {
        static let spacing: CGFloat = 10
        
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let titleFont: Double = 32
        static let titleLeading: CGFloat = 30
        static let titleTop: CGFloat = 30
        static let titleText: String = "WishMaker"
        
        static let colorAlpha: Double = 1
        
        static let descriptionFont: Double = 24
        static let descriptionLeading: CGFloat = 30
        static let descriptionTop: CGFloat = 24
        static let descriptionText: String = "Close your eyes and make a wish."
        
        static let stackRadius: CGFloat = 24
        static let stackBottom: CGFloat = 20
        static let stackLeading: CGFloat = 20
        
        static let addWishButtonText: String = "My wishes"
        static let addWishButtonHeight: CGFloat = 40
        static let addWishButtonRaduius: CGFloat = 15
        
        static let scheduleWishesButtonText: String = "Schedule wish granting"
        static let scheduleWishedButtonHeight: CGFloat = 40
        static let scheduleWishesButtonRadius: CGFloat = 15
        
        static let red: String = "Red"
        static let blue: String = "Blue"
        static let green: String = "Green"
        
    }
    
    private let actionStack: UIStackView = UIStackView()
    private let sliderStack: UIStackView = UIStackView()
    
    private let addWishButton: UIButton = UIButton(type: .system)
    private let scheduleWishesButton: UIButton = UIButton(type: .system)
    private var buttons: [UIButton] = []
    
    private let titleView = UILabel()
    private let descriptionView = UILabel()
    
    private var currentRed:CGFloat = 0
    private var currentGreen:CGFloat = 0
    private var currentBlue:CGFloat = 0
    
    private var color: UIColor = .systemPink{
        didSet{
            changeColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI(){
        view.backgroundColor = color
        let coreColor = view.backgroundColor?.coreImageColor
        currentRed = coreColor!.red
        currentBlue = coreColor!.blue
        currentGreen = coreColor!.green
        configureTitle()
        configureDescription()
        configureAddWishButton()
        configureScheduleWishesButton()
        configureActionStack()
        configureSliders()
    }
    
    private func configureTitle(){
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = Constants.titleText
        titleView.font = UIFont.systemFont(ofSize: Constants.titleFont, weight: .bold)
        
        view.addSubview(titleView)
        titleView.pinXCenter(to: view)
        titleView.pinLeft(to: view, Constants.titleLeading)
        titleView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTop)
    }
    
    
    private func configureDescription(){
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.text = Constants.descriptionText
        descriptionView.adjustsFontSizeToFitWidth = true
        descriptionView.font = UIFont.systemFont(ofSize: Constants.descriptionFont)
        
        view.addSubview(descriptionView)
        descriptionView.pinXCenter(to: view)
        descriptionView.pinLeft(to: view, Constants.descriptionLeading)
        descriptionView.pinTop(to: titleView.bottomAnchor, Constants.descriptionTop)
    }
    
    private func configureSliders(){
        sliderStack.translatesAutoresizingMaskIntoConstraints = false
        sliderStack.axis = .vertical
        view.addSubview(sliderStack)
        sliderStack.layer.cornerRadius = Constants.stackRadius
        sliderStack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        sliderRed.slider.value = Float(currentRed)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        sliderBlue.slider.value = Float(currentBlue)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        sliderGreen.slider.value = Float(currentGreen)
        for slider in [sliderRed, sliderBlue, sliderGreen]{
            sliderStack.addArrangedSubview(slider)
        }
        
        sliderStack.pinXCenter(to: view)
        sliderStack.pinLeft(to: view, Constants.stackLeading)
        sliderStack.pinBottom(to: addWishButton.topAnchor, Constants.stackBottom)
        
        sliderRed.valueChanged = { [weak self] value in
            self?.currentRed = CGFloat(sliderRed.slider.value)
            self?.color = UIColor(red: self!.currentRed, green: self!.currentGreen, blue: self!.currentBlue, alpha: Constants.colorAlpha)
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.currentBlue = CGFloat(sliderBlue.slider.value)
            self?.color = UIColor(red: self!.currentRed, green: self!.currentGreen, blue: self!.currentBlue, alpha: Constants.colorAlpha)
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.currentGreen = CGFloat(sliderGreen.slider.value)
            self?.color = UIColor(red: self!.currentRed, green: self!.currentGreen, blue: self!.currentBlue, alpha: Constants.colorAlpha)
        }
    }
    
    private func configureAddWishButton(){
        view.addSubview(addWishButton)
        addWishButton.setHeight(value: Constants.addWishButtonHeight)
        
        addWishButton.backgroundColor = .systemBlue
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.setTitle(Constants.addWishButtonText, for: .normal)
        
        addWishButton.layer.cornerRadius = Constants.addWishButtonRaduius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    private func configureScheduleWishesButton(){
        view.addSubview(scheduleWishesButton)
        scheduleWishesButton.setHeight(value: Constants.scheduleWishedButtonHeight)
        
        scheduleWishesButton.backgroundColor = .systemBlue
        scheduleWishesButton.setTitleColor(.systemPink, for: .normal)
        scheduleWishesButton.setTitle(Constants.scheduleWishesButtonText, for: .normal)
        
        scheduleWishesButton.layer.cornerRadius = Constants.scheduleWishesButtonRadius
        scheduleWishesButton.addTarget(self, action: #selector(scheduleWishesButtonPressed), for: .touchUpInside)
    }
    
    private func configureActionStack(){
        actionStack.axis = .vertical
        view.addSubview(actionStack)
        actionStack.spacing = Constants.spacing
        
        for button in [addWishButton, scheduleWishesButton]{
            actionStack.addArrangedSubview(button)
        }
        
        
        actionStack.pinBottom(to: view, Constants.stackBottom)
        actionStack.pinHorizontal(to: view, Constants.stackLeading)
    }
    
    private func changeColor(){
        view.backgroundColor = color
        for button in buttons {
            button.setTitleColor(color, for: .normal)
        }
    }
    
    @objc
    private func addWishButtonPressed(){
        present(WishStoringViewController(), animated: true)
    }
    
    @objc
    private func scheduleWishesButtonPressed(){
        let vc = WishCalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

