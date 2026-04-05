import Foundation

enum Choice: String, CaseIterable {
    case cooperate = "Cooperate"
    case defect = "Defect"
}

struct RoundResult: Identifiable {
    let id = UUID()
    let roundNumber: Int
    let playerChoice: Choice
    let opponentChoice: Choice
    let playerScore: Int
    let opponentScore: Int
}

class DilemmaModel: ObservableObject {
    @Published var currentRound: Int = 1
    @Published var playerScoreTotal: Int = 0
    @Published var opponentScoreTotal: Int = 0
    @Published var history: [RoundResult] = []
    
    let maxRounds: Int = 10
    
    // Opponent uses a simple Tit-for-Tat strategy
    private func getOpponentChoice() -> Choice {
        if let lastRound = history.last {
            return lastRound.playerChoice
        }
        return .cooperate // Starts by cooperating
    }
    
    func playRound(playerChoice: Choice) {
        guard currentRound <= maxRounds else { return }
        
        let opponentChoice = getOpponentChoice()
        var pScore = 0
        var oScore = 0
        
        switch (playerChoice, opponentChoice) {
        case (.cooperate, .cooperate):
            pScore = 3
            oScore = 3
        case (.cooperate, .defect):
            pScore = 0
            oScore = 5
        case (.defect, .cooperate):
            pScore = 5
            oScore = 0
        case (.defect, .defect):
            pScore = 1
            oScore = 1
        }
        
        let result = RoundResult(
            roundNumber: currentRound,
            playerChoice: playerChoice,
            opponentChoice: opponentChoice,
            playerScore: pScore,
            opponentScore: oScore
        )
        
        history.append(result)
        playerScoreTotal += pScore
        opponentScoreTotal += oScore
        currentRound += 1
    }
    
    func reset() {
        currentRound = 1
        playerScoreTotal = 0
        opponentScoreTotal = 0
        history = []
    }
}
