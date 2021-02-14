//
//  UIImage+Mandala.swift
//  Mandala
//
//  Created by Saber on 14/02/2021.
//

import UIKit

enum ImageResources: String {
    case angry
    case confused
    case crying
    case goofy
    case happy
    case meh
    case sad
    case sleepy
}

extension UIImage{
    
    convenience init(resource: ImageResources) {
        self.init(named: resource.rawValue)!
    }
    
}
