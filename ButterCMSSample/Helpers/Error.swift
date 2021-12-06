//
//  Error.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 06.12.2021.
//

import Foundation
import ButterCMSSDK

struct ErrorString {
    static let canNotConstructUrl = "ButterCMSSDK: Cannot construct URL"
    static let serverResponseNoOK = "ButterCMSSDK: Server response error"
    static let responseNotHTTPURLResponse = "ButterCMSSDK: The Response is not HTTP URL Response"
    static let noDataReturned = "ButterCMSSDK: No data returned"
    static let canNotDecodeData = "ButterCMSSDK: Cannot decode data"

    static func getString(error: Error) -> String {
        switch error {
        case let error as ButterCMSError:
            switch error.error {
            case .canNotConstructUrl: return canNotConstructUrl
            case .serverResponseNotOK(let code): return "\(serverResponseNoOK), code:  \(code), check token in ButterCMSManager() class"
            case .responseNotHTTPURLResponse: return responseNotHTTPURLResponse
            case .noDataReturned: return noDataReturned
            case .canNotDecodeData: return canNotDecodeData
            }
        default:
            return error.localizedDescription
        }
    }
}
