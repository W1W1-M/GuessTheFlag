//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by William Mead on 03/06/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var countries: Array<String> = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctFlag: Int = Int.random(in: 0...2)
    @State private var scorePresented: Bool = false
    @State private var playerScore: Int = 0
    @State private var answerText: String = ""
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.mint, .indigo]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.primary)
                Spacer()
                VStack {
                    Text("Pick the flag of")
                        .font(.headline.bold())
                        .foregroundStyle(.secondary)
                    Text(countries[correctFlag])
                        .font(.largeTitle)
                        .foregroundStyle(.primary)
                    ForEach(0..<3) { i in
                        Button {
                            if i == correctFlag {
                                playerScore += 1
                                answerText = "Well done 😀, \(countries[correctFlag]) has a cool flag"
                            } else {
                                answerText = "Oups 😢, that was the flag of \(countries[i])"
                            }
                            scorePresented = true
                        } label: {
                            Image(countries[i])
                                .renderingMode(.original)
                                //.clipShape(Capsule(style: .continuous))
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .shadow(radius: 10)
                                .padding()
                        }
                    }
                }.frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(radius: 10)
                Spacer()
                Text("Flags found: \(playerScore)")
                    .font(.title)
                    .foregroundStyle(.regularMaterial)
                    .padding()
            }.padding(30)
        }.alert(answerText, isPresented: $scorePresented) {
            Button("OK", role: .cancel) {
                countries.shuffle()
                correctFlag = Int.random(in: 0...2)
            }
        } message: {
            Text("Your have found \(playerScore) flags")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
