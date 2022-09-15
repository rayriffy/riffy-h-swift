//
//  DescriptionLanguage.swift
//  Riffy H
//
//  Created by Phumrapee Limpianchop on 2022/09/11.
//

import SwiftUI

struct DescriptionLanguage: View {
  public var language: String?

  var body: some View {
    VStack(spacing: 3) {
      Text("Language").textCase(.uppercase).font(.caption)
      Text(language == "japanese" ? "JA" : language == "english" ? "EN" : language == "chinese" ? "CN" : "NA").fontWeight(.medium).font(.title3).lineLimit(1)
      Text(language?.capitalizingFirstLetter() ?? "Unknown").font(.caption)
    }.padding(4)
  }
}
