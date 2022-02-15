//
//  Story.swift
//  Stories
//
//  Created by Abdullah on 10/02/2022.
//

import Foundation

struct StoryResponse: Codable {
    let stories: [Story]
}

struct Story: Codable {
    let caption: String?
    let id: String?
    let url: String?
    let timestamp: Double?
    let video: Bool?
}
