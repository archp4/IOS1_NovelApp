//
//  APIManager.swift
//  NovelApp
//
//  Created by Arch Umeshbhai Patel on 2025-04-04.
//

import Foundation

protocol HomepageNovelDelegate {
    func onDataRecieve(novels: [Novel])
    func onNetworkError(errorMessage: String)
}

protocol SearchNovelDelegate {
    func onDataRecieve(novels: [NovelDetail])
    func onNetworkError(errorMessage: String)
}

protocol NovelDataDelegate {
    func onDataRecieve(novelData: NovelData)
    func onNetworkError(errorMessage: String)
}

protocol ChapterDataDelegate {
    func onDataRecieve(chapterDetails: ChapterData)
    func onNetworkError(errorMessage: String)
}

class APIManager {
    var newNovelDelegate : HomepageNovelDelegate?
    var searchDelegate : SearchNovelDelegate?
    var novelDataDelegate: NovelDataDelegate?
    var chapterDelegate: ChapterDataDelegate?
    static var shared = APIManager()

    func fetchRoot() {
        print("Requested Root")
        let baseURL = URL(string: "https://novel-python-api.vercel.app")!
        let task = URLSession.shared.dataTask(with: baseURL){
            data, response,error in
            
            if error != nil {
                print("API Error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("There is no good resposne")
                return
            }
            
            if let goodData = data {
                let decoder = JSONDecoder()
                do {
                    let message = try decoder.decode(HelloModel.self, from: goodData)
                    print(message.Hello)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func fetchNewNovel() {
        print("Requested New Novels")
        let newNovelURL = URL(string: "https://novel-python-api.vercel.app/new_update")!
        let task = URLSession.shared.dataTask(with: newNovelURL){
            data, response,error in
            
            if error != nil {
                self.newNovelDelegate?.onNetworkError(errorMessage: "API Error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.newNovelDelegate?.onNetworkError(errorMessage: "There is no good resposne")
                return
            }
            
            if let goodData = data {
                let decoder = JSONDecoder()
                do {
                    let novels = try decoder.decode([Novel].self, from: goodData)
                    DispatchQueue.main.async {
                        self.newNovelDelegate?.onDataRecieve(novels: novels)
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func searchNovel(query : String) {
        print("Requested Search for Novel by Name \(query)")
        let url = URL(string: "https://novel-python-api.vercel.app/search?query=\(query)")!
        let task = URLSession.shared.dataTask(with: url){
            data, response,error in
            
            if error != nil {
                self.searchDelegate?.onNetworkError(errorMessage: "API Error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.searchDelegate?.onNetworkError(errorMessage: "There is no good resposne")
                return
            }
            
            if let goodData = data {
                let decoder = JSONDecoder()
                do {
                    let novels = try decoder.decode([NovelDetail].self, from: goodData)
                    DispatchQueue.main.async {
                        self.searchDelegate?.onDataRecieve(novels: novels)
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func fetchNovelData(novelURL : String) {
        print("Requested Novel Data")
        let url = URL(string: "https://novel-python-api.vercel.app/novel_detail?url=\(novelURL)")!
        let task = URLSession.shared.dataTask(with: url){
            data, response,error in
            if error != nil {
                self.novelDataDelegate?.onNetworkError(errorMessage: "API Error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.novelDataDelegate?.onNetworkError(errorMessage: "There is no good resposne ")
                return
            }
            
            if let goodData = data {
                let decoder = JSONDecoder()
                do {
                    let novel = try decoder.decode(NovelData.self, from: goodData)
                    DispatchQueue.main.async {
                        self.novelDataDelegate?.onDataRecieve(novelData: novel)
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func fetchNovelChapter(chapterURL : String) {
        print("Requested Novel Data")
        let url = URL(string: "https://novel-python-api.vercel.app/chapter?url=\(chapterURL)")!
        let task = URLSession.shared.dataTask(with: url){
            data, response,error in
            if error != nil {
                self.chapterDelegate?.onNetworkError(errorMessage: "API Error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.chapterDelegate?.onNetworkError(errorMessage: "There is no good resposne ")
                return
            }
            
            if let goodData = data {
                let decoder = JSONDecoder()
                do {
                    let chapter = try decoder.decode(ChapterData.self, from: goodData)
                    DispatchQueue.main.async {
                        self.chapterDelegate?.onDataRecieve(chapterDetails: chapter)
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
