//
//  Home.swift
//  Riffy H
//
//  Created by Phumrapee Limpianchop on 2022/09/10.
//

import SwiftUI

struct Home: View {
  @ObservedObject var listingController = ListingController()

  var body: some View {
    NavigationStack {
      ScrollView {
        VStack {
          Picker(selection: $listingController.selectedMode, label: Text(""), content: {
            Text("nhentai").tag("nhentai")
            Text("Listing").tag("listing")
          }).pickerStyle(SegmentedPickerStyle())
          
          if (listingController.firstLoad) {
            ProgressView("Loading...").padding(.top, 32)
          } else {
            LazyVStack(alignment: .leading) {
              ForEach(listingController.hentais, id: \.self.id) { hentai in
                HentaiCard(hentai: hentai)
                  .onAppear {
                    listingController.loadMoreContentIfNeeded(currentItem: hentai)
                  }
                Divider()
              }
            }
          }
        }
        .searchable(text: $listingController.searchQuery)
        .navigationTitle("Home")
        .padding(.horizontal)
      }
    }
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Home()
  }
}
