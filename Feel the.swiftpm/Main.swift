//
//  File.swift
//  Feel the
//
//  Created by 조은비 on 2022/04/24.
//

import Foundation
import SwiftUI

struct Main: View {
    @State private var isPresented = false
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            Button(action: { isPresented.toggle();}) {
                            Text("Feel the Gravity")
                        }
                        .fullScreenCover(isPresented: $isPresented, content: {ContentView()})
                        .padding(.horizontal, 30.0)
                        .frame(height: 60.0)
                        .foregroundColor(.white)
                    }
        }
    }

