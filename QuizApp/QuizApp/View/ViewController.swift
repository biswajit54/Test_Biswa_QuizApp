//
//  ViewController.swift
//  QuizApp
//
//  Created by Solulab on 9/19/19.
//  Copyright © 2019 Solulab. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnStartPressed(_ sender: UIButton) {
        let nav = Navigator()
        nav.pushToMovieScreen(navigationConroller: navigationController!, StoryboardIdS: "QuizViewController")
    }
}

