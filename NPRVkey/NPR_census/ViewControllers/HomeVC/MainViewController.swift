//
//  MainViewViewController.swift
//  NPR Screen
//
//  Created by mac on 05/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var locationParitcularView: UIView!
    @IBOutlet weak var labelLocationParitcular: UILabel!
    @IBOutlet weak var locationParticularLineView: UIView!
    @IBOutlet weak var incompleteHouseHoldView: UIView!
    @IBOutlet weak var labelIncompleteHouseHold: UILabel!
    @IBOutlet weak var incompleteHouseHoldLineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateTopButtonSelection(withTag: 101, selectedColor: ProjectColor.colorPrimaryDark, selectedTextColor: UIColor.white, selectedLineColor: UIColor.white, defualtColor: ProjectColor.colorPrimary, defaultTextColor: UIColor.white, defaultLineColor: UIColor.green)
        
        
        //self.loadLocationParticularViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    @IBAction func onTapBack(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTapSegmentButtons(_ sender: UIButton) {
        self.updateTopButtonSelection(withTag: sender.tag, selectedColor: ProjectColor.colorPrimaryDark, selectedTextColor: UIColor.white, selectedLineColor: UIColor.white, defualtColor: ProjectColor.colorPrimary, defaultTextColor: UIColor.white, defaultLineColor: UIColor.green)
    }
    
    func updateTopButtonSelection(withTag tag:Int, selectedColor:UIColor, selectedTextColor:UIColor, selectedLineColor:UIColor, defualtColor:UIColor,  defaultTextColor:UIColor, defaultLineColor:UIColor){
              if tag == 101 {
                self.locationParitcularView.backgroundColor = selectedColor
                self.labelLocationParitcular.textColor = selectedTextColor
                self.locationParticularLineView.backgroundColor = selectedLineColor
                
                self.incompleteHouseHoldView.backgroundColor = defualtColor
                self.labelIncompleteHouseHold.textColor = defaultTextColor
                self.incompleteHouseHoldLineView.backgroundColor = defaultLineColor
                self.loadLocationParticularViewController()
              }
              if tag == 102{
                self.incompleteHouseHoldView.backgroundColor = selectedColor
                self.labelIncompleteHouseHold.textColor = selectedTextColor
                self.incompleteHouseHoldLineView.backgroundColor = selectedLineColor
                
                self.locationParitcularView.backgroundColor = defualtColor
                self.labelLocationParitcular.textColor = defaultTextColor
                self.locationParticularLineView.backgroundColor = defaultLineColor
                self.loadIncompleteHouseholdViewController()
              }
      }
    
    
    @IBAction func onTapTabBarButtons(_ sender: UIButton) {
              if sender.tag == 101 {
                  self.navigateToUploadDataController()
               }
               if sender.tag == 102{
                  self.navigateToViewEditController()
               }
               if sender.tag == 103{
                  self.navigateToProgressController()
               }
      }
    
    /*func handleBottomButtonsSelection(withTag tag:Int, selectedColor:UIColor, defualtColor:UIColor, selectedTextColor:UIColor, defaultTextColor:UIColor){
            if tag == 101 {
                         
                }
            if tag == 102{
                         
                }
            if tag == 103{
                
            }
    }*/
    
    
    func navigateToUploadDataController(){
        self.navigateToController(identifier: "UploadDataVC", storyBoardName: "Main")
     }
    
    func navigateToViewEditController(){
        self.navigateToController(identifier: "ViewEditCompleteVC", storyBoardName: "Main")
    }
    
    func navigateToProgressController(){
        self.navigateToController(identifier: "ProgressVC", storyBoardName: "Main")
    }
    

    func loadLocationParticularViewController(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "LocationParticularVC") as! LocationParticularViewController
        self.hideContentController(content: controller)
        self.displayContentController(content: controller)
    }
    
    func loadIncompleteHouseholdViewController(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "IncompleteHouseholdVC") as! IncompleteHouseholdViewController
        self.hideContentController(content: controller)
        self.displayContentController(content: controller)
    }
    
    
    func displayContentController(content: UIViewController){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.addChild(content)
            content.view.frame = self.containerView.bounds
            self.containerView.addSubview(content.view)
            content.didMove(toParent: self)
        }
    }
    
    func hideContentController(content:UIViewController){
        if self.children.count > 0 {
            let viewControllers:[UIViewController] = self.children
            for viewController in viewControllers {
                viewController.willMove(toParent: nil)
                viewController.view.removeFromSuperview()
                viewController.removeFromParent()
            }
        }
        
    }
    
}
