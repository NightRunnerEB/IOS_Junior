//
//  CustomSlider.swift
//  ebukharev_1PW2
//
//  Created by Евгений Бухарев on 10.10.2023.
//

import UIKit

final class CustomSlider: UIView{
    enum SliderConstants {
        static let titleTop: CGFloat = 10
        static let titleLeft: CGFloat = 20
        
        static let sliderBottom: CGFloat = 15
        static let sliderLeft: CGFloat = 20
    }
    var valueChanged: ((Double) -> Void)?
    
    var slider = UISlider()
    var titleView = UILabel()
    
    init(title: String, min:Double, max: Double){
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        backgroundColor = .systemGray6
        translatesAutoresizingMaskIntoConstraints = false
        for view in [slider, titleView]{
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleView.pinXCenter(to: centerXAnchor)
        titleView.pinTop(to: topAnchor, SliderConstants.titleTop)
        titleView.pinLeft(to: leadingAnchor, SliderConstants.titleLeft)
        
        slider.pinTop(to: titleView.bottomAnchor)
        slider.pinXCenter(to: centerXAnchor)
        slider.pinBottom(to: bottomAnchor, SliderConstants.sliderBottom)
        slider.pinLeft(to: leadingAnchor, SliderConstants.sliderLeft)
    }
    
    @objc
    private func sliderValueChanged(){
        valueChanged?(Double(slider.value))
    }
}
