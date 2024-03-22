//
//  HomeVC.swift
//  CustomSideMenu
//
//  Created by Ahmed Abo Elsood on 18/03/2024.
//

import UIKit

class HomeVC: UIViewController{
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var sideMenuTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var backGroundImage: UIImageView!
    
    //MARK: - Variables
    
    weak var sideMenuDelegate : SideMenuDelegate?
    var sideMenueStatus = false
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewController.updateSideMenuButtonDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sideMenuTopAnchor.constant = 10
    }
    
    //MARK: - Methods
    
    private func sideMenuBtbAnimation(){
        if !sideMenueStatus {
            UIView.animate(withDuration: 0.5) {
                self.sideMenuTopAnchor.constant = 30
                self.view.layoutIfNeeded()
            }
        }else{
            UIView.animate(withDuration: 0.5) {
                self.sideMenuTopAnchor.constant = 10
                self.view.layoutIfNeeded()
            }
        }
        sideMenueStatus.toggle()
    }
    
    //MARK: - IBActions
    
    @IBAction func sideMenuBtn(_ sender: Any) {
        sideMenuDelegate?.sideMenuButtonPressed()
        sideMenuBtbAnimation()
    }
}

extension HomeVC : UpdateConstraints {
    func update() {
        sideMenuBtbAnimation()
    }
}
