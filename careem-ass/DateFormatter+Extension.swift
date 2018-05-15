//
//  DateFormatter+Extension.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/14/18.
//  Copyright © 2018 Huy Nguyễn. All rights reserved.
//

import Foundation

extension DateFormatter {
    struct shared {
        fileprivate static var fpDateFormatter : DateFormatter = {
            let dateFormatter = DateFormatter()
            return dateFormatter
        }()
        
        static func formatterWithFormat(_ formatString : String) -> DateFormatter {
            let dateFormatter = fpDateFormatter
            dateFormatter.dateFormat = formatString
            return dateFormatter
        }
    }
    
    static func newFormatterWithFormat(_ formatString : String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatString
        return dateFormatter
    }
}

extension Date {
    
    func reformat(with dateFormatter: DateFormatter) -> String {
        return dateFormatter.string(from: self)
    }
}
