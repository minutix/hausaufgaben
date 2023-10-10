//
//  StarView.swift
//  hausaufgaben
//
//  Created by Linus Warnatz on 09.09.23.
//

import SwiftUI

struct StarView: View {
    let difficulty: Int
    var body: some View {
        HStack {
            if difficulty < 1 {
                Image(systemName: "star")
            } else {
                Image(systemName: "star.fill")
            }
            if difficulty < 2 {
                Image(systemName: "star")
            } else {
                Image(systemName: "star.fill")
            }
            if difficulty < 3 {
                Image(systemName: "star")
            } else {
                Image(systemName: "star.fill")
            }
            if difficulty < 4 {
                Image(systemName: "star")
            } else {
                Image(systemName: "star.fill")
            }
            if difficulty < 5 {
                Image(systemName: "star")
            } else {
                Image(systemName: "star.fill")
            }
        }
    }
}

struct StarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ForEach(1...5, id: \.self) { diff in
                StarView(difficulty: diff)
            }
        }
    }
}
