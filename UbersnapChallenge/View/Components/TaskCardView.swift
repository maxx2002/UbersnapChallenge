//
//  TaskCardView.swift
//  UbersnapChallenge
//
//  Created by Maximus Aurelius Wiranata on 31/07/23.
//

import SwiftUI

struct TaskCardView: View {
    
    var task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                Text("Title")
                    .font(.title)
                    .bold()
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Edit")
                }
            }
            
            HStack(alignment: .center, spacing: 4) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title3)
                    .foregroundColor(.green)
                
                Text("Completed")
                    .fontWeight(.semibold)
            }
            
            Text("Description")
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.primary, lineWidth: 2)
        )
        .padding()
    }
}

struct TaskCardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCardView(task: Task())
//            .preferredColorScheme(.dark)
    }
}
