import Foundation

struct NarrativeChoice: Identifiable {
    let id = UUID()
    let text: String
    let nextNodeId: String
}

struct NarrativeNode: Identifiable {
    let id: String
    let narrativeText: String
    let choices: [NarrativeChoice]
    let isEnding: Bool
}

class PerspectiveModel: ObservableObject {
    @Published var currentNode: NarrativeNode?
    
    private var nodes: [String: NarrativeNode] = [:]
    
    init() {
        setupNarrative()
        currentNode = nodes["start"]
    }
    
    func selectChoice(_ choice: NarrativeChoice) {
        if let nextNode = nodes[choice.nextNodeId] {
            currentNode = nextNode
        }
    }
    
    func restart() {
        currentNode = nodes["start"]
    }
    
    private func setupNarrative() {
        // A simple branching narrative focusing on perspective and bias
        
        let startNode = NarrativeNode(
            id: "start",
            narrativeText: "You are on a crowded bus heading home after a long, exhausting shift. You notice a young individual at the front struggling to pay the fare. The driver is getting impatient, and people behind them are sighing loudly.",
            choices: [
                NarrativeChoice(text: "Offer to pay their fare.", nextNodeId: "pay_fare"),
                NarrativeChoice(text: "Look away and put on your headphones.", nextNodeId: "look_away"),
                NarrativeChoice(text: "Wait to see if someone else steps in.", nextNodeId: "wait")
            ],
            isEnding: false
        )
        
        let payFareNode = NarrativeNode(
            id: "pay_fare",
            narrativeText: "You step forward and cover the fare. The teenager looks relieved but deeply embarrassed, barely whispering a 'thank you' before hurrying to the back of the bus. You realize the cost was trivial to you, but monumental to them.",
            choices: [
                NarrativeChoice(text: "Reflect on how easily you resolved their crisis.", nextNodeId: "reflect_easy"),
                NarrativeChoice(text: "Follow them to check if they're okay.", nextNodeId: "follow_check")
            ],
            isEnding: false
        )
        
        let lookAwayNode = NarrativeNode(
            id: "look_away",
            narrativeText: "You put your headphones in, turning the volume up. A minute later, you see the teenager stepping off the bus, looking defeated. The bus pulls away, leaving them in the rain. You feel a pang of guilt.",
            choices: [
                NarrativeChoice(text: "Justify it by thinking it's not your responsibility.", nextNodeId: "justify"),
                NarrativeChoice(text: "Acknowledge the missed opportunity for connection.", nextNodeId: "acknowledge_miss")
            ],
            isEnding: false
        )
        
        let waitNode = NarrativeNode(
            id: "wait",
            narrativeText: "You wait, hoping someone else closer will help. No one does. The driver eventually tells the teenager they have to get off. The diffusion of responsibility meant everyone thought someone else would act.",
            choices: [
                NarrativeChoice(text: "Consider the 'Bystander Effect'.", nextNodeId: "bystander_effect")
            ],
            isEnding: false
        )
        
        // Endings
        let reflectEasyEnding = NarrativeNode(
            id: "reflect_easy",
            narrativeText: "Empathy often requires us to recognize our own privilege in a situation. What is a small gesture for one person can be a lifeline for another.\n\n[End of Scenario]",
            choices: [],
            isEnding: true
        )
        
        let followCheckEnding = NarrativeNode(
            id: "follow_check",
            narrativeText: "You approach them later, but they seem defensive. True empathy also requires respecting boundaries and understanding that receiving charity can be a vulnerable, sometimes shameful experience for the recipient.\n\n[End of Scenario]",
            choices: [],
            isEnding: true
        )
        
        let justifyEnding = NarrativeNode(
            id: "justify",
            narrativeText: "It is easy to numb our empathy to survive in a complex world. But constructing walls to avoid the discomfort of others' struggles ultimately isolates us from human connection.\n\n[End of Scenario]",
            choices: [],
            isEnding: true
        )
        
        let acknowledgeMissEnding = NarrativeNode(
            id: "acknowledge_miss",
            narrativeText: "Recognizing our failures of empathy is the first step toward building the 'empathy muscle'. Awareness of our inaction primes us to act differently next time.\n\n[End of Scenario]",
            choices: [],
            isEnding: true
        )
        
        let bystanderEnding = NarrativeNode(
            id: "bystander_effect",
            narrativeText: "The Bystander Effect reveals a flaw in human social processing: we assume others will step in. Active empathy requires overcoming this social inertia and taking personal responsibility for the welfare of others.\n\n[End of Scenario]",
            choices: [],
            isEnding: true
        )
        
        let allNodes = [startNode, payFareNode, lookAwayNode, waitNode,
                        reflectEasyEnding, followCheckEnding, justifyEnding,
                        acknowledgeMissEnding, bystanderEnding]
        
        for node in allNodes {
            nodes[node.id] = node
        }
    }
}
