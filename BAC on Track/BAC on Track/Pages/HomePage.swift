//
//  ContentView.swift
//  BAC on Track
//
//  Created by Vincent Chen on 2/19/23.
//

import SwiftUI

struct HomePage: View {
    @State private var text2 = "text2"
    @State private var bac = 0.00
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Status: \(BACLevelCoordinator.getStateText(for: bac))")
                .foregroundColor(BACLevelCoordinator.getInvertedStateColor(for: bac))
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(BACLevelCoordinator.getStateColor(for: bac))
                )
            
            CircularProgressBar(progress: bac)
            
            (Text("What does a bac of \(String(format: "%.2f", bac)) mean?")
                .font(.system(size: 24))
                +
                Text("\n\n\(BACLevelCoordinator.getDescriptionText(for: bac))")
                .font(.system(size: 16)))
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 180)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color(hue: 0, saturation: 0, brightness: 0.9))
            )
            
            HStack(spacing: 16) {
                Button(action: decreaseBAC) {
                    Text("[DEBUG] Decrease BAC")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                Button(action: increaseBAC) {
                    Text("[DEBUG] Increase BAC")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
    }
    
    //test function
    private func decreaseBAC() {
        bac = CGFloat(max(bac - 0.01, 0.0));
    }
    
    //test function
    private func increaseBAC() {
        bac += 0.01
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

struct CircularProgressBar: View {
    let progress: Double
    private let roundedCapOffset = 0.01; //rounded cap adds thickness
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: 20)
            Circle()
                .trim(from: roundedCapOffset, to: CGFloat(min(progress/0.13, 1.0 + roundedCapOffset))) //0.1 is max - probably make it into a constant
                .stroke(
                    BACLevelCoordinator.getStateColor(for: progress),
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .round
                    ))
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear)
            Text("BAC: \(String(format: "%.2f", progress))")
                .font(.largeTitle)
                .bold()
        }
        .padding()
    }
}

//FIXME: refactor to have one function that returns a data object
struct BACLevelCoordinator {
    public static func getStateColor(for bac: Double) -> Color {
        switch bac {
        case 0..<0.07:
            return .green
        case 0.03..<0.10:
            return .yellow
        default:
            return .red
        }
    }
    
    //for text that displays on top of the state
    public static func getInvertedStateColor(for bac: Double) -> Color {
        switch bac {
        case 0..<0.07:
            return .white
        case 0.03..<0.10:
            return .black
        default:
            return .white
        }
    }
    
    public static func getStateText(for bac: Double) -> String {
        switch bac {
        case 0:
            return "Sober"
        case 0..<0.07:
            return "Mild"
        case 0.03..<0.10:
            return "Increased"
        default:
            return "Severe"
        }
    }
    
    //FIXME: all of this is plagarized and not properly researched: should only be used as proof of concept. Find good sources and cite for better descriptions.
    public static func getDescriptionText(for bac: Double) -> String {
        switch bac {
        case 0:
            return "You are sober. There is no alcohol in your bloodstream.\n\n\n"
        case 0..<0.03:
            return "You have slight mood elevation. The effects of alcohol may not be apparent yet.\n\n\n"
        case 0.03..<0.07:
            return "You are riding the wave. You may feel warm and more relaxed.\n\n\n"
        case 0.07..<0.10:
            return "You may have mild impairment of balance, speech, vision, and control.\n\n\n"
        case 0.10..<0.13:
            return "You may have significant impairment of motor control and judgement. A common symptom is slurred speech.\n\n\n" //FIXME: can't align to top of box, so I'm doing this instead
        default:
            return "You may have gross impairment of cognitive activies. Symptoms can include blurred vision and loss of balance. More serious symptoms can include nausea, vomiting, and loss of consciousness."
        }
    }
}
