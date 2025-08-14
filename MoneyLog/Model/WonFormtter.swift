//
//  wonFormtter.swift
//  MoneyLog
//
//  Created by 박서인 on 8/14/25.
//

import SwiftUI
import Foundation

struct WonStyleInt: ParseableFormatStyle {
    typealias FormatInput = Int
    typealias FormatOutput = String

    var locale: Locale = .init(identifier: "ko_KR")

    // ① 포맷(숫자 → 문자열)
    func format(_ value: Int) -> String {
        value.formatted(
            IntegerFormatStyle<Int>()
                .grouping(.automatic)
                .locale(locale)
        ) + "원"
    }

    // ② 파싱(문자열 → 숫자)
    struct WonParse: ParseStrategy {
        var locale: Locale = .init(identifier: "ko_KR")

        func parse(_ value: String) throws -> Int {
            // 1) “원”/공백 제거
            let cleaned = value
                .replacingOccurrences(of: "원", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines)

            // 2) 로케일에 맞는 NumberFormatter로 파싱
            let f = NumberFormatter()
            f.locale = locale
            f.numberStyle = .decimal
            f.usesGroupingSeparator = true
            f.maximumFractionDigits = 0

            guard let n = f.number(from: cleaned) else {
                throw CocoaError(.formatting)
            }
            return n.intValue
        }
    }

    var parseStrategy: WonParse { WonParse(locale: locale) }
}
