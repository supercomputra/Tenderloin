//
//  Badge.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 08/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import Foundation

struct Badge {
    let title: String
    let imageURI: String
    let show: Bool
}


enum BadgeType {
    case gold
    case official
    
    func getBadge() -> Badge {
        switch self {
        case .gold:
            return Badge(title: "Gold Merchant", imageURI: "https://ecs7.tokopedia.net/img/gold-active-large.png", show: true)
        case .official:
            return Badge(title: "Official Store", imageURI: "https://ecs7.tokopedia.net/img/official_store/badge_official.png", show: true)
        }
    }
}
