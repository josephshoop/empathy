import SwiftUI

struct PerspectiveView: View {
    @StateObject private var model = PerspectiveModel()
    
    var body: some View {
        VStack(spacing: 30) {
            if let node = model.currentNode {
                Text("The Perspective Engine")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                ScrollView {
                    Text(node.narrativeText)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(6)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.blue.opacity(0.05))
                        .cornerRadius(12)
                }
                
                VStack(spacing: 15) {
                    if node.isEnding {
                        Button("Replay Scenario") {
                            withAnimation {
                                model.restart()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.bottom, 40)
                    } else {
                        ForEach(node.choices) { choice in
                            Button(action: {
                                withAnimation {
                                    model.selectChoice(choice)
                                }
                            }) {
                                Text(choice.text)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.gray.opacity(0.1))
                                    .foregroundColor(.primary)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            } else {
                ProgressView()
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PerspectiveView()
}
