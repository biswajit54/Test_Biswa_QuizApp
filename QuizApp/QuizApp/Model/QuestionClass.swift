//
//  RootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 20, 2019

import Foundation

//MARK: - RootClass
public class QuestionClass {
    
    public var correctResponse : Int!
    public var question : String!
    public var responses : [String]!
    public var questionNo : String!
    
    init(fromDictionary dictionary:[String:Any]) {
        
       question = dictionary["question"] as? String
       correctResponse = dictionary["correct_response"] as? Int
       responses = dictionary["responses"] as? [String]
        questionNo = dictionary["questionNo"] as? String
        
    }
}

class QuestionRootClass {
    
    var data : [QuestionClass]!
    
    func ParseData(fromDictionary dictionary: [String:Any]){
        data = [QuestionClass]()
        if let dataArray = dictionary["data"] as? [[String:Any]]{
            for dic in dataArray{
                let value = QuestionClass(fromDictionary: dic)
                data.append(value)
            }
        }
    }
}
