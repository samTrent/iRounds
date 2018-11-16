//
//  ViewController.swift
//  iRounds
//
//  Created by Sam Trent on 11/14/18.
//  Copyright © 2018 Sam Trent. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var ref: DocumentReference? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //signing in
        Auth.auth().signIn(withEmail: "sd.trent@yahoo.com", password: "thatoneguY1") { (result, error) in
            if let error = error
            {
                print("there was a problem logging the user in...\(error.localizedDescription)")
            }
            else
            {
                print("Logged in user \(String(describing: result?.user.email!))")
            }
            
            
        }
        
        //getting employee data
        db.collection("employees").getDocuments() { (querySnapshot, error) in
            if let error = error
            {
                print("there was an error getting the docs...\(error.localizedDescription)")
            }
            else
            {
                for document in querySnapshot!.documents
                {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
        
    }


}

