//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by Fisher on 2024-01-16.
//

import SwiftUI

struct NewScrumSheet: View {
    
    @Binding var isPresentingNewScrumView: Bool
    @Binding var scrums: [DailyScrum]
    @State var newScrum = DailyScrum.emptyScrum
    
    var body: some View {
        
        NavigationStack {
            DetailEditView(scrum: $newScrum)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        
                        Button("Dismiss") {
                            isPresentingNewScrumView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        
                        Button("Add") {
                            
                            scrums.append(newScrum)
                            isPresentingNewScrumView = false
                        }
                    }
                }
        }
    }
}

#Preview {
    NewScrumSheet(isPresentingNewScrumView: .constant(true), scrums: .constant(DailyScrum.sampleData))
}
