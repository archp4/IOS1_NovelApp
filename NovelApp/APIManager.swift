//
//  APIManager.swift
//  NovelApp
//
//  Created by Arch Umeshbhai Patel on 2025-04-04.
//

import Foundation

protocol HomepageNovelDelgate {
    func onDataRecieve(novels: [Novel])
    func onNetworkError(errorMessage: String)
}

protocol SearchNovelDelgate {
    func onDataRecieve(novels: [NovelDetail])
    func onNetworkError(errorMessage: String)
}

protocol NovelDataDelgate {
    func onDataRecieve(novelData: NovelData)
    func onNetworkError(errorMessage: String)
}

protocol ChapterDataDelgate {
    func onDataRecieve(chapterDetails: ChapterData)
    func onNetworkError(errorMessage: String)
}

class APIManager {
    var newNovelProtocol : HomepageNovelDelgate?
    var searchProtocol : SearchNovelDelgate?
    var novelDataDelgate: NovelDataDelgate?
    var chapterDelgate: ChapterDataDelgate?
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
                self.newNovelProtocol?.onNetworkError(errorMessage: "API Error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.newNovelProtocol?.onNetworkError(errorMessage: "There is no good resposne")
                return
            }
            
            if let goodData = data {
                let decoder = JSONDecoder()
                do {
                    let novels = try decoder.decode([Novel].self, from: goodData)
                    DispatchQueue.main.async {
                        self.newNovelProtocol?.onDataRecieve(novels: novels)
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
                self.searchProtocol?.onNetworkError(errorMessage: "API Error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.searchProtocol?.onNetworkError(errorMessage: "There is no good resposne")
                return
            }
            
            if let goodData = data {
                let decoder = JSONDecoder()
                do {
                    let novels = try decoder.decode([NovelDetail].self, from: goodData)
                    DispatchQueue.main.async {
                        self.searchProtocol?.onDataRecieve(novels: novels)
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
                self.novelDataDelgate?.onNetworkError(errorMessage: "API Error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.novelDataDelgate?.onNetworkError(errorMessage: "There is no good resposne ")
                return
            }
            
            if let goodData = data {
                let decoder = JSONDecoder()
                do {
                    let novel = try decoder.decode(NovelData.self, from: goodData)
                    DispatchQueue.main.async {
                        self.novelDataDelgate?.onDataRecieve(novelData: novel)
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
                self.chapterDelgate?.onNetworkError(errorMessage: "API Error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.chapterDelgate?.onNetworkError(errorMessage: "There is no good resposne ")
                return
            }
            
            if let goodData = data {
                let decoder = JSONDecoder()
                do {
                    let chapter = try decoder.decode(ChapterData.self, from: goodData)
                    DispatchQueue.main.async {
                        self.chapterDelgate?.onDataRecieve(chapterDetails: chapter)
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
