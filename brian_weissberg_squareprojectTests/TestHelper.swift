//
//  TestHelper.swift
//  brian_weissberg_squareprojectTests
//
//  Created by Brian Weissberg on 8/20/22.
//

import Foundation
@testable import brian_weissberg_squareproject

class TestHelper {
    static func fetchMockJson(_ state: UrlState) -> String? {
        var resouceName = TableViewConstants.emptyString.rawValue
        switch state {
        case .success:
            resouceName = TableViewConstants.success.rawValue
        case .malformed:
            resouceName = TableViewConstants.malformed.rawValue
        case .empty:
            resouceName = TableViewConstants.empty.rawValue
        }
        guard let fileURL = Bundle.main.url(forResource: resouceName, withExtension: "json"), let contents = try? String(contentsOf: fileURL) else {
            return nil
        }
        return contents
    }
}
