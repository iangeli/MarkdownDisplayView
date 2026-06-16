//
//  Log.swift
//  MarkdownDisplayView
//
//  Created by hares on 2026/6/16.
//

import Foundation

func logger(_ message: String, file: String = #file, line: Int = #line) {
#if ENABLE_LOGGING
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):\(line)] \(message)")
#endif
}
