//
//  LiveActivity.swift
//  Riffy H
//
//  Created by Phumrapee Limpianchop on 2022/09/17.
//

import SwiftUI
import ActivityKit
import WidgetKit
import TailwindColor

struct ReaderActivityWidget: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: ReaderActivityAttributes.self) { context in
      VStack {
        Text("hello")
      }
    } dynamicIsland: { context in
      DynamicIsland {
        DynamicIslandExpandedRegion(.leading) {
          VStack {
            Spacer()
            Rectangle()
              .fill(TailwindColor.gray500)
              .aspectRatio(
                CGSize(
                  width: context.attributes.content.coverImage.width,
                  height: context.attributes.content.coverImage.height
                ),
                contentMode: .fit
              )
              .cornerRadius(6)
            Spacer()
          }
        }
        DynamicIslandExpandedRegion(.center) {
          VStack(alignment: .leading) {
            Text(context.attributes.content.name).bold()
            Text(context.attributes.content.artist).font(.caption).foregroundColor(.secondary)
            HStack {
              ForEach(context.attributes.content.tags.filter { $0.count != 0 }, id: \.self) { miniTag in
                VStack {
                  Circle()
                    .fill(
                      miniTag.tagType == "language" ? TailwindColor.green500 :
                      miniTag.tagType == "character" ? TailwindColor.red500 :
                      miniTag.tagType == "parody" ? TailwindColor.orange500 :
                      miniTag.tagType == "artist" ? TailwindColor.pink500 :
                      miniTag.tagType == "category" ? TailwindColor.purple500 :
                      miniTag.tagType == "tag" ? TailwindColor.blue500 :
                        TailwindColor.gray500
                    )
                    .frame(width: 8, height: 8)
                  Text("\(miniTag.count)")
                    .font(.caption)
                }.padding(.trailing, 4)
              }
            }
          }
        }

        DynamicIslandExpandedRegion(.bottom) {
          HStack {
            Text("Reading for")
              .font(.caption2)
            Text(context.attributes.startTime, style: .relative)
              .font(.caption2)
            Spacer()
            Text("\(context.attributes.content.pageCount) pages")
              .font(.caption2)
          }
          .padding(.vertical, 8)
          .padding(.horizontal, 16)
        }
      } compactLeading: {
        Text("📚")
      } compactTrailing: {
        Text("Reading")
      } minimal: {
        Text("📚")
      }
    }
  }
}
