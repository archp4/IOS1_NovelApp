//
//  ChapterViewController.swift
//  NovelApp
//
//  Created by Arch Umeshbhai Patel on 2025-04-04.
//

import UIKit

class ChapterViewController: UIViewController,ChapterDataDelegate {
    @IBOutlet weak var LoadingView: UIView!
    @IBOutlet weak var dataIB: UITextView!
    @IBOutlet weak var LoadingIndi: UIActivityIndicatorView!
    var chapterData : ChapterData?
    var chapterURL : String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.shared.chapterDelegate = self
        APIManager.shared.fetchNovelChapter(chapterURL: chapterURL)
        LoadingView.isHidden = false
        LoadingView.alpha = 1
        LoadingIndi.startAnimating()
    }
 
    func onNetworkError(errorMessage: String) {
        errorText(errorMessage: errorMessage)
    }
    
    @IBAction func onSaveClick(_ sender: Any) {
        LocalNovelManager.shared.add(name: chapterData?.name ?? "" , content: chapterData?.data ?? "")
        LocalNovelManager.shared.saveContext()
        LocalButton.isHidden = true
    }
    
    func onDataRecieve(chapterDetails: ChapterData) {
        self.chapterData = chapterDetails
        loadChapter()
        errorTextView.isHidden = true
    }
    
    var errorTextView = UITextView()
    func errorText(errorMessage message:String){
        DispatchQueue.main.async {
            self.errorTextView.isHidden=false
            self.errorTextView.text = message
            self.errorTextView.frame = CGRect(x: self.view.frame.width/2, y: self.view.frame.height/2, width: self.view.frame.width, height: 40)
            self.errorTextView.center = CGPointMake(self.view.frame.size.width  / 2, self.view.frame.size.height / 2.40)
            self.errorTextView.textColor = UIColor.red
            self.errorTextView.textAlignment = NSTextAlignment.center
            self.view.addSubview(self.errorTextView)
        }
    }
   
    @IBOutlet weak var LocalButton: UIBarButtonItem!
    
    func loadChapter(){
        dataIB.text = chapterData?.data
        self.title = chapterData?.name
        LoadingView.isHidden = true
        LoadingIndi.stopAnimating()
        if LocalNovelManager.shared.isChapterSaved(title: self.title!) {
            LocalButton.isHidden = true
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
    

}
