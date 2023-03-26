//
//  InfoPage.swift
//  BAC on Track
//
//  Created by Vincent Chen on 2/19/23.
//

import SwiftUI

struct ListItem: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let thumbnail: String
    let description: String
    
    static func ==(lhs: ListItem, rhs: ListItem) -> Bool {
        return lhs.id == rhs.id
    }
}

struct HistoryPage: View {
    //TODO: read from file/web server
    let items = [
        ListItem(name: "Wine", thumbnail: "wineglass", description: "[INSERT NUTRITION DATA]"),
        ListItem(name: "Water", thumbnail: "wineglass", description: "[INSERT NUTRITION DATA]"),
        ListItem(name: "Beer", thumbnail: "wineglass", description: "[INSERT NUTRITION DATA]"),
        ListItem(name: "Alcochol", thumbnail: "wineglass", description: "[INSERT NUTRITION DATA]"),
        ListItem(name: "Item 5", thumbnail: "wineglass", description: "[INSERT NUTRITION DATA]"),
        ListItem(name: "Item 6", thumbnail: "wineglass", description: "[INSERT NUTRITION DATA]"),
        ListItem(name: "Item 7", thumbnail: "wineglass", description: "[INSERT NUTRITION DATA]"),
        ListItem(name: "Item 8", thumbnail: "wineglass", description: "[INSERT NUTRITION DATA]"),
        ListItem(name: "Item 9", thumbnail: "wineglass", description: "[INSERT NUTRITION DATA]"),
        ListItem(name: "Item 10", thumbnail: "wineglass", description: "[INSERT NUTRITION DATA]"),
        ListItem(name: "Item 11", thumbnail: "wineglass", description: "[INSERT NUTRITION DATA]"),
    ]
        
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            List {
                ForEach(items.filter { searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText) }) { item in
                    ListItemView(item: item)
                }
                .listRowBackground(Color.gray.opacity(0.2))
            }
            Button("Debug") {
                print(HistoryParser.getHistory())
            }
            .buttonStyle(.automatic)
        }.padding(.top, UIScreen.main.focusedView?.safeAreaInsets.top)
    }
    
    struct ListItemView: View {
        let item: ListItem
        
        @State private var showDetails = false
        @State private var isExpanded = false
        @State private var selectedItem: ListItem?
        
        var body: some View {
            HStack {
                Image(systemName: item.thumbnail)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 44, height: 44)
                    .padding()
                
                Text(item.name)
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
                Text(item.description)
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
