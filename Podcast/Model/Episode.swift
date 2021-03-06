//
//  Episode.swift
//  Podcast
//
//  Created by prog on 2/26/19.
//  Copyright © 2019 prog. All rights reserved.
//

import Foundation
import FeedKit
struct episode:Codable{
    
    let title :String
    let pubDate:Date
    let description:String
    let author: String
    let streamUrl: String
    
    var imageUrl:String?
    var fileUrl:String?
    
    
    
    init(feedItem:RSSFeedItem){
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.iTunes?.iTunesSubtitle ?? feedItem.description ?? ""
        self.imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href 
        self.author = feedItem.iTunes?.iTunesAuthor ?? ""
        self.streamUrl = feedItem.enclosure?.attributes?.url ?? ""
    }
}
