import SwiftUI
import Charts

struct EmpathyDataPoint: Identifiable {
    let id = UUID()
    let sessionNumber: Int
    let cooperationScore: Double // 0.0 to 1.0 (1.0 being highly cooperative/empathetic)
}

struct DashboardView: View {
    // We use mock data here to showcase how the reflection dashboard graphs the user's empathy development over several "sessions"
    let mockData = [
        EmpathyDataPoint(sessionNumber: 1, cooperationScore: 0.2),
        EmpathyDataPoint(sessionNumber: 2, cooperationScore: 0.35),
        EmpathyDataPoint(sessionNumber: 3, cooperationScore: 0.45),
        EmpathyDataPoint(sessionNumber: 4, cooperationScore: 0.8),
        EmpathyDataPoint(sessionNumber: 5, cooperationScore: 0.75),
        EmpathyDataPoint(sessionNumber: 6, cooperationScore: 0.9)
    ]
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Reflection Dashboard")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            
            Text("Your Empathy Index Over Time")
                .font(.headline)
            
            Chart(mockData) { point in
                LineMark(
                    x: .value("Session", point.sessionNumber),
                    y: .value("Cooperation", point.cooperationScore)
                )
                .symbol(.circle)
                .interpolationMethod(.monotone)
                
                AreaMark(
                    x: .value("Session", point.sessionNumber),
                    y: .value("Cooperation", point.cooperationScore)
                )
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.4), .blue.opacity(0.0)]), startPoint: .top, endPoint: .bottom))
            }
            .chartYAxis {
                AxisMarks(position: .leading, values: [0.0, 0.5, 1.0]) {
                    AxisValueLabel(format: .percent)
                }
            }
            .chartXAxis {
                AxisMarks(values: mockData.map { $0.sessionNumber }) { value in
                    AxisValueLabel()
                }
            }
            .frame(height: 300)
            .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Analysis")
                    .font(.title2)
                    .bold()
                
                Text("Your cooperation score has steadily increased over the last 6 sessions. This graph demonstrates the mathematical outcome of applying Roman Krznaric's principles of experiential empathy.")
                    .font(.body)
                    .lineSpacing(4)
                
                Text("The spike at Session 4 suggests a profound realization during the 'Bystander' scenario.")
                    .font(.body)
                    .lineSpacing(4)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DashboardView()
}
