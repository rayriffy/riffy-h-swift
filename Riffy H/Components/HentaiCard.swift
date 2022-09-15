//
//  HentaiCard.swift
//  Riffy H
//
//  Created by Phumrapee Limpianchop on 2022/09/10.
//

import SwiftUI

struct HentaiCard: View {
  public var hentai: Hentai

  var body: some View {
    NavigationLink(
      destination: HentaiDetail(hentaiController: .init(code: hentai.id))
    ) {
      HStack(spacing: 10) {
        ImageRender(
          image: hentai.images.cover,
          media_id: hentai.media_id,
          type: "cover",
          sizingMode: .width,
          sizingSize: 100
        )
        
        VStack(alignment: .leading, spacing: 5) {
          Text(hentai.title.pretty ?? "")
            .lineLimit(3)
            .font(.headline)
            .foregroundColor(.primary)
            .multilineTextAlignment(.leading)
          Text(hentai.tags.first(where: { $0.type == "artist" })?.name ?? "")
            .lineLimit(1)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.leading)

          Spacer()
          
          HStack(spacing: 2) {
            Text(String(hentai.tags.first(where: { $0.type == "language" })?.id ?? "unknown").capitalizingFirstLetter())
            Spacer()
            Image(systemName: "photo.on.rectangle.angled")
            Text(String(hentai.num_pages))
          }.foregroundColor(.secondary)
        }
        
        Spacer()
      }.padding(4)
    }
  }
}

struct HentaiCard_Previews: PreviewProvider {
    static var previews: some View {
        HentaiCard(
          hentai: .init(
            id: 282649,
            media_id: 1471770,
            title: .init(
              english: "Meguru Hon 2019 Natsu",
              japanese: "(C96) [Number2 (たくじ)] めぐる本2019なつ (アイドルマスター シャイニーカラーズ) [英訳]",
              pretty: "Meguru Hon 2019 Natsu"
            ),
            images: .init(
              cover: .init(t: "j", w: 350, h: 482),
              pages: []
            ),
            tags: [],
            num_pages: 18
          )
        )
    }
}
