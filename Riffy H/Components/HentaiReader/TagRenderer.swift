//
//  TagRenderer.swift
//  Riffy H
//
//  Created by Phumrapee Limpianchop on 2022/09/11.
//

import SwiftUI
import TailwindColor

struct TagRenderer: View {
  public var title: String
  public var hentaiTags: [HentaiTag]
  public var tagColor: Color
  
  init(title: String, hentaiTags: [HentaiTag], tagColor: Color = TailwindColor.neutral500) {
    self.title = title
    self.hentaiTags = hentaiTags
    self.tagColor = tagColor
  }
  
  @State private var totalHeight = CGFloat.zero
  private var padding = EdgeInsets.init(top: 5, leading: 14, bottom: 5, trailing: 14)

  var body: some View {
    HStack(alignment: .top) {
      Text(title).font(.subheadline.bold())
        .foregroundColor(.white).padding(padding)
        .background(Color(.systemGray)).cornerRadius(5)
        .padding(.top, 4)
      
      VStack {
        GeometryReader { geometry in
          self.generateContent(in: geometry)
        }
      }.frame(height: totalHeight)
    }
  }
  
  private func generateContent(in g: GeometryProxy) -> some View {
    var width = CGFloat.zero
    var height = CGFloat.zero

    return ZStack(alignment: .topLeading) {
      ForEach(self.hentaiTags, id: \.self.id) { tag in
        self.item(for: tag)
          .padding([.horizontal, .vertical], 4)
          .alignmentGuide(.leading, computeValue: { d in
            if (abs(width - d.width) > g.size.width) {
              width = 0
              height -= d.height
            }
            let result = width
            if tag.name == self.hentaiTags.last?.name {
              width = 0 //last item
            } else {
              width -= d.width
            }
            return result
          })
          .alignmentGuide(.top, computeValue: {d in
            let result = height
            if tag.name == self.hentaiTags.last?.name {
              height = 0 // last item
            }
            return result
          })
      }
    }
    .background(viewHeightReader(binding: $totalHeight))
  }

  func item(for hentaiTag: HentaiTag) -> some View {
    Text(hentaiTag.name)
      .font(.subheadline.bold()).lineLimit(1).foregroundColor(.white)
      .padding(padding).background(self.tagColor).cornerRadius(5)
  }

  func viewHeightReader(binding: Binding<CGFloat>) -> some View {
    GeometryReader { geometry -> Color in
      let rect = geometry.frame(in: .local)
      DispatchQueue.main.async {
        binding.wrappedValue = rect.size.height
      }
      return .clear
    }
  }
}
