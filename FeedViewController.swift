//
//  FeedViewController.swift
//  Parstagram2
//
//  Created by Sabahet Alovic on 10/19/20.
//  Copyright © 2020 Sabahet Alovic. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,MessageInputBarDelegate {
    var showsCommentBar = false
    let commentBar = MessageInputBar()
    var selectedPost: PFObject!
    var posts = [PFObject]()
    
    override var inputAccessoryView: UIView?{
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool{
        return showsCommentBar
    }
    @objc func keyboardWillBeHidden(note: Notification){
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = posts[section]
       let comments = (post["comments"] as? [PFObject]) ?? []
        
        return comments.count + 2
    }
    func numberOfSections(in tableView: UITableView) -> Int {
    
        
       return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []

        if indexPath.row == 0{

        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell

        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username

        cell.captionLabel.text = post["caption"] as? String

        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.photoView.af_setImage(withURL: url)
            return cell

        }else if indexPath.row <= comments.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentCell

            let comment = comments[indexPath.row - 1]

            cell.commentLabel.text = comment["text"] as? String
            let user = comment["author"] as! PFUser
            cell.userLabel.text = user.username
        return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "createComment")!
            return cell
            }
    }


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        commentBar.inputTextView.placeholder = "Write A Comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
               center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any. additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className:"Posts")
        query.includeKeys(["author","comments","comments.author"])
        query.limit = 20
        query.findObjectsInBackground { (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
            
        }
    }
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
               
        let comment = PFObject(className: "Comments")
                comment["text"] = text
                comment["post"] = selectedPost
                comment["author"] = PFUser.current()!
                selectedPost.add(comment, forKey: "comments")
        
                selectedPost.saveInBackground { (success, error) in
                    if success{
                        print("Comment was saved")
        
                    }else{
                        print("Error saving comment")
                    }
        }
        tableView.reloadData()
        
        
        commentBar.inputTextView.text = nil
              showsCommentBar = false
              becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginView = main.instantiateViewController(withIdentifier: "LoginView")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        
        delegate.window?.rootViewController = loginView
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.section]
        let comment = post["comments"] as? [PFObject] ?? []
        
        if indexPath.row == comment.count+1 {
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
            
            selectedPost = post
        }

        }
    }
            

    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


