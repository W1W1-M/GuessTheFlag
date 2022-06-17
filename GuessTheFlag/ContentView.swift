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
    @State private var endGamePresented: Bool = false
    @State private var playerScore: Int = 0
    @State private var answerText: String = ""
    @State private var answeredQuestions: Int = 0
    private var maxQuestions: Int = 10
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.mint, .indigo]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                    .bigIndigoTitleStyle()
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
                            answeredQuestions += 1
                            scorePresented = true
                        } label: {
                            FlagView(country: countries[i])
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
                if answeredQuestions == maxQuestions {
                    endGamePresented = true
                } else {
                    countries.shuffle()
                    correctFlag = Int.random(in: 0...2)
                }
            }
        } message: {
            Text("Your have found \(playerScore) flags")
        }
        .alert("Game over", isPresented: $endGamePresented) {
            Button("New game") {
                playerScore = 0
                answeredQuestions = 0
                countries.shuffle()
                correctFlag = Int.random(in: 0...2)
            }
        } message: {
            Text("You found \(playerScore) out of \(maxQuestions) correctly")
        }
    }
}

struct FlagView: View {
    var country: String
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(radius: 10)
            .padding()
    }
}

struct BigIndigoTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundStyle(.indigo)
    }
}

extension View {
    func bigIndigoTitleStyle() -> some View {
        modifier(BigIndigoTitle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
