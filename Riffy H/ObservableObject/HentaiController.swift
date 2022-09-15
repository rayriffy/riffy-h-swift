//
//  HentaiController.swift
//  Riffy H
//
//  Created by Phumrapee Limpianchop on 2022/09/10.
//

import Foundation
import Alamofire

public class HentaiController: ObservableObject {
  @Published var hentai: Hentai?
  
  init(code: Int) {
    AF.request(
      "\(Config.baseAPIUrl)/swift/gallery",
      method: .get,
      parameters: [
        "code": String(code),
      ]
    )
    .responseDecodable(of: APIResponseWithData<Hentai>.self) { response in
      switch response.result {
      case .success(let apiListingResponse):
        self.hentai = apiListingResponse.data
        break
      case .failure(let error):
        print("failed to fetch GET /api/swift/gallery: \(error)")
        break
      }
    }
  }
}
