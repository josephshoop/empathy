import SwiftUI

struct DilemmaView: View {
    @StateObject private var model = DilemmaModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("The Interactive Dilemma")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            
            Text("Round \(min(model.currentRound, model.maxRounds)) of \(model.maxRounds)")
                .font(.headline)
            
            HStack(spacing: 40) {
                VStack {
                    Text("Your Score")
                        .font(.subheadline)
                    Text("\(model.playerScoreTotal)")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.blue)
                }
                
                VStack {
                    Text("Opponent Score")
                        .font(.subheadline)
                    Text("\(model.opponentScoreTotal)")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.red)
                }
            }
            .padding()
            
            if model.currentRound > model.maxRounds {
                Text("Game Over")
                    .font(.title)
                    .foregroundColor(.green)
                    .padding()
                
                Button("Play Again") {
                    model.reset()
                }
                .buttonStyle(.borderedProminent)
            } else {
                Text("What will you do?")
                    .font(.title2)
                    .padding(.top)
                
                HStack(spacing: 30) {
                    Button(action: { model.playRound(playerChoice: .cooperate) }) {
                        VStack {
                            Image(systemName: "hand.shake.fill")
                                .font(.system(size: 30))
                            Text("Cooperate")
                        }
                        .padding()
                        .frame(width: 120)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                    Button(action: { model.playRound(playerChoice: .defect) }) {
                        VStack {
                            Image(systemName: "person.fill.xmark")
                                .font(.system(size: 30))
                            Text("Defect")
                        }
                        .padding()
                        .frame(width: 120)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
            }
            
            Spacer()
            
            // History
            if !model.history.isEmpty {
                VStack(alignment: .leading) {
                    Text("History")
                        .font(.headline)
                    ScrollView {
                        ForEach(model.history.reversed()) { result in
                            HStack {
                                Text("Round \(result.roundNumber):")
                                    .fontWeight(.bold)
                                Text("You ") + Text(result.playerChoice.rawValue).foregroundColor(result.playerChoice == .cooperate ? .blue : .red)
                                Text(" | Opponent ") + Text(result.opponentChoice.rawValue).foregroundColor(result.opponentChoice == .cooperate ? .blue : .red)
                            }
                            .font(.system(size: 14))
                            .padding(.vertical, 2)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DilemmaView()
}
