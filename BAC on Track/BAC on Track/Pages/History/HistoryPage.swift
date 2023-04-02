//
//  InfoPage.swift
//  BAC on Track
//
//  Created by Vincent Chen on 2/19/23.
//

import SwiftUI

struct HistoryPage: View {
    let items = HistoryParser.getHistory();
        
    @State private var searchText = ""
    
    var body: some View {
        VStack {
//            SearchBar(text: $searchText)
            List {
//                ForEach(items.filter { searchText.isEmpty || DateFormatter.localizedString(from: $0.day, dateStyle: .short, timeStyle: .medium).localizedCaseInsensitiveContains(searchText) }) { item in
                
//                }
                ForEach(items) { item in
                    ListItemView(item: item)
                }
                .listRowBackground(Color.gray.opacity(0.2))
            }
//            Button("Debug") {
//                print(HistoryParser.getHistory())
//            }
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
                Text("TEMP")
                .padding()
            }
        }
    }

    struct SearchBar: View {
        @Binding var text: String
        
        var body: some View {
            HStack {
                TextField("Search", text: $text)
                    .padding(.horizontal)
                    .frame(height: 44)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding()
                
                Image(systemName: "magnifyingglass")
                    .padding(.trailing)
            }
            .background(Color(.systemGray6))
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct HistoryPage_Previews: PreviewProvider {
    static var previews: some View {
        HistoryPage()
    }
}
