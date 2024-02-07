//
//  WishEventCell.swift
//  ebukharevPW4
//
//  Created by Евгений Бухарев on 05.02.2024.
//
import UIKit

class WishEventCell: UICollectionViewCell{
    
    enum Constants{
        static let cornerRadius: CGFloat = 15
        static let offset: CGFloat = 8
        static let backgroundColor: UIColor = .systemGray6
        
        static let textColor: UIColor = .black
        
        static let titleTop: CGFloat = 5
        static let titleFont: UIFont = .systemFont(ofSize: 20)
        static let titleLeading: CGFloat = 5
        
        static let descriptionTop: CGFloat = 10
        static let descriptionLeading: CGFloat = 8
        static let descriptionFont: UIFont = .systemFont(ofSize: 13)
        
        static let startLabelBottom: CGFloat = 23
        static let startLabelTrailing: CGFloat = 8
        static let startLabelFont: UIFont = .systemFont(ofSize: 10)
        
        static let endLabelBottom: CGFloat = 8
        static let endLabelTrailing: CGFloat = 8
        static let endLabelFont: UIFont = .systemFont(ofSize: 10)
        
    }
    
    static let reuseIdentifier: String = "EventCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell configuration
    func configure(with event: WishEventModel){
        
        let requiredFormat = DateFormatter()
        requiredFormat.dateFormat = "dd.MM.YYYY"

        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start: \(requiredFormat.string(from: event.startDate))"
        endDateLabel.text = "End: \(requiredFormat.string(from: event.endDate))"
    }
    
    // MARK: - Configure UI
    private func configureWrap(){
        addSubview(wrapView)
        
        wrapView.pin(to: self, Constants.offset)
        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = Constants.backgroundColor
    }
    
    private func configureTitleLabel(){
        addSubview(titleLabel)
        
        titleLabel.textColor = Constants.textColor
        titleLabel.font = Constants.titleFont
        
        titleLabel.pinLeft(to: wrapView, Constants.titleLeading)
        titleLabel.pinTop(to: wrapView, Constants.titleTop)
    }

    private func configureDescriptionLabel(){
        addSubview(descriptionLabel)
        
        descriptionLabel.font = Constants.descriptionFont
        descriptionLabel.textColor = Constants.textColor
        
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.descriptionTop)
        descriptionLabel.pinLeft(to: wrapView, Constants.descriptionLeading)
    }

    private func configureStartDateLabel(){
        addSubview(startDateLabel)
        
        startDateLabel.font = Constants.startLabelFont
        startDateLabel.textColor = Constants.textColor
        
        startDateLabel.pinBottom(to: wrapView, Constants.startLabelBottom)
        startDateLabel.pinRight(to: wrapView, Constants.startLabelTrailing)
    }

    private func configureEndDateLabel(){
        addSubview(endDateLabel)

        endDateLabel.font = Constants.endLabelFont
        endDateLabel.textColor = Constants.textColor
        
        endDateLabel.pinBottom(to: wrapView, Constants.endLabelBottom)
        endDateLabel.pinRight(to: wrapView, Constants.endLabelTrailing)
    }
}
