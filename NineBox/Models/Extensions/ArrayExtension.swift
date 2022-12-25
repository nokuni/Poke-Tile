//
//  ArrayExtension.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import Foundation

extension Array {
    
    // replace nil values by -1 from an Int array and return it.
    func removedNull(from array: [Int?]) -> [Int] {
        var array = array
        array.indices.forEach {
            if array[$0] == nil { array[$0] = -1 }
        }
        return array.compactMap { $0 }
    }
    
    // Thanks Paul Hudson
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    func columnsIndices(size: Int) -> [[Int]] {
        var result = [[Int]](repeating: [], count: size)
        for index in result.indices {
            for element in stride(from: index, to: count, by: size) {
                result[index].append(element)
            }
        }
        return result
    }
    
    // return the edge indices from a grid.
    // example: trailing indices
    // [x, x, 2]
    // [x, x, 5]
    // [x, x, 8]
    func edgeLineIndices(_ edge: GridEdge, _ rowSize: Int, _ columnSize: Int) -> [Int] {
        let indices = self.indices.map { $0 }
        switch edge {
        case .top:
            guard let topEdge = indices.chunked(into: rowSize).first else { return [] }
            return topEdge
        case .bottom:
            guard let bottomEdge = indices.chunked(into: rowSize).last else { return [] }
            return bottomEdge
        case .trailing:
            guard let rightEdge = self.columnsIndices(size: columnSize).last else { return [] }
            return rightEdge
        case .leading:
            guard let leftEdge = self.columnsIndices(size: columnSize).first else { return [] }
            return leftEdge
        }
    }
}

extension Array where Element == Array<String> {
    func twoDimensionalIndices() -> [[Int]] {
        guard !self.isEmpty else { return [[]] }
        guard let count = self.first?.count else { return [[]] }
        let joined = self.joined().map { String($0) }
        let joinedIndices = joined.indices.map { Int($0) }
        let result = joinedIndices.chunked(into: count)
        return result
    }
}

extension Array where Element == Int {
    func getAdjacentLinesIndices(from index: Int) -> [Int] {
        var result = [Int]()
        
        let rows = self.chunked(into: 4)
        let columns = self.columnsIndices(size: 4)
        
        guard let rowIndex = rows.firstIndex(where: { $0.contains(index) }) else { return [] }
        guard let columnIndex = columns.firstIndex(where: { $0.contains(index) }) else { return [] }
        let row = rows[rowIndex].filter { $0 != index }
        let column = columns[columnIndex].filter { $0 != index }
        result.append(contentsOf: row)
        result.append(contentsOf: column)
        return result
    }
}

extension Array where Element: Hashable {
    // return array of unique elements
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}

extension Array where Element: Comparable {
    // return the index of the maximum value
    func maxIndex() -> Int? {
        guard let highest = self.max() else { return nil }
        guard let index = self.firstIndex(where: { $0 == highest }) else { return nil }
        return index
    }
}

extension Array where Element: Equatable {
    // return an array of different random elements.
    func differentRandomElements(amount: Int) -> [Element] {
        guard !self.isEmpty else { return [] }
        guard self.count >= amount else { return [] }
        var array = self
        var result = [Element]()
        for _ in 0..<amount {
            let randomElement = array.randomElement()!
            let index = array.firstIndex(where: { $0 == randomElement })!
            result.append(randomElement)
            array.remove(at: index)
        }
        return result
    }
    
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
}

extension Array where Element == CardType {
    
    func containsAtLeastTypeElements(in requirement: [CardType]) -> Bool {
        let requirementSet = Set(requirement)
        for element in requirementSet {
            guard self.contains(where: { $0 == element }) else { return false }
            let requirementElementCount = requirement.filter { $0 == element }.count
            let possessedElementCount = self.filter { $0 == element }.count
            guard possessedElementCount >= requirementElementCount else { return false }
        }
        
        guard self.count >= requirement.count else { return false }
        
        return true
    }
}
