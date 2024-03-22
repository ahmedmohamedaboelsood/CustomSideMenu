//
//  OptionTableViewCell.swift
//  CustomSideMenu
//
//  Created by Ahmed Abo Elsood on 18/03/2024.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var tiltleLbl: UILabel!
    
    //MARK: - Variables
    
    static var ID = String(describing: OptionTableViewCell.self)
    
    //MARK: - Cell life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
