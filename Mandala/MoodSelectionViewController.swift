//
//  ViewController.swift
//  Mandala
//
//  Created by Saber on 10/02/2021.
//

import UIKit

class MoodSelectionViewController: UIViewController {
    
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var addMoodButton: UIButton!
    
    var moods: [Mood] = []{
        didSet {
            currentMood = moods.first
            moodButtons = moods.map { mood in
                let moodButton = UIButton()
                moodButton.setImage(mood.image, for: .normal)
                moodButton.imageView?.contentMode = .scaleAspectFit
                moodButton.adjustsImageWhenHighlighted = false
                moodButton.addTarget(self,action: #selector(moodSelectionChanged(_:)), for: .touchUpInside)
                return moodButton
            }
        }
    }
    var moodButtons: [UIButton] = []{
        didSet{
            oldValue.forEach{
                $0.removeFromSuperview()
            }
            moodButtons.forEach{
                stackView.addArrangedSubview($0)
            }
            
        }
    }
    var currentMood: Mood? {
        didSet{
            guard let currentMood = currentMood else {
                addMoodButton?.setTitle(nil, for: .normal)
                addMoodButton?.backgroundColor = nil
                return
            }
            addMoodButton?.setTitle("I'm \(currentMood.name)", for: .normal)
            addMoodButton?.backgroundColor = currentMood.color
            
        }
        
    }
    var moodsConfigurable: MoodsConfigurable!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "embedContainerViewController":
            guard let moodsConfigurable = segue.destination as? MoodsConfigurable else {
                preconditionFailure(
                    "View controller expected to conform to MoodsConfigurable")
            }
            self.moodsConfigurable = moodsConfigurable
            segue.destination.additionalSafeAreaInsets =
                UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)
        default:
            preconditionFailure("Unex")
            
        }
        
    }
    
    @objc func moodSelectionChanged(_ sender: UIButton){
        
        guard let selectedIndex = moodButtons.firstIndex(of: sender) else {
            preconditionFailure("error finiding the button")
        }
        currentMood = moods[selectedIndex]
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moods = [.happy, .angry, .confused, .crying, .goofy, .meh, .sad]
        addMoodButton.layer.cornerRadius = addMoodButton.bounds.height/2
        
    }
    
    @IBAction func addMoodTapped(_ sender: Any){
        guard let currentMood = currentMood else {
            return
        }
        let moodEntry = MoodEntry(mood: currentMood, timeStamp: Date())
        moodsConfigurable.add(moodEntry)
    }
    
    
}

