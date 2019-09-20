//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Solulab on 9/20/19.
//  Copyright © 2019 Solulab. All rights reserved.
//

import UIKit

class QuizViewController: BaseViewController {
    
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var btnOptionA: UIButton!
    @IBOutlet weak var btnOptionB: UIButton!
    @IBOutlet weak var btnOptionC: UIButton!
    @IBOutlet weak var btnOptionD: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var allQuestion = QuestionRootClass()
    var serialNo:Int = 0
    var arrResult = [Bool]()
    var senderPressTag:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Quiz"
        Quiz.FetchData { [weak self](data) in
            self?.allQuestion.ParseData(fromDictionary: data)
            self?.updateUI(index:self!.serialNo)
        }
        // Do any additional setup after loading the view.
    }
    
    func updateUI(index:Int){
        
        lblQuestion.text = "\(String(describing: allQuestion.data[index].questionNo!)). \(String(describing: allQuestion.data[index].question!))"
        btnOptionA.setTitle(allQuestion.data[index].responses[0], for: .normal)
        btnOptionB.setTitle(allQuestion.data[index].responses[1], for: .normal)
        btnOptionC.setTitle(allQuestion.data[index].responses[2], for: .normal)
        btnOptionD.setTitle(allQuestion.data[index].responses[3], for: .normal)
        btnNext.isEnabled = false
    }
    
    func DeselectAll(index:Int=0){
        btnOptionA.isSelected = false
        btnOptionB.isSelected = false
        btnOptionC.isSelected = false
        btnOptionD.isSelected = false
        btnNext.isEnabled = true
        senderPressTag = index
    }
    
    func CheckResult(index:Int){
        if allQuestion.data[index].correctResponse == senderPressTag+1{
            arrResult.append(true)
        }
    }
    
    @IBAction func btnOptionAPressed(_ sender: UIButton) {
        DeselectAll(index: sender.tag)
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func btnOptionBPressed(_ sender: UIButton) {
        DeselectAll(index: sender.tag)
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func btnOptionC(_ sender: UIButton) {
        DeselectAll(index: sender.tag)
        sender.isSelected = !sender.isSelected
    }
    @IBAction func btnOptionDPressed(_ sender: UIButton) {
        DeselectAll(index: sender.tag)
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func btnNextPressed(_ sender: UIButton) {
        CheckResult(index: serialNo)
        if serialNo == allQuestion.data.count-1 {
            UIAlertController.showAlert(withTitle: "QuizApp", alertMessage: "your Quiz Score is \(arrResult.count)", buttonArray:["Start Again"]) { (button) in
                if button == 0{
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }else{
            DeselectAll()
            serialNo = serialNo+1
            updateUI(index:serialNo)
        }
    }
}
