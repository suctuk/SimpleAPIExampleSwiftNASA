//
//  APODStruct.swift
//  APISimple
//
//  Created by Sena Uctuk on 12/18/24.
//

import Foundation

struct APODResponse: Codable {
    let title: String
    let explanation: String
    let url: String
    let date: String
    let mediaType: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case explanation
        case url
        case date
        case mediaType = "media_type"
    }
}
