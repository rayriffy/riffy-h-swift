//
//  String.swift
//  Riffy H
//
//  Created by Phumrapee Limpianchop on 2022/09/11.
//

import Foundation

extension String {
  func capitalizingFirstLetter() -> String {
    return prefix(1).capitalized + dropFirst()
  }

  mutating func capitalizeFirstLetter() {
    self = self.capitalizingFirstLetter()
  }
}
