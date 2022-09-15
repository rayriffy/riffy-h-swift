//
//  APIResponseWithData.swift
//  Riffy H
//
//  Created by Phumrapee Limpianchop on 2022/09/10.
//

import Foundation

struct APIResponseWithData<T : Codable>: Codable {
  var message: String
  var data: T
}
