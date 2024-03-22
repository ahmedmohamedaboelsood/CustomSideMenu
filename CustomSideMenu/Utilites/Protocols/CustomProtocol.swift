//
//  CustomProtocol.swift
//  CustomSideMenu
//
//  Created by Ahmed Abo Elsood on 19/03/2024.
//

import Foundation

protocol SideMenuDelegate : AnyObject {
    func sideMenuButtonPressed()
}

protocol UpdateConstraints : AnyObject{
    func update()
}
