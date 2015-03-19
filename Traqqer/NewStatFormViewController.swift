//
//  NewStatFormViewController.swift
//  Traqqer
//
//  Created by Nathan Shayefar on 3/12/15.
//  Copyright (c) 2015 Nathan Shayefar. All rights reserved.
//

import UIKit

class NewStatFormViewController: XLFormViewController, XLFormDescriptorDelegate {
    private enum FormTag: String {
        case Name = "name"
        case Goal = "goal"
        case GoalMetadata = "goal_metadata"
        case GoalMetadata2 = "goal_metadata_2"
        case Reminder = "reminder"
        case ReminderMetadata = "reminder_metadata"
        case ShareWithFriends = "share_with_friends"
    }
    
    var statType: String?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.initializeForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initializeForm() {
        form = XLFormDescriptor(title: "Add Event")
        
        // Name section
        let nameSection = XLFormSectionDescriptor()
        form.addFormSection(nameSection)
        
        let nameRow = XLFormRowDescriptor(tag: FormTag.Name.rawValue, rowType: XLFormRowDescriptorTypeName, title: "Name")
        nameSection.addFormRow(nameRow)
        
        // Goal section
        let goalSection = XLFormSectionDescriptor()
        form.addFormSection(goalSection)
        
        let goalRow = XLFormRowDescriptor(tag: FormTag.Goal.rawValue, rowType: XLFormRowDescriptorTypeBooleanSwitch, title: "Enable goal tracking?")
        goalSection.addFormRow(goalRow)
        
        // Reminder section
        let reminderSection = XLFormSectionDescriptor()
        form.addFormSection(reminderSection)
        
        let reminderRow = XLFormRowDescriptor(tag: FormTag.Reminder.rawValue, rowType: XLFormRowDescriptorTypeBooleanSwitch, title: "Enable reminders?")
        reminderSection.addFormRow(reminderRow)
        
        //        // Share with friends section
        //        let shareWithFriendsSection = XLFormSectionDescriptor()
        //        shareWithFriendsSection.multiValuedTag = FormTag.ShareWithFriends.rawValue
        //        form.addFormSection(shareWithFriendsSection)
        
        //        // Add existing rows
        //        var friends = ["1", "2", "3"]
        //        for friend in friends {
        //            row = XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeText, title: nil)
        //            row.cellConfig["textField.placeholder"] = "Add a new tag"
        //            row.value = friend
        //            shareWithFriendsSection.addFormRow(row)
        //        }
        //        // Add an empty row
        //        row = XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeText, title: nil)
        //        row.cellConfig["textField.placeholder"] = "Add a new tag"
        //        shareWithFriendsSection.addFormRow(row)
        
        self.form = form
    }
    
    // MARK: XLFormDescriptorDelegate
    
    override func formRowDescriptorValueHasChanged(formRow: XLFormRowDescriptor!, oldValue: AnyObject!, newValue: AnyObject!) {
        super.formRowDescriptorValueHasChanged(formRow, oldValue: oldValue, newValue: newValue)
        
        println(form.formValues())
        
        if formRow.tag == nil {
            return
        }
        
        switch formRow.tag {
            
        case FormTag.Goal.rawValue:
            let isGoalEnabled = newValue as Bool
            if (isGoalEnabled) {
                self.addGoalRows(formRow)
            } else {
                self.form.removeFormRowWithTag(FormTag.GoalMetadata.rawValue)
                self.form.removeFormRowWithTag(FormTag.GoalMetadata2.rawValue)
            }
            
        case FormTag.Reminder.rawValue:
            let isReminderEnabled = newValue as Bool
            if (isReminderEnabled) {
                self.addReminderRows(formRow)
            } else {
                self.form.removeFormRowWithTag(FormTag.ReminderMetadata.rawValue)
            }
            
        default:
            println("noobs")
        }
    }
    
    func addGoalRows(parentRow: XLFormRowDescriptor) {
        // greater than or less than
        let goalMetadataRow = XLFormRowDescriptor(tag: FormTag.GoalMetadata.rawValue, rowType: XLFormRowDescriptorTypeSelectorSegmentedControl)
        goalMetadataRow.selectorOptions = [
            XLFormOptionsObject(value: "less_than", displayText: "Less than"),
            XLFormOptionsObject(value: "greater_than", displayText: "Greater than")
        ]
        self.form.addFormRow(goalMetadataRow, afterRow: parentRow)
        
        // goal target?
        let goalMetadataRow2 = XLFormRowDescriptor(tag: FormTag.GoalMetadata2.rawValue, rowType: XLFormRowDescriptorTypeInteger)
        
        if (self.statType == Constants.StatTypes.DURATION) {
            goalMetadataRow2.cellConfigAtConfigure["textField.placeholder"] = "Goal count"
        } else {
            goalMetadataRow2.cellConfigAtConfigure["textField.placeholder"] = "Goal duration (in minutes)"
        }
        self.form.addFormRow(goalMetadataRow2, afterRow: goalMetadataRow)
        
        // tracked per?
    }
    
    func addReminderRows(parentRow: XLFormRowDescriptor) {
        let reminderMetadataRow = XLFormRowDescriptor(tag: FormTag.ReminderMetadata.rawValue, rowType: XLFormRowDescriptorTypeTimeInline, title: "Remind me at ...")
        self.form.addFormRow(reminderMetadataRow, afterRow: parentRow)
    }
}
