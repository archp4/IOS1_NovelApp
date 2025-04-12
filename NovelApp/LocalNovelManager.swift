//
//  LocalNovelManager.swift
//  NovelApp
//
//  Created by Arch Umeshbhai Patel on 2025-04-07.
//

import Foundation
import UIKit
import CoreData

class LocalNovelManager{
    static var shared : LocalNovelManager = LocalNovelManager()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func add(name: String, content:String) {
        // var dbresult =  filterCitiesInDB(query: name)
       // if (dbresult.count == 0){
            let newChapter = NovelEntity(context: context)
            newChapter.chapterName = name
            newChapter.chapterContext = content
            saveContext()
        //}
    }
    
    func delete(chapterToDelete: NovelEntity) {
        context.delete(chapterToDelete)
        saveContext()
    }
    
    func getChapters()-> [ NovelEntity ]{
        var dbList = [NovelEntity]()
        let fetchRequest =  NovelEntity.fetchRequest()
        do {
            dbList = try context.fetch(fetchRequest)
        }catch {
            print("error")
        }
        return dbList
    }
    
    func isChapterSaved(title: String)-> Bool{
        var dbList = [NovelEntity]()
        let titleHash = HashHelper(name: title)
        dbList = self.getChapters()
        for novel in dbList {
            let novelHash = HashHelper(name: novel.chapterName!)
            if titleHash.hashValue == novelHash.hashValue {
                return true
            }
        }
        return false
    }
    
    func saveContext () {
        let context = context
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
