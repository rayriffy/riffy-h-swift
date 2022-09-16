//
//  ReaderActivityAttributes.swift
//  Riffy H
//
//  Created by Phumrapee Limpianchop on 2022/09/17.
//

import Foundation
import ActivityKit

struct ReaderActivityAttributes: ActivityAttributes {
  typealias ReaderActivityStatus = ContentState
  
  public struct MiniImageAttribute: Codable, Hashable {
    var url: String
    var width: Int
    var height: Int
  }
  
  public struct miniHentaiAttribute: Codable, Hashable {
    var id: Int
    var name: String
    var artist: String
    var coverImage: MiniImageAttribute
    var pageCount: Int
    var tags: [MiniTag]
  }
  
  public struct ContentState: Codable, Hashable {
  }

  var content: miniHentaiAttribute
  var startTime: Date
}
