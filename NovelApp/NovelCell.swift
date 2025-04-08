//
//  NovelCell.swift
//  NovelApp
//
//  Created by Arch Umeshbhai Patel on 2025-04-04.
//

import UIKit

class NovelCell: UITableViewCell {

    var novel: Novel?
    
    var noImage = "https://img.novelcool.com/logo/201810/7b/Master_of_Ninja_World5172.jpg" 
    
    @IBOutlet weak var imageIB: UIImageView!
    @IBOutlet weak var titleIB: UILabel!
    @IBOutlet weak var updateIB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadData(){
        titleIB.text = novel?.name ?? "Novel Title"
        updateIB.text = novel?.lastest_chapter_time ?? "Last Updated At"
        if novel?.img_src != nil {
            guard let url = novel?.img_src else { return }
            downloadImage(from: URL(string: url)!)
            imageIB.contentMode = UIView.ContentMode.scaleAspectFill
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Help By https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
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
    
    

}
