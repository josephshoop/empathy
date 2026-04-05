import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "heart.text.square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.tint)
                
                Text("Empathy App Lab")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Exploring the intersection of game theory, philosophy, and human connection.")
                    .multilineTextAlignment(.center)
                    .padding()
                
                NavigationLink(destination: DilemmaView()) {
                    Text("Module 1: The Interactive Dilemma")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: PerspectiveView()) {
                    Text("Module 2: The Perspective Engine")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: DashboardView()) {
                    Text("Module 3: Reflection Dashboard")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
