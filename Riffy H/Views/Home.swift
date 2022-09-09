//
//  Home.swift
//  Riffy H
//
//  Created by Phumrapee Limpianchop on 2022/09/10.
//

import SwiftUI

struct Home: View {
  @State private var selectedMode: String = "nhentai"

  var body: some View {
    NavigationStack {
      VStack {
        Picker(selection: $selectedMode, label: Text(""), content: {
          Text("NHentai").tag("nhentai")
          Text("Listing").tag("listing")
        }).pickerStyle(SegmentedPickerStyle())
        
        Spacer()
      }
      .padding()
      .navigationTitle("Home")
    }
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Home()
  }
}
