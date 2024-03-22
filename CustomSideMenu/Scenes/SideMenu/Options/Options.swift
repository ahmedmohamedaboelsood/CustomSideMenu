//
//  Options.swift
//  CustomSideMenu
//
//  Created by Ahmed Abo Elsood on 18/03/2024.
//

import Foundation
import UIKit

struct Options {
    var title : ViewControllerName?
    var VC = UIViewController()
}

enum ViewControllerName : String{
    case home = "Home"
    case settings = "Settings"
    case profile = "Profile"
    case terms = "Terms and Conditions"
}
