//
//  NovelEntity+CoreDataProperties.swift
//  NovelApp
//
//  Created by Arch Umeshbhai Patel on 2025-04-07.
//
//

import Foundation
import CoreData


extension NovelEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NovelEntity> {
        return NSFetchRequest<NovelEntity>(entityName: "NovelEntity")
    }

    @NSManaged public var chapterName: String?
    @NSManaged public var chapterContent: String?

}

extension NovelEntity : Identifiable {

}
