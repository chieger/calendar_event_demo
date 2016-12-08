//
//  ComposeViewController.swift
//  calendar_demo
//
//  Created by Charles Hieger on 12/7/16.
//  Copyright © 2016 Charles Hieger. All rights reserved.
//

import UIKit
import EventKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var bodyTextView: UITextView!

    @IBAction func didTapPostToCalendar(_ sender: Any) {
        let eventStore = EKEventStore()
        let defaultCalendar = eventStore.defaultCalendarForNewEvents

        /// Create the event
        let newEvent = EKEvent(eventStore: eventStore)
        /// Configure event properties
        newEvent.calendar = defaultCalendar
        newEvent.title = titleTextView.text ?? "Some super cool event!"
        newEvent.notes = bodyTextView.text ?? "We are doing something"
        let nowDate = Date()
        newEvent.startDate = nowDate
        let halfHourInSeconds = TimeInterval(30 * 60)
        let halfHourLater = nowDate.addingTimeInterval(halfHourInSeconds)
        newEvent.endDate = halfHourLater

        do {
        try eventStore.save(newEvent, span: .thisEvent, commit: true)
            print("calendar event saved yo!")
            dismiss(animated: true, completion: nil)
        } catch {
            print(error.localizedDescription)
        }
    }

    @IBAction func didPressCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
