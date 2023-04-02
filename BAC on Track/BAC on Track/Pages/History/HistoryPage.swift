//
//  InfoPage.swift
//  BAC on Track
//
//  Created by Vincent Chen on 2/19/23.
//

import SwiftUI
import Charts

struct HistoryPage: View {
    let items = HistoryParser.getHistory();
        
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(items) { item in
                    ListItemView(item: item)
                }
                .listRowBackground(Color.gray.opacity(0.2))
            }
            .buttonStyle(.automatic)
        }.padding(.top, UIScreen.main.focusedView?.safeAreaInsets.top)
    }
    
    struct ListItemView: View {
        let item: History
        
        @State private var showDetails = false
        @State private var isExpanded = false
        @State private var selectedItem: History?
        
        var body: some View {
            HStack {
                Text(item.id)
                    .font(.headline)
                    .padding(.trailing)
                
                Spacer()
                Image(systemName: isExpanded && selectedItem == item ? "chevron.up" : "chevron.down")
            }
            .onTapGesture {
                withAnimation {
                    if selectedItem == item {
                        isExpanded.toggle()
                    } else {
                        selectedItem = item
                        isExpanded = true
                    }
                }
            }
            if isExpanded && selectedItem == item {
                GroupBox ( "BAC") {
                    Chart(item.measurements) {
                        LineMark(
                            x: .value("Time", $0.id),
                            y: .value("BAC", $0.bac)
                        )
                        
                    }
                }
                .padding()
            }
        }
    }
}

struct HistoryPage_Previews: PreviewProvider {
    static var previews: some View {
        HistoryPage()
    }
}
