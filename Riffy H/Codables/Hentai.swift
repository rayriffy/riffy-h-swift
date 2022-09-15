//
//  Hentai.swift
//  Riffy H
//
//  Created by Phumrapee Limpianchop on 2022/09/10.
//

import Foundation

struct Hentai: Codable, Identifiable, Equatable {
  static func == (lhs: Hentai, rhs: Hentai) -> Bool {
    return lhs.id == rhs.id
  }

  var id: Int
  var media_id: Int

  struct Title: Codable {
    var english: String?
    var japanese: String?
    var pretty: String?
  }
  var title: Title
  
  struct Images: Codable {
    var cover: HentaiImage
    var pages: [HentaiImage]
  }
  var images: Images
  
  var tags: [HentaiTag]
  var num_pages: Int
}
