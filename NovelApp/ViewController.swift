//
//  ViewController.swift
//  NovelApp
//
//  Created by Arch Umeshbhai Patel on 2025-04-04.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NovelDataDelgate {
    func onDataRecieve(novelData: NovelData) {
        self.novel = novelData
        updateData()
    }
    
    func onNetworkError(errorMessage: String) {
        print("Error")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return novel?.chapters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chapterTile", for: indexPath)
        cell.textLabel?.text = novel?.chapters[indexPath.row].name ?? "Chapter Title"
        return cell
    }
    @IBOutlet weak var chapterTable: UITableView!
    
    
    var novelURL : String = "";
    var novel: NovelData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chapterTable.delegate = self
        chapterTable.dataSource = self
        APIManager.shared.novelDataDelgate = self
        requestAPI()
    }
    
    @IBOutlet weak var descIB: UILabel!
    @IBOutlet weak var titleIB: UILabel!
    @IBOutlet weak var imageIB: UIImageView!
    var selectedIndex = 0;
    
    func requestAPI(){
        APIManager.shared.fetchNovelData(novelURL: novelURL)
    }
    
    func updateData(){
        chapterTable.delegate = self
        chapterTable.dataSource = self
        chapterTable.reloadData()
        titleIB.text = novel?.name ?? "Novel Title"
        descIB.text = novel?.descrption ?? "Description"
        if let src = novel?.img_src {
            downloadImage(from: URL(string: src)!)
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ChapterViewController
        {
            let index = chapterTable.indexPathForSelectedRow?.row ?? 0
            vc.chapterURL = novel?.chapters[index].href ?? ""
        }
    }
    
}
