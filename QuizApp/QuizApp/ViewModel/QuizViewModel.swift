//
//  QuizViewModel.swift
//  QuizApp
//
//  Created by Solulab on 9/20/19.
//  Copyright © 2019 Solulab. All rights reserved.
//

import Foundation
import UIKit

typealias JSONDICTIONARY = [String:Any]

protocol RouterProtocol: class {
    func pushToMovieScreen(navigationConroller:UINavigationController, StoryboardIdS:String)
    func popToRootViewController(navigationController:UINavigationController)
}

 class Quiz {
    
    class func FetchData(completion:((_ jsonData:JSONDICTIONARY) -> Swift.Void)? = nil){
        
        if let path = Bundle.main.path(forResource: "Question", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                print(jsonResult)
                if let jsonResult = jsonResult as? [String:Any], let Question = jsonResult["response"] as? [String:Any] {
                    guard let completion = completion else{
                        return
                    }
                    completion(Question)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

class Navigator: RouterProtocol {
    
    func popToRootViewController(navigationController: UINavigationController) {
        navigationController.popToRootViewController(animated: true)
    }
    
    func pushToMovieScreen(navigationConroller navigationController:UINavigationController, StoryboardIdS:String){
    
        let view = mainstoryboard.instantiateViewController(withIdentifier: StoryboardIdS)
        navigationController.pushViewController(view,animated: true)        
    }
    
     var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}

extension UIAlertController {
    
    class func showAlert(withTitle alertTitle: String, alertMessage: String, buttonArray: NSArray, completion: ((_ buttonIndex : Int) -> ())? = nil){
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        for i in 0..<buttonArray.count {
            let alertButton = UIAlertAction(title: (buttonArray[i] as! String), style: .default, handler: { UIAlertAction in
                
                completion!(i)
                
                alertController.dismiss(animated: true, completion: {
                    
                })
            })
            
            alertController.addAction(alertButton)
        }
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            // present the view controller
            topController.present(alertController, animated: true, completion: nil)
        }
    }
    
}

//class ButtonOption: UIButton {
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
//    }
//
//    @objc func pressed(sender: UIButton!) {
//       sender.isSelected = !sender.isSelected
//    }
//
//}
