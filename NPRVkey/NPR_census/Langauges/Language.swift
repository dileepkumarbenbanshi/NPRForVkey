////
////  Language.swift
////  NPR-2020
////
////  Created by IOS Development Team on 28/01/21.
////  Copyright © 2021 admin. All rights reserved.
////
//
//import Foundation
//
//class Language: Codable {
//    let string, relationshipToHead, relationshipToHeadMale, relationshipToHeadFemale: [EducationQualification]
//    let relationshipToHead2, relationshipToHead2Male, relationshipToHead2Female, maritalStatus: [EducationQualification]
//    let educationQualification, occupation: [EducationQualification]
//
//    enum CodingKeys: String, CodingKey {
//        case string
//        case relationshipToHead = "relationship_to_head"
//        case relationshipToHeadMale = "relationship_to_head_male"
//        case relationshipToHeadFemale = "relationship_to_head_female"
//        case relationshipToHead2 = "relationship_to_head2"
//        case relationshipToHead2Male = "relationship_to_head2_male"
//        case relationshipToHead2Female = "relationship_to_head2_female"
//        case maritalStatus = "marital_status"
//        case educationQualification = "education_qualification"
//        case occupation
//    }
//
//    init(string: [EducationQualification], relationshipToHead: [EducationQualification], relationshipToHeadMale: [EducationQualification], relationshipToHeadFemale: [EducationQualification], relationshipToHead2: [EducationQualification], relationshipToHead2Male: [EducationQualification], relationshipToHead2Female: [EducationQualification], maritalStatus: [EducationQualification], educationQualification: [EducationQualification], occupation: [EducationQualification]) {
//        self.string = string
//        self.relationshipToHead = relationshipToHead
//        self.relationshipToHeadMale = relationshipToHeadMale
//        self.relationshipToHeadFemale = relationshipToHeadFemale
//        self.relationshipToHead2 = relationshipToHead2
//        self.relationshipToHead2Male = relationshipToHead2Male
//        self.relationshipToHead2Female = relationshipToHead2Female
//        self.maritalStatus = maritalStatus
//        self.educationQualification = educationQualification
//        self.occupation = occupation
//    }
//}
//
//// MARK: - EducationQualification
//class EducationQualification: Codable {
//    let name: String
//    let text: String?
//
//    enum CodingKeys: String, CodingKey {
//        case name = "@name"
//        case text = "#text"
//    }
//
//    init(name: String, text: String?) {
//        self.name = name
//        self.text = text
//    }
//}
