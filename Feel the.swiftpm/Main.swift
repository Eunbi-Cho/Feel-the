//
//  File.swift
//  Feel the
//
//  Created by 조은비 on 2022/04/24.
//

import Foundation
import SwiftUI

struct Main: View {
//    @State private var isPresented = false
    
    var body: some View {
        
//                Button(action: { isPresented.toggle();}) {
//                                Text("Feel the Gravity")
//                            }
//                            .fullScreenCover(isPresented: $isPresented, content: {ContentView()})
//                            .padding(.horizontal, 30.0)
//                            .frame(height: 60.0)
//                            .foregroundColor(.white)
//
//                Button(action: { isPresented.toggle();}) {
//                                Text("Feel the Sound")
//                            }
//                            .fullScreenCover(isPresented: $isPresented, content: {SoundView()})
//                            .padding(.horizontal, 30.0)
//                            .frame(height: 60.0)
//                            .foregroundColor(.white)
                NavigationView{
                    ZStack {
                        Color(.black)
                            .ignoresSafeArea()
                        ScrollView(.horizontal) {
                            HStack(alignment: .center, spacing: 50) {
                        NavigationLink(destination: ContentView()) {
                                            Text("Feel the Gravity")
                                .foregroundColor(.white)
                        }
                        .frame(width: 200, height: 300, alignment: .center)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                                
                        NavigationLink(destination: SoundView()) {
                                            Text("Feel the Sound")
                                .foregroundColor(.white)
                        }
                        .frame(width: 200, height: 300, alignment: .center)
                            Spacer()
                                .frame(height:100)
                            }
                        }
                
                    }
                }
        }
    }

