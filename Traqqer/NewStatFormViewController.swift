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
        case StatType = "stat_type"
        case Goal = "goal"
        case GoalMetadata = "goal_metadata"
        case GoalMetadata2 = "goal_metadata_2"
        case Reminder = "reminder"
        case ReminderMetadata = "reminder_metadata"
        case ShareWithFriends = "share_with_friends"
    }
    
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
        
        // Stat type
        let statTypeRow = XLFormRowDescriptor(tag: FormTag.StatType.rawValue, rowType: XLFormRowDescriptorTypeSelectorSegmentedControl)
        statTypeRow.selectorOptions = [
            XLFormOptionsObject(value: Constants.StatTypes.COUNT, displayText: "Count"),
            XLFormOptionsObject(value: Constants.StatTypes.DURATION, displayText: "Duration")
        ]
        statTypeRow.value = XLFormOptionsObject(value: Constants.StatTypes.COUNT, displayText: "Count")
        nameSection.addFormRow(statTypeRow)
        
        // Name row
        let nameRow = XLFormRowDescriptor(tag: FormTag.Name.rawValue, rowType: XLFormRowDescriptorTypeName, title: "Name")
        nameRow.cellConfig["textField.textAlignment"] = NSTextAlignment.Right.rawValue

        nameSection.addFormRow(nameRow)
        
        // Goal section
        let goalSection = XLFormSectionDescriptor()
        form.addFormSection(goalSection)
        
        // Goal row
        let goalRow = XLFormRowDescriptor(tag: FormTag.Goal.rawValue, rowType: XLFormRowDescriptorTypeBooleanSwitch, title: "Enable goal tracking?")
        goalSection.addFormRow(goalRow)
        
        // Reminder section
        let reminderSection = XLFormSectionDescriptor()
        form.addFormSection(reminderSection)
        
        // Reminder row
        let reminderRow = XLFormRowDescriptor(tag: FormTag.Reminder.rawValue, rowType: XLFormRowDescriptorTypeBooleanSwitch, title: "Enable reminders?")
        reminderSection.addFormRow(reminderRow)
        
        self.form = form
        
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
    }
    
    // MARK: XLFormDescriptorDelegate
    
    override func formRowDescriptorValueHasChanged(formRow: XLFormRowDescriptor!, oldValue: AnyObject!, newValue: AnyObject!) {
        super.formRowDescriptorValueHasChanged(formRow, oldValue: oldValue, newValue: newValue)
        
//        println(form.formValues())
        
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
    
    private func addGoalRows(parentRow: XLFormRowDescriptor) {
        // greater than or less than
        let goalMetadataRow = XLFormRowDescriptor(tag: FormTag.GoalMetadata.rawValue, rowType: XLFormRowDescriptorTypeSelectorSegmentedControl)
        goalMetadataRow.selectorOptions = [
            XLFormOptionsObject(value: Constants.GoalTypes.LESS_THAN, displayText: "Less than"),
            XLFormOptionsObject(value: Constants.GoalTypes.MORE_THAN, displayText: "Greater than")
        ]
        goalMetadataRow.value = XLFormOptionsObject(value: Constants.GoalTypes.LESS_THAN, displayText: "Less than")
        self.form.addFormRow(goalMetadataRow, afterRow: parentRow)
        
        // goal target
        let goalMetadataRow2 = XLFormRowDescriptor(tag: FormTag.GoalMetadata2.rawValue, rowType: XLFormRowDescriptorTypeInteger)
        goalMetadataRow2.cellConfig["textField.textAlignment"] = NSTextAlignment.Right.rawValue
        
        let statTypeRow = self.form.formRowWithTag(FormTag.StatType.rawValue)
        let statType = (statTypeRow.value as XLFormOptionsObject).formValue() as String
        println(statType)
        
        if (statType == Constants.StatTypes.DURATION) {
            goalMetadataRow2.cellConfigAtConfigure["textField.placeholder"] = "Goal duration (in minutes)"
        } else {
            goalMetadataRow2.cellConfigAtConfigure["textField.placeholder"] = "Goal count"
        }
        self.form.addFormRow(goalMetadataRow2, afterRow: goalMetadataRow)
    }
    
    private func addReminderRows(parentRow: XLFormRowDescriptor) {
        let reminderMetadataRow = XLFormRowDescriptor(tag: FormTag.ReminderMetadata.rawValue, rowType: XLFormRowDescriptorTypeTimeInline, title: "Remind me at ...")
        self.form.addFormRow(reminderMetadataRow, afterRow: parentRow)
    }
}
