//
//  PostCell.swift
//  socialapp
//
//  Created by Kasey Schlaudt on 3/20/17.
//  Copyright © 2017 Kasey Schlaudt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import SwiftKeychainWrapper

class PostCell: UITableViewCell {
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var postImg: UIImageView!
    
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    
    var userPostKey: FIRDatabaseReference!
    
    let currentUser = KeychainWrapper.standard.string(forKey: "uid")
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(post: Post, img: UIImage? = nil, userImg: UIImage? = nil) {
        
        self.post = post
        
        self.likesLbl.text = "\(post.likes)"
        
        self.username.text = post.username
        
        if img != nil {
            
            self.postImg.image = img
            
        } else {
            
            let ref = FIRStorage.storage().reference(forURL: post.postImg)
            ref.data(withMaxSize: 10 * 10000, completion: { (data, error) in
                
                if error != nil {
                    
                    print(error)
                    
                } else {
                    
                    if let imgData = data {
                        
                        if let img = UIImage(data: imgData){
                            
                            self.postImg.image = img
                        }
                    }
                }
            })
        }
        
        if userImg != nil {
            
            self.postImg.image = userImg
            
        } else {
            
            let ref = FIRStorage.storage().reference(forURL: post.userImg)
            ref.data(withMaxSize: 100000000, completion: { (data, error) in
                
                if error != nil {
                    
                    print("couldnt load img")
                    
                } else {
                    
                    if let imgData = data {
                        
                        if let img = UIImage(data: imgData){
                            
                            self.userImg.image = img
                        }
                    }
                }
            })
        }
        
        let likeRef = FIRDatabase.database().reference().child("users").child(currentUser!).child("likes").child(post.postKey)
    }
    
    @IBAction func liked(_ sender: Any) {
        
        let likeRef = FIRDatabase.database().reference().child("users").child(currentUser!).child("likes").child(post.postKey)
        
        likeRef.observeSingleEvent(of: .value, with:  { (snapshot) in
            
            if let _ = snapshot.value as? NSNull {
                
                self.post.adjustLikes(addlike: true)
                
                likeRef.setValue(true)
                
            } else {
                
                self.post.adjustLikes(addlike: false)
                
                likeRef.removeValue()
            }
        })
    }
}
