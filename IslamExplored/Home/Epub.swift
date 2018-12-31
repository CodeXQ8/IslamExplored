//
//  Epub.swift
//  Example
//
//  Created by Kevin Delord on 18/05/2017.
//  Copyright © 2017 FolioReader. All rights reserved.
//

import Foundation
import FolioReaderKit

enum Epub: Int {
    case bookOne = 0
    case bookTwo = 1


    var name: String {
        switch self {
        case .bookOne:      return "The Silver Chair" // standard eBook
        case .bookTwo:      return "Hill Think and Grow Rich"
        }
    }
    
    var excerpt: String {
        switch self {
        case .bookOne:      return "The best explanatory translation of the Qur’aan by Muhammad Muhsin Khan and Taqi-ud-Deen Hilaali. the Qur’aan by Muhammad Muhsin Khan and Taqi-ud-Deen Hilaali." // standard eBook
        case .bookTwo:      return " Proofs of Modern Science"
        }
    }

    var shouldHideNavigationOnTap: Bool {
        switch self {
        case .bookOne:      return false
        case .bookTwo:      return false
        }
    }

    var scrollDirection: FolioReaderScrollDirection {
        switch self {
        case .bookOne:      return .horizontal
        case .bookTwo:      return .horizontal

        }
    }

    var bookPath: String? {
        return Bundle.main.path(forResource: self.name, ofType: "epub")
    }

    var readerIdentifier: String {
        switch self {
        case .bookOne:      return "READER_ONE"
        case .bookTwo:      return "READER_TWO"

        }
    }
}
