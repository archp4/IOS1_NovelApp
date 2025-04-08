//
//  Novel.swift
//  NovelApp
//
//  Created by Arch Umeshbhai Patel on 2025-04-04.
//

import Foundation

class Novel : Codable {
    var name: String = ""
    var img_src: String = ""
    var lastest_chapter_number: String = ""
    var lastest_chapter_time: String = ""
    var href: String = ""
}


class NovelDetail: Codable {
    var name: String = ""
    var imgSrc: String = ""
    var bookRating: String = ""
    var tags: [String] = []
    var lastestChapterTime: String = ""
    var href: String = ""
}


class NovelData: Codable {
    var name: String = ""
    var descrption: String = ""
    var img_src: String = ""
    var chapters: [Chapter] = []
}

class Chapter: Codable {
    var name: String = ""
    var href: String = ""
}


class ChapterData: Codable {
    var name: String = ""
    var data: String = ""
}
