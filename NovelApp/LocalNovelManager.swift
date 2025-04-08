//
//  LocalNovelManager.swift
//  NovelApp
//
//  Created by Arch Umeshbhai Patel on 2025-04-07.
//

import Foundation
import UIKit


class LocalNovelManager{
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
   
    
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
