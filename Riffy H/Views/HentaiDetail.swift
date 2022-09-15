//
//  HentaiReader.swift
//  Riffy H
//
//  Created by Phumrapee Limpianchop on 2022/09/10.
//

import SwiftUI
import Alamofire
import TailwindColor

struct HentaiDetail: View {
  @StateObject public var hentaiController: HentaiController
  
  private static var maximumGridWidth = Int(UIScreen.main.bounds.size.width * UIScreen.main.nativeScale / 2)

  var body: some View {
    if (hentaiController.hentai == nil) {
      VStack {
        Spacer()
        ProgressView("Loading...")
        Spacer()
      }
      .navigationBarTitleDisplayMode(.inline)
    } else {
      ScrollView {
        VStack(spacing: 30) {
          /**
           * Header
           */
          HStack(spacing: 16) {
            ImageRender(
              image: hentaiController.hentai!.images.cover,
              media_id: hentaiController.hentai!.media_id,
              type: "cover",
              sizingMode: .width,
              sizingSize: 125
            )
            VStack(alignment: .leading) {
              Text(hentaiController.hentai!.title.pretty ?? "")
                  .font(.title3.bold()).multilineTextAlignment(.leading)
                  .tint(.primary).lineLimit(3)
                  .fixedSize(horizontal: false, vertical: true)
              Text(hentaiController.hentai!.title.japanese ?? hentaiController.hentai!.title.english ?? "")
                .font(.caption)
              Spacer()
              HStack {
                Button(action: {}) {
                  Image(systemName: "heart")
                }.imageScale(.large).foregroundStyle(.tint)
                Spacer()
                Button(action: {}) {
                  Text("read")
                    .bold().textCase(.uppercase).font(.headline)
                    .foregroundColor(.white).padding(.vertical, -2)
                    .padding(.horizontal, 2).lineLimit(1)
                }.buttonStyle(.borderedProminent).buttonBorderShape(.capsule)
              }
            }
            Spacer()
          }
          
          /**
           * Description
           */
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              DescriptionLanguage(language: hentaiController.hentai!.tags.first(where: { $0.type == "language" })?.id)
              Divider()
              VStack(spacing: 3) {
                Text("Page Count").textCase(.uppercase).font(.caption)
                Text(String(hentaiController.hentai!.images.pages.count)).fontWeight(.medium).font(.title3).lineLimit(1)
                Text("Pages").font(.caption)
              }.padding(4)
              Divider()
              VStack(spacing: 3) {
                Text("Mock").textCase(.uppercase).font(.caption)
                Text("NA").fontWeight(.medium).font(.title3).lineLimit(1)
                Text("Demo").font(.caption)
              }.padding(4)
              Divider()
              VStack(spacing: 3) {
                Text("Mock").textCase(.uppercase).font(.caption)
                Text("NA").fontWeight(.medium).font(.title3).lineLimit(1)
                Text("Demo").font(.caption)
              }.padding(4)
            }
          }
          .frame(height: 60)
          
          /**
           * Tags
           */
          VStack {
            TagRenderer(
              title: "Language",
              hentaiTags: hentaiController.hentai!.tags.filter {$0.type == "language"},
              tagColor: TailwindColor.green500
            )
            TagRenderer(
              title: "Character",
              hentaiTags: hentaiController.hentai!.tags.filter {$0.type == "character"},
              tagColor: TailwindColor.red500
            )
            TagRenderer(
              title: "Parody",
              hentaiTags: hentaiController.hentai!.tags.filter {$0.type == "parody"},
              tagColor: TailwindColor.orange500
            )
            TagRenderer(
              title: "Artist",
              hentaiTags: hentaiController.hentai!.tags.filter {$0.type == "artist"},
              tagColor: TailwindColor.pink500
            )
            TagRenderer(
              title: "Category",
              hentaiTags: hentaiController.hentai!.tags.filter {$0.type == "category"},
              tagColor: TailwindColor.purple500
            )
            TagRenderer(
              title: "Tag",
              hentaiTags: hentaiController.hentai!.tags.filter {$0.type == "tag"},
              tagColor: TailwindColor.blue500
            )
          }
        }
        .padding()
        
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
          ForEach(0..<hentaiController.hentai!.images.pages.count, id: \.self) { index in
            NavigationLink(
              destination: HentaiReader(
                mediaId: hentaiController.hentai!.media_id,
                pages: hentaiController.hentai!.images.pages
              )) {
              ImageRender(
                image: hentaiController.hentai!.images.pages[index],
                media_id: hentaiController.hentai!.media_id,
                page: index + 1,
                type: "thumbnail",
                sizingSize: HentaiDetail.maximumGridWidth
              ).cornerRadius(8)
            }
          }
        }.padding()
        
        Spacer()
      }
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct HentaiDetail_Previews: PreviewProvider {
  static var previews: some View {
    HentaiDetail(
//      code: 282649
      hentaiController: .init(code: 282649)
    )
  }
}
