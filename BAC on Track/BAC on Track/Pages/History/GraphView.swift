//
//  GraphView.swift
//  BAC on Track
//
//  Created by Vincent Chen on 4/2/23.
//

import Foundation
import SwiftUI

struct LineGraphView: View {
    let dataPoints: [CGFloat] // an array of data points to plot
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    // draw the grid lines
                    Path { path in
                        let yInterval = geometry.size.height / 4
                        for i in 0..<4 {
                            path.move(to: CGPoint(x: 0, y: yInterval * CGFloat(i)))
                            path.addLine(to: CGPoint(x: geometry.size.width, y: yInterval * CGFloat(i)))
                        }
                    }
                    .stroke(Color.gray, lineWidth: 1)
                    
                    // draw the line graph
                    Path { path in
                        let xInterval = geometry.size.width / CGFloat(dataPoints.count - 1)
                        let yInterval = geometry.size.height / 4
                        for i in 0..<dataPoints.count {
                            let point = CGPoint(x: xInterval * CGFloat(i), y: yInterval * (4 - dataPoints[i]))
                            if i == 0 {
                                path.move(to: point)
                            } else {
                                path.addLine(to: point)
                            }
                        }
                    }
                    .stroke(Color.blue, lineWidth: 2)
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .padding()
            
            // draw the x-axis labels
            HStack {
                Spacer()
                Text("00:00")
                Spacer()
                Text("06:00")
                Spacer()
                Text("12:00")
                Spacer()
                Text("18:00")
                Spacer()
                Text("24:00")
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
    }
}
