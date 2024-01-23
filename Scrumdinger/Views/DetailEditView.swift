//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Fisher on 2024-01-10.
//

import SwiftUI

struct DetailEditView: View {
    
    @Binding var scrum: DailyScrum
    @State private var newAttendeeName = "" // will contain the name that the user enters
    
    var body: some View {
        
        Form {
            
            Section(header: Text("Meeting Info")) {
                
                TextField("Title", text: $scrum.title) // $ creates a binding
                HStack {
                    Slider(value: $scrum.lengthInMinutesDouble, in: 5...30, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $scrum.theme)
            }
            Section(header: Text("Attendees")) {
                
                ForEach(scrum.attendees) { attendee in
                        
                    Text(attendee.name)
                }
                .onDelete { indices in
                
                    scrum.attendees.remove(atOffsets: indices)
                }
                HStack {
                    
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            scrum.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add Attendee")
                    }
                    .disabled(newAttendeeName == "")
                }
            }
        }
    }
}

#Preview {
    DetailEditView(scrum: .constant(DailyScrum.sampleData[0]))
}
