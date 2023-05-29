//
//  SortingSegmentPicker.swift
//  Github Client
//
//  Created by Arman Sarvardin on 29.05.2023.
//

import SwiftUI
import Domain

struct SegmentPicker: View {
    @Binding var selectedSegment: SortingPickerType

    var body: some View {
        VStack {
            Picker(SortingPickerType.stars.rawValue, selection: $selectedSegment) {
                Text("Stars").tag(SortingPickerType.stars)
                Text("Forks").tag(SortingPickerType.forks)
                Text("Updated Date").tag(SortingPickerType.updated)
            }
            .pickerStyle(SegmentedPickerStyle())
            .background(Color.cyan.opacity(0.2))
            .accentColor(.cyan)
            .cornerRadius(8)
        }
        .padding()
    }
}

struct SegmentPicker_Previews: PreviewProvider {
    static var previews: some View {
        SegmentPicker(selectedSegment: .constant(.forks))
    }
}
