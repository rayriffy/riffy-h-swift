//
//  HentaiReader.swift
//  Riffy H
//
//  Created by Phumrapee Limpianchop on 2022/09/13.
//

import SwiftUI

struct HentaiReader: View {
  public var mediaId: Int
  public var pages: [HentaiImage]

  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

struct HentaiReader_Previews: PreviewProvider {
  static var previews: some View {
    HentaiReader(mediaId: 1471770, pages: [
      .init(t: "j", w: 1280, h: 1781)
    ])
  }
}
