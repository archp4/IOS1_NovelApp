//
//  APIManager.swift
//  NovelApp
//
//  Created by Arch Umeshbhai Patel on 2025-04-04.
//

import Foundation

class APIManager {
    
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
                print("There is no good resposne ")
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
                print("API Error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("There is no good resposne ")
                return
            }
            
            if let goodData = data {
                let decoder = JSONDecoder()
                do {
                    let message = try decoder.decode([Novel].self, from: goodData)
                    for novel in message {
                        print(novel.name)
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
                print("API Error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("There is no good resposne ")
                return
            }
            
            if let goodData = data {
                let decoder = JSONDecoder()
                do {
                    let message = try decoder.decode([NovelDetail].self, from: goodData)
                    if message.count == 0
                    {
                        print("No Novel Found")
                    }
                    for novel in message {
                        print(novel.name)
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
                print("API Error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("There is no good resposne ")
                return
            }
            
            if let goodData = data {
                let decoder = JSONDecoder()
                do {
                    let message = try decoder.decode(NovelData.self, from: goodData)
                    for chapter in message.chapters {
                        print(chapter.name)
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
                print("API Error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("There is no good resposne ")
                return
            }
            
            if let goodData = data {
                let decoder = JSONDecoder()
                do {
                    let chapter = try decoder.decode(ChapterData.self, from: goodData)
                    print(chapter.name)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
