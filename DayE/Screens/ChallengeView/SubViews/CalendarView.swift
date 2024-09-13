//
//  CalendarView.swift
//  DayE
//
//  Created by Esther Ramos on 21/02/24.
//

import SwiftUI
import SwiftData

struct CalendarView: View, AccessesChallengeOfTheDay {
    @Bindable var vm: ChallengeViewModel
    @Query var challengeDays: [ChallengeDay]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if vm.displayingCalendar {
                tapToDismissBackground
                toolbarCalendarView
            }
        }
        .animation(.easeInOut(duration: 0.25), value: vm.displayingCalendar)
        .onAppear {
            generateChallenge(for: .now)
            loadEssay(for: .now)
        }
        .onChange(of: vm.date) { _, newValue in
            if let essay = challengeOfTheDay?.essay {
                vm.essay = essay
            }
        }
    }
    
    func generateChallenge(for date: Date) {
        if locateChallenge(for: date) == nil {
            let challengeOfTheDay = ChallengeDay(challenge: Challenge(), essay: "", date: date)
            modelContext.insert(challengeOfTheDay)
        }
    }
    
    func loadEssay(for date: Date) {
        if let storedEssay = locateChallenge(for: date)?.essay {
            vm.essay = storedEssay
        }
    }
}

extension CalendarView {
    var tapToDismissBackground: some View {
        Color.black.opacity(0.01)
            .onTapGesture {
                vm.displayingCalendar = false
            }
    }
}

extension CalendarView {
    var toolbarCalendarView: some View {
        ClosureDatePicker(
            singleDay: vm.date,
            includeDays: .allDays,
            minDate: .init("2024/01/01"),
            maxDate: .now,
            results: challengeDays.calendarInfo,
            onDateSelection: { date in
                generateChallenge(for: date)
                vm.dateSelectedOnCalendar = date
                
                if let essay = challengeOfTheDay?.essay ,vm.essay == essay {
                    vm.date = vm.dateSelectedOnCalendar
                } else {
                    vm.displayingUnsavedChangesAlert = true
                }
            }
        )
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ChallengeDay.self, configurations: config)
        let vm = ChallengeViewModel()
        vm.displayingCalendar = true
        return CalendarView(vm: vm)
            .modelContainer(container)
    } catch {
        fatalError()
    }
}
