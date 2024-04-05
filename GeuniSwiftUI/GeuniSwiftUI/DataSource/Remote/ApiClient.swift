//
//  ApiClient.swift
//  GeuniSwiftUI
//
//  Created by 60157085 on 2024/02/27.
//

import ComposableArchitecture
import Foundation

struct ApiClient {
    var fetchNumberInfo: @Sendable (Int) async throws -> String
}

extension DependencyValues {
    var apiClient: ApiClient {
        get { self[ApiClient.self] }
        set { self[ApiClient.self] = newValue }
    }
}

extension ApiClient: DependencyKey {
    static let liveValue = Self(
        fetchNumberInfo: { number in
            let (data, _) = try await URLSession.shared
                .data(from: URL(string: "http://numbersapi.com/\(number)/trivia")!)
            return String(decoding: data, as: UTF8.self)
        }
    )

    static let testValue = Self(
        fetchNumberInfo: unimplemented("\(Self.self).fetch")
    )
}
