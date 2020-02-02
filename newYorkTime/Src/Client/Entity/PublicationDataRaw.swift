//
//  Publication.swift
//  newYorkTime
//
//  Created by javi on 01/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

struct PublicationDataRaw:Codable {
    
    let status:String
    let numResults:Int?
    let results: [ResultDataRaw?]
    
    enum CodingKeys: String, CodingKey {
        case status, results
        case numResults = "num_results"
    }
}

struct ResultDataRaw: Codable {
    
    let url:String?
    let section:String?
    let type:String?
    let title:String?
    let publishedDate:String?
    let author:String?
    let media:[MediaDataRaw]?
    
    enum CodingKeys: String, CodingKey {
        case url, section, type, title, media
        case publishedDate = "published_date"
        case author = "byline"
    }
}

struct MediaDataRaw: Codable {
    
    let type:String?
    let subtype: String?
    let mediaMetadata: [MediaMetadataDataRaw?]
    
    enum CodingKeys: String, CodingKey {
        case type, subtype
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadataDataRaw:Codable {
    
    var height: Int?
    var format: String?
    var width: Int?
    var url: String?
   
}
