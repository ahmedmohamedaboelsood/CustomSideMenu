//
//  ViewController.swift
//  CustomSideMenu
//
//  Created by Ahmed Abo Elsood on 18/03/2024.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var containingView: UIView!
    @IBOutlet var menuTableView: UITableView!
    
    //MARK: - Variables
    
    var options: [Options] = [
        Options(title: .home,VC: HomeVC()),
        Options(title: .settings,VC: SettingsVC()),
        Options(title: .profile,VC: ProfileVC())
    ]
    var menuState = false
    let screen = UIScreen.main.bounds
    var home = CGAffineTransform()
    static var updateSideMenuButtonDelegate : UpdateConstraints?
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Methods
    
    private func setupUI(){
        setupSideMenuTableView()
        home = containingView.transform
        showVC(vc: HomeVC(), withAnimation: false)
        gesturesSetUp()
    }
    
    private func setupSideMenuTableView(){
        menuTableView.register(UINib(nibName: OptionTableViewCell.ID, bundle: nil), forCellReuseIdentifier: OptionTableViewCell.ID)
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.backgroundColor = .clear
    }
    
    private func gesturesSetUp(){
        swipeGestureSetup()
        tapGestureSetup()
    }
    
    private func swipeGestureSetup(){
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGesture.direction = .right
        self.containingView.addGestureRecognizer(swipeGesture)
    }
    
    private func tapGestureSetup(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.containingView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if menuState == false {
            showSideMenu()
            ViewController.updateSideMenuButtonDelegate!.update()
        }
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        if menuState == true {
            hideMenu()
            ViewController.updateSideMenuButtonDelegate!.update()
        }
    }

    func showVC(vc:UIViewController , withAnimation:Bool){
        for childVC in children {
            childVC.willMove(toParent: nil)
            childVC.view.removeFromSuperview()
            childVC.removeFromParent()
        }
        if let vc = vc as? HomeVC{
            vc.sideMenuDelegate = self
            vc.sideMenueStatus = false
        }
        vc.view.alpha = withAnimation ? 0.5 : 1.0
        vc.view.frame = containingView.bounds
        containingView.addSubview(vc.view)
        addChild(vc)
        vc.didMove(toParent: self)
        UIView.animate(withDuration: 0.3) {
            vc.view.alpha = 1.0
        }
    }
    
    private func showSideMenu(){
        let cornerRadius: CGFloat = 40
        containingView.layer.cornerRadius = 0
        containingView.layer.cornerRadius = 40
        let x = screen.width * 0.8
        let origenalTransform = self.containingView.transform
        let scaledTransform = origenalTransform.scaledBy(x: 0.8, y: 0.8)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: 0)
        UIView.animate(withDuration: 0.7) {
            self.containingView.transform = scaledAndTranslatedTransform
            self.containingView.layer.cornerRadius = cornerRadius
            self.containingView.layer.masksToBounds = true
        }
        menuState = true
    }
    
    private func hideMenu(){
        UIView.animate(withDuration: 0.7) {
            self.containingView.transform = self.home
            self.containingView.layer.cornerRadius = 0
        }
        menuState = false
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCell.ID, for: indexPath) as! OptionTableViewCell
        cell.tiltleLbl.text = options[indexPath.row].title?.rawValue
        cell.tiltleLbl.textColor = #colorLiteral(red: 0.6461477876, green: 0.6871469617, blue: 0.6214019656, alpha: 1)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            let currentCell = (tableView.cellForRow(at: indexPath) ?? UITableViewCell()) as UITableViewCell
            // optional: animate the button when tapped
            currentCell.alpha = 0.5
            UIView.animate(withDuration: 1, animations: {
                currentCell.alpha = 1
            })
            hideMenu()
            showVC(vc: options[indexPath.row].VC, withAnimation: true)
        }
    }
}

extension ViewController : SideMenuDelegate {
    func sideMenuButtonPressed() {
        if self.menuState {
            hideMenu()
        }else{
            showSideMenu()
        }
    }
}
