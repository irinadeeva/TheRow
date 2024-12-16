//
//  ContentView.swift
//  TheRow
//
//  Created by Irina Deeva on 16/12/24.
//

import SwiftUI

struct ContentView: View {
  private let number = 10
  @State private var size: CGSize = CGSize.zero
  @State private var isDiagonal: Bool = false

  var body: some View {
    GeometryReader { geometry in
      customLayout(in: size, isDiagonal: isDiagonal)
        .animation(.default, value: size)
        .onTapGesture {
          if size == CGSize.zero {
            isDiagonal.toggle()
            size = geometry.size
          } else {
            isDiagonal.toggle()
            size = CGSize.zero
          }
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
    }
  }

  func customLayout(in size: CGSize, isDiagonal: Bool) -> some View {
    let squareSize = size.height/CGFloat(number)
    let padding = squareSize == 0 ? 2 : squareSize / 4

    return HStack(alignment: .rectangleAlignment, spacing: 0) {
      ForEach(0..<number) { index in
        Rectangle()
          .fill(.blue)
          .aspectRatio(1.0, contentMode: .fit)
          .cornerRadius(isDiagonal ? 16 : 8)
          .alignmentGuide(.rectangleAlignment) { _ in
            CGFloat(CGFloat(index) * CGFloat(squareSize))
          }
          .padding(isDiagonal ? -padding : padding)
      }
    }
  }
}

struct RectangleAlignment: AlignmentID {
  static func defaultValue(in d: ViewDimensions) -> CGFloat {
    return d[VerticalAlignment.center]
  }
}

extension VerticalAlignment {
  static let rectangleAlignment = VerticalAlignment(RectangleAlignment.self)
}

#Preview {
  ContentView()
}
