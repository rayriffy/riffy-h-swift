//
//  ListingController.swift
//  Riffy H
//
//  Created by Phumrapee Limpianchop on 2022/09/10.
//

import Foundation
import Alamofire

public class ListingController: ObservableObject {
  @Published var hentais: [Hentai] = []
  @Published var selectedMode: String = "listing" {
    didSet {
      resetFetch()
    }
  }
  @Published var searchQuery: String = "" {
    didSet {
      resetFetch()
    }
  }
  @Published var firstLoad: Bool = true
  @Published var isLoading: Bool = true

  var dataRequestTemp: DataRequest?
  var isEnd: Bool = false
  
  var page: Int = 1
  
  init() {
    getListing(page: 1)
  }
  
  func resetFetch() {
    self.isLoading = true
    self.isEnd = false
    self.page = 1
    self.hentais = []
    self.firstLoad = true

    getListing(page: 1)
  }
  
  func getListing(page: Int) {
    self.isLoading = true
    
    print("fethcing page #\(page)")
    
    if (dataRequestTemp != nil) {
      dataRequestTemp?.cancel()
    }
    
    dataRequestTemp = AF.request(
      "\(Config.baseAPIUrl)/swift/listing",
      method: .get,
      parameters: [
        "query": searchQuery,
        "mode": selectedMode,
        "page": page
      ]
    )
    .responseDecodable(of: APIResponseWithData<[Hentai]>.self) { response in
      switch response.result {
      case .success(let apiListingResponse):
        if(apiListingResponse.data.count == 0) {
          self.isEnd = true
        }

        self.page = page
        self.hentais.append(contentsOf: apiListingResponse.data)
        self.isLoading = false
        self.firstLoad = false
        break
      case .failure(let error):
        print("failed to fetch GET /api/swift/listing: \(error)")

        self.isLoading = false
        break
      }
    }
  }
  
  func loadMoreContentIfNeeded(currentItem item: Hentai?) {
    if(!self.isEnd) {
      guard let item = item else {
        getListing(page: self.page + 1)
        return
      }

      let thresholdIndex = hentais.index(hentais.endIndex, offsetBy: -5)
      if(hentais.firstIndex(where: { $0.id == item.id }) == thresholdIndex) {
        getListing(page: self.page + 1)
      }
    }
  }
}
