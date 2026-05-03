import SwiftUI

struct EventsView: View {
    let primaryPink = Color(red: 230/255, green: 103/255, blue: 199/255)
    let primaryBlue = Color(red: 126/255, green: 197/255, blue: 255/255)

    var events: [Event] = Event.mockList
    @State private var searchText: String = ""
    @State private var selectedDate: Date? = nil
    @State private var showDatePicker = false

    private var gregorian: Calendar {
        Calendar(identifier: .gregorian)
    }

    private var filtered: [Event] {
        events
            .filter {
                // filter event name or location
                guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else { return true }
                return $0.name.localizedCaseInsensitiveContains(searchText) ||
                    $0.location.localizedCaseInsensitiveContains(searchText)
            }
            .filter {
                // filter event date
                guard let selected = selectedDate else { return true }
                return gregorian.isDate($0.date, inSameDayAs: selected)
            }
            .sorted { $0.date < $1.date }
    }

    var body: some View {
        ZStack {
            // Background
            Image("bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Header
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 200)

                Text("Events")
                    .font(.custom("IrishGrover-Regular", size: 32))
                    .foregroundColor(primaryPink)

                Image("flowers")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)

                Spacer().frame(height: 20)
                
                // Filtering
                HStack(spacing: 10) {
                    // Search bar
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("name or location...", text: $searchText)
                            .font(.custom("Jua-Regular", size: 16))
                            .autocorrectionDisabled()
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(.white.opacity(0.85))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .frame(maxWidth: .infinity)
                    
                    // Date filter
                    Button {
                        if selectedDate != nil {
                            selectedDate = nil
                            showDatePicker = false
                        } else {
                            showDatePicker.toggle()
                        }
                    }
                    
                    label: {
                        HStack(spacing: 6) {
                            Image(systemName: "calendar")
                            Text(selectedDate.map {
                                DateFormatter().apply {
                                    $0.dateFormat = "dd/MM/yy"
                                    $0.calendar = Calendar(identifier: .gregorian)
                                    $0.locale = Locale(identifier: "en_GB")
                                }.string(from: $0)
                            } ?? "Date")
                            .font(.custom("Jua-Regular", size: 16))
                            
                            if selectedDate != nil {
                                Image(systemName: "xmark")
                                    .font(.system(size: 11, weight: .bold))
                            }
                        }
                        .foregroundColor(selectedDate == nil ? .gray : primaryPink)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(.white.opacity(0.85))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .frame(maxWidth: 140)
                }.padding(.horizontal, 14)

                // Calendar for selecting date
                if showDatePicker {
                    DatePicker(
                        "",
                        selection: Binding(
                            get: { selectedDate ?? Date() },
                            set: { newDate in
                                selectedDate = newDate
                                showDatePicker = false
                            }
                        ),
                        displayedComponents: .date
                    )
                    .environment(\.calendar, Calendar(identifier: .gregorian))
                    .environment(\.locale, Locale(identifier: "en_GB"))
                    .datePickerStyle(.graphical)
                    .padding(.horizontal, 20)
                    .background(.white.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal, 20)
                    .transition(.opacity)
                }

                Spacer().frame(height: 16)

                // Filtered Event List or empty state
                if filtered.isEmpty {
                    Spacer()
                    VStack(spacing: 12) {
                        Image(systemName: "calendar.badge.exclamationmark")
                            .font(.system(size: 40))
                            .foregroundColor(.gray.opacity(0.5))
                        Text("No events found")
                            .font(.custom("Jua-Regular", size: 18))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(filtered) { event in
                                EventBox(event: event)
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.bottom, 20)
    }
}

// Helper to configure DateFormatter inline
extension DateFormatter {
    func apply(_ configure: (DateFormatter) -> Void) -> DateFormatter {
        configure(self)
        return self
    }
}

#Preview {
    NavigationStack {
        EventsView()
    }
}
