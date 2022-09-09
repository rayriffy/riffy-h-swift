//
//  ContentView.swift
//  Riffy H
//
//  Created by Phumrapee Limpianchop on 2022/08/31.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      Home()
        .tabItem {
          Image(systemName: "house.circle.fill")
          Text("Home")
        }
      Text("Custom")
        .tabItem {
          Image(systemName: "staroflife.circle.fill")
          Text("Custom")
        }
      Text("Collection")
        .tabItem {
          Image(systemName: "book.closed.circle.fill")
          Text("Collection")
        }
      Text("Setting")
        .tabItem {
          Image(systemName: "gear.circle.fill")
          Text("Setting")
        }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
