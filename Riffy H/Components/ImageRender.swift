//
//  ImageRender.swift
//  Riffy H
//
//  Created by Phumrapee Limpianchop on 2022/09/10.
//

import SwiftUI
import Kingfisher
import KingfisherWebP

enum SizingMode {
  case width
  case height
}

struct ImageRender: View {
  public var image: HentaiImage
  public var media_id: Int
  public var page: Int?
  public var type: String
  public var sizingMode: SizingMode?
  public var sizingSize: Int?
  public var downsamplingDensity: Int = 2

  var body: some View {
    let transformedUrl = "https://\(self.type == "gallery" ? "i" : "t").nhentai.net/galleries/\(media_id)/\(type == "cover" ? "cover" : "\(page ?? 1)\(type == "thumbnail" ? "t" : "")").\(image.t == "p" ? "png" : image.t == "g" ? "gif" : "jpg")"
    let screenSize = Int(UIScreen.main.bounds.size.width * UIScreen.main.nativeScale)
    let targetUrl = URL(string: "\(Config.baseAPIUrl)/swift/webp")!
      .appending("url", value: transformedUrl)
      .appending("w", value: String([image.w, screenSize, Int(Double((sizingSize ?? 99999)) * 1.5)].min()!))
      .appending("q", value: "75")

    if (image.t != "g") {
      KFImage
        .url(targetUrl)
        .setProcessor(WebPProcessor.default)
        .appendProcessor(
          self.sizingMode == nil ? DefaultImageProcessor()
          : DownsamplingImageProcessor(
            size: sizingMode == .width
              ? .init(width: sizingSize! * downsamplingDensity, height: sizingSize! * downsamplingDensity * image.h / image.w)
              : .init(width: sizingSize! * downsamplingDensity * image.w / image.h, height: sizingSize! * downsamplingDensity)
          )
        )        .resizable()
        .scaledToFit()
        .frame(
          maxWidth: self.sizingMode == .width ? CGFloat(self.sizingSize!) : nil,
          maxHeight: self.sizingMode == .height ? CGFloat(self.sizingSize!) : nil
        )
    } else {
      KFAnimatedImage
        .url(targetUrl)
        .setProcessor(WebPProcessor.default)
        .scaledToFit()
        .frame(
          maxWidth: self.sizingMode == .width ? CGFloat(self.sizingSize!) : nil,
          maxHeight: self.sizingMode == .height ? CGFloat(self.sizingSize!) : nil
        )
    }
  }
}

struct ImageRender_Previews: PreviewProvider {
    static var previews: some View {
        ImageRender(
          image: .init(t: "j", w: 1280, h: 1781),
          media_id: 1471770,
          page: 13,
          type: "gallery"
        )
    }
}
