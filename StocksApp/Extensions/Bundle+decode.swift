//
//  Bundle+Decodable.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 05.04.2021.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        let decoder = JSONDecoder()

        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("No such file")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("")
        }

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode JSON.")
        }
        return loaded
    }
}
