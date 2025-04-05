//
//  ChapterViewController.swift
//  NovelApp
//
//  Created by Arch Umeshbhai Patel on 2025-04-04.
//

import UIKit

class ChapterViewController: UIViewController,ChapterDataDelgate {
    func onNetworkError(errorMessage: String) {
        print(errorMessage)
    }
    
    func onDataRecieve(chapterDetails: ChapterData) {
        self.chapterData = chapterDetails
        loadChapter()
    }
    
    var chapterData : ChapterData?
    var chapterURL : String = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.shared.chapterDelgate = self
        APIManager.shared.fetchNovelChapter(chapterURL: chapterURL)
    }
    
    func loadChapter(){
        dataIB.text = chapterData?.data
        self.title = chapterData?.name
    }
    
    
    @IBOutlet weak var dataIB: UITextView!
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
