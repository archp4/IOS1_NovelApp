//
//  NovelDataViewController.swift
//  NovelApp
//
//  Created by Arch Umeshbhai Patel on 2025-04-07.
//

import UIKit

class NovelDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NovelDataDelegate {

    var novelURL : String = "";
    var novel: NovelData?
    @IBOutlet weak var titleIB: UITextView!
    @IBOutlet weak var DescIB: UITextView!
    @IBOutlet weak var imageIB: UIImageView!
    @IBOutlet weak var chapterTable: UITableView!
    @IBOutlet weak var LoadingView: UIView!
    @IBOutlet weak var LoadingIndi: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chapterTable.delegate = self
        chapterTable.dataSource = self
        APIManager.shared.novelDataDelegate = self
        requestAPI()
        LoadingView?.isHidden = false
        LoadingView?.alpha = 1
        LoadingIndi?.startAnimating()
    }
    
    func onDataRecieve(novelData: NovelData) {
        self.novel = novelData
        updateData()
        errorTextView.isHidden=true
    }
    
    func onNetworkError(errorMessage: String) {
        errorText(errorMessage: errorMessage)
    }
    
    func updateData(){
        chapterTable.reloadData()
        titleIB.text = novel?.name ?? "Novel Title"
        DescIB.text = novel?.descrption ?? "Description"
        if let src = novel?.img_src {
            downloadImage(from: URL(string: src)!)
        }
        LoadingIndi?.stopAnimating()
        LoadingView?.isHidden = true
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
    
    func requestAPI(){
        APIManager.shared.fetchNovelData(novelURL: novelURL)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.imageIB.image = UIImage(data: data)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return novel?.chapters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chapterTile", for: indexPath)
        cell.textLabel?.text = novel?.chapters[indexPath.row].name ?? "Chapter Title"
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ChapterViewController
        {
            let index = chapterTable.indexPathForSelectedRow?.row ?? 0
            vc.chapterURL = novel?.chapters[index].href ?? ""
        }
    }

}
