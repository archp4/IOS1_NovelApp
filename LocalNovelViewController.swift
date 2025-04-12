//
//  LocalNovelViewController.swift
//  NovelApp
//
//  Created by Arch Umeshbhai Patel on 2025-04-11.
//

import UIKit

class LocalNovelViewController: UIViewController {
    
    
    var LocalChapter: NovelEntity?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadChapter()
    }
    @IBOutlet weak var LocalChapterTitle: UITextView!
    @IBOutlet weak var LocalChapterContent: UITextView!
    
    
    @IBAction func onDelete(_ sender: Any) {
        LocalNovelManager.shared.delete(chapterToDelete: LocalChapter!)
        navigationController?.popViewController(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    
    func loadChapter(){
        LocalChapterTitle.text = LocalChapter?.chapterName ?? ""
        LocalChapterContent.text = LocalChapter?.chapterContext ?? ""
    }
    /*
    // MARK: - Navigation
     @IBOutlet weak var LocalChapterContent: UITextView!
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
