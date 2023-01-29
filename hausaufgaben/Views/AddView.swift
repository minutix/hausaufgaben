//
//  AddView.swift
//  hausaufgaben
//
//  Created by Linus Warnatz on 02.11.22.
//

import SwiftUI


struct AddView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @State private var alertPresented = false
    @State var text = ""
    @State var lesson = ""
    @State var hasDueDate = true
    @State var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    @State var difficulty = 0
    private let center = UNUserNotificationCenter.current()
    private let defaults = UserDefaults()
    
    init() {
        // Load settings
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
        NotificationCenter.default.addObserver(self, selector: Selector(("defaultsChanged")), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    var body: some View {
        VStack {
            TextField(String(localized: "Lesson"), text: $lesson)
            TextField(String(localized: "HET"), text: $text)
            Toggle(String(localized: "Has Due Date"), isOn: $hasDueDate)
            if hasDueDate {
                DatePicker(selection: $dueDate, displayedComponents: [.date], label: {Text(String(localized: "Due Date"))})
            }
            HStack() {
                Text("Difficulty Rating")
                
                Spacer()
                
                Button {
                    difficulty = 1
                } label: {
                    if difficulty < 1 {
                        Image(systemName: "star")
                    } else {
                        Image(systemName: "star.fill")
                    }
                }
                
                Button {
                    difficulty = 2
                } label: {
                    if difficulty < 2 {
                        Image(systemName: "star")
                    } else {
                        Image(systemName: "star.fill")
                    }
                }
                
                Button {
                    difficulty = 3
                } label: {
                    if difficulty < 3 {
                        Image(systemName: "star")
                    } else {
                        Image(systemName: "star.fill")
                    }
                }
                
                Button {
                    difficulty = 4
                } label: {
                    if difficulty < 4 {
                        Image(systemName: "star")
                    } else {
                        Image(systemName: "star.fill")
                    }
                }
                
                Button {
                    difficulty = 5
                } label: {
                    if difficulty < 5 {
                        Image(systemName: "star")
                    } else {
                        Image(systemName: "star.fill")
                    }
                }
            }
            Spacer()
        }
        .navigationTitle(String(localized: "Add Item"))
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if lesson != "" && text != "" {
                        //create a uuid
                        let uuidString = UUID().uuidString
                        addItem(uuid: uuidString)
                        presentationMode.wrappedValue.dismiss()
                        center.getNotificationSettings { settings in
                            guard (settings.authorizationStatus == .authorized) ||
                                  (settings.authorizationStatus == .provisional) else { return }
                            
                            let content = UNNotificationContent()
                            content.setValue("Due tomorrow", forKey: "title")
                            content.setValue("Your exercise \(text) in \(lesson) is due tomorrow and not marked as Done", forKey: "body")
                            // load set time from UserDefaults
                            let hour = defaults.integer(forKey: "notificationHour")
                            let minute = defaults.integer(forKey: "notificationMinute")
                            
                            let date = Calendar.current.dateComponents([.day, .month, .year], from: Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Calendar.current.date(byAdding: .day, value: -1, to: dueDate)!)!)
                            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
                            
                            
                            // Create the request
                            
                            let request = UNNotificationRequest(identifier: uuidString,
                                        content: content, trigger: trigger)

                            // Schedule the request with the system.
                            let notificationCenter = UNUserNotificationCenter.current()
                            notificationCenter.add(request) { (error) in
                               if error != nil {
                                  // Handle any errors.
                                  //TODO: Handle errors
                               }
                            }
                            /*
                            if settings.alertSetting == .enabled {
                                // Schedule an alert-only notification.
                                
                            } else {
                                // Schedule a notification with a badge and sound.
                            }
                            */
                        }
                    } else {
                        alertPresented = true
                    }
                    
                } label: {
                    Text("Done")
                }
                .alert("Text fields cannot be empty", isPresented: $alertPresented, actions: {Button(action: {alertPresented = false}, label: {Text("OK")})})
            }
        }
    }
    
    func addItem(uuid: String) {
        withAnimation {
            let newItem = Homework(context: viewContext)
            newItem.text = text
            newItem.lesson = lesson
            newItem.dueDate = hasDueDate ? dueDate : nil
            newItem.difficulty = Int16(difficulty)
            newItem.id = uuid
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
