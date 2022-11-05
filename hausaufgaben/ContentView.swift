//
//  ContentView.swift
//  hausaufgaben
//
//  Created by Linus Warnatz on 02.11.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var entries: Entries
    
    var body: some View {
        NavigationView {
            
            VStack {
                Text("Homework")
                    .font(.largeTitle)
                    .bold()
                List {
                    ForEach(entries.listContent, id: \.self) { item in
                        HStack {
                            VStack {
                                HStack {
                                    Text(item.lesson )
                                    Spacer()
                                }
                                HStack {
                                    Text("\(item.text ) \(item.dueDate != nil ? "—" : "" ) \(item.dueDate?.formatted(date: .numeric, time: .omitted) ?? "")")
                                    Spacer()
                                }
                            }
                            Spacer()
                            Button {
                                entries.listContent[entries.listContent.firstIndex(of: item)!].isDone.toggle()
                            } label: {
                                Image(systemName: "checkmark.circle\(item.isDone ? ".fill" : "")")
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        NavigationLink {
                            AddView()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
            }
            }
            Text("Select an item")
        }.navigationTitle(Text("Homework"))
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
