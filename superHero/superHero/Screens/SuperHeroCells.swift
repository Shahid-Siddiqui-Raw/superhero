//
//  SuperHeroCells.swift
//  superHero
//
//  Created by Muhammed Siddiqui on 7/31/24.
//

import UIKit

class SuperHeroCells: UITableViewCell {
    @IBOutlet weak var imgSuperHeroTableCell: UIImageView!
    
    @IBOutlet weak var lblSuperHeroName: UILabel!
    
    func configure(imageUrl: String? = nil, name: String? = nil, isLeader: Bool? = nil ) {
        self.lblSuperHeroName.text = name
    }
}
