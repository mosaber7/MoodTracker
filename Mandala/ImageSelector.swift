//
//  ImageSelector.swift
//  Mandala
//
//  Created by Saber on 15/02/2021.
//

import UIKit

class ImageSelector: UIControl {
    private let selectorStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12.0
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    var selectedIndex = 0 {
        didSet{
            if selectedIndex < 0 {
                selectedIndex = 0
            }
            if selectedIndex >= imageButtons.count{
                selectedIndex = imageButtons.count - 1
            }
            let imageView = imageButtons[selectedIndex]
            
            highligtViewXConstraint = highlightView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        
            highlightView.backgroundColor = highlightColor(forIndex: selectedIndex)
        }
        
        
    }
    private var imageButtons: [UIButton] = [] {
        didSet{
            oldValue.forEach{
                $0.removeFromSuperview()
            }
            imageButtons.forEach{
                selectorStackView.addArrangedSubview($0)
            }
        }
    }
    
    var images: [UIImage] = []{
        didSet{
            imageButtons = images.map { image in
                let imageButton = UIButton()
                imageButton.setImage(image, for: .normal)
                imageButton.imageView?.contentMode = .scaleAspectFit
                imageButton.adjustsImageWhenHighlighted = false
                imageButton.addTarget(self, action: #selector(imageButtonTapped(_:)), for: .touchUpInside)
                
                return imageButton
            }
            selectedIndex = 0
        }
    }
    
    private let highlightView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var highlightColors: [UIColor] = []{
        didSet{
            highlightView.backgroundColor = highlightColor(forIndex: selectedIndex)
        }
    }
    
    
    @objc private func imageButtonTapped(_ sender: UIButton){
        
        guard let buttonIndex = imageButtons.firstIndex(of: sender) else {
            preconditionFailure("the images and buttons are not parallel")
        }
        let selectedAnimator = UIViewPropertyAnimator(duration: 0.3,dampingRatio: 0.5 ,animations: {
            self.selectedIndex = buttonIndex
            self.layoutIfNeeded()
        })
        selectedAnimator.startAnimation()
        
        sendActions(for: .valueChanged)
        
        
    }
    private var highligtViewXConstraint: NSLayoutConstraint!{
        didSet{
            oldValue?.isActive = false
            highligtViewXConstraint.isActive = true
        }
    }
    
    private func configureViewHierarchy(){
        
        addSubview(selectorStackView)
        insertSubview(highlightView, belowSubview: selectorStackView)
        
        NSLayoutConstraint.activate([selectorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     selectorStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     selectorStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     selectorStackView.topAnchor.constraint(equalTo: topAnchor),
                                     highlightView.heightAnchor.constraint(equalTo: highlightView.widthAnchor),
                                     highlightView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
                                     highlightView.centerYAnchor
                                        .constraint(equalTo: selectorStackView.centerYAnchor)])
    }
    
    private func highlightColor(forIndex index: Int) -> UIColor{
        guard index >= 0 && index < highlightColors.count else {
            return UIColor.blue.withAlphaComponent(0.6)
        }
        return highlightColors[index]
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        highlightView.layer.cornerRadius = highlightView.bounds.width / 2.0
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewHierarchy()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViewHierarchy()
    }
}
