//
//  Clips.swift
//  Clip
//
//  Created by Ryan on 09/11/2022.
//
//  Ryan Morgan

import Foundation
import SwiftUI

//defines structure so clips are identifiable and can have additional data stored
struct Clip: Identifiable{
    let id = UUID()
    let title: String
    let channel: String
    let videoID: String
}

//defines structure so categories are identifiable and can have additional data stored
struct categories: Identifiable{
    let id = UUID()
    let category: String
    let emoji: String
    let clipGroup: [Clip]
}

//list of clips for the 'funny' category
let clipsFunny = [
    Clip(title: "Guilty Dog", channel: "bmazz007", videoID: "Xroaw3bLxuE"),
    Clip(title: "Drive through worker throws drink in man's car after cheeky prank", channel: "Kristine John", videoID: "_Q0ic6iDJJk"),
    Clip(title: "Flutterbye fairy toy flies into fire O'Fortuna", channel: "Animetist", videoID: "GzgavGowD_A"),
    Clip(title: "Taxi Driver falls in Sink Hole! FAIL!!!", channel: "kartoffelninjaaa", videoID: "kWfFsyxQGU4"),
    Clip(title: "10 dollar tip 🙏🏾📍😩😩", channel: "Slv_Soundss", videoID: "coyMil9mV9o"),
    Clip(title: "xQc cheeto", channel: "lenny virgulak", videoID: "XdI3NaaGAeo"),
    Clip(title: "Crazy Laughing Dolphin!", channel: "Dolphin's Life", videoID: "dwEDgSECGiU"),
    Clip(title: "Tennis Ball Boy Runs Into Wall!", channel: "Rev Wicks", videoID: "lSaaaMwItc4")
]

//list of clips for the 'music' category
let clipsMusic = [
    Clip(title: "Janji - Heroes Tonight (feat. Johnning) [NCS Release]", channel: "NoCopyrightSounds", videoID: "3nQNiWdeH2Q"),
    Clip(title: "DEAF KEV - Invincible [NCS Release]", channel: "NoCopyrightSounds", videoID: "J2X5mJ3HDYE"),
    Clip(title: "Different Heaven & EH!DE - My Heart [NCS Release]", channel: "NoCopyrightSounds", videoID: "jK2aIUmmdP4"),
    Clip(title: "Warriyo - Mortals (feat. Laura Brehm) [NCS Release]", channel: "NoCopyrightSounds", videoID: "yJg-Y5byMMw"),
    Clip(title: "Disfigure - Blank [NCS Release]", channel: "NoCopyrightSounds", videoID: "p7ZsBPK656s"),
    Clip(title: "Elektronomia - Sky High [NCS Release]", channel: "NoCopyrightSounds", videoID: "TW9d8vYrVFQ"),
    Clip(title: "Electro-Light - Symbolism [NCS Release]", channel: "NoCopyrightSounds", videoID: "__CRWE-L45k"),
    Clip(title: "Tobu - Hope [NCS Release]", channel: "NoCopyrightSounds", videoID: "EP625xQIGzs")
]

//list of clips for the 'vine' category
let clipsVine = [
    Clip(title: "Fresh Avocado Vine", channel: "KD5", videoID: "bE4C8a48o1E"),
    Clip(title: "Squidward dabbing vine", channel: "Harry West", videoID: "86LqlzZvkRI"),
    Clip(title: "I'm in my moms car vine", channel: "Bo Pi", videoID: "5LfeJdpk3K4"),
    Clip(title: "It's an Avocado !", channel: ":D", videoID: "wG2-y5Yf1Oo"),
    Clip(title: "Bieber interview laugh", channel: "Jamie Lak", videoID: "MKDkUeACN1U"),
    Clip(title: "I Smell Like Beef Original Extended Version #beefbaby - Katie Ryan", channel: "Katie Ryan", videoID: "5eZyspecXJE"),
    Clip(title: "Road work ahead? Uh yeah, I sure hope it does [Drew Gooden]", channel: "?", videoID: "9sPthPleEKo"),
    Clip(title: "Look at all those...", channel: "Bernforever", videoID: "F-X4SLhorvw")
]

//list of categories to show and select from
let clipCategories = [
    categories(category: "Music", emoji: "🎵", clipGroup: clipsMusic),
    categories(category: "Funny", emoji: "🤣", clipGroup: clipsFunny),
    categories(category: "Vine", emoji: "🤪", clipGroup: clipsVine)
]

//function which creates an array for a random order of numbers between 0 and 7 so clips are displayed randomly
func randomVideos() -> Array<Int> {
    var randomVids = [Int]()
    while (randomVids.count < 8){
        let randNum = Int.random(in: 0...7)
        if (randomVids.contains(randNum) == false){
            randomVids.append(randNum)
        }
    }
    return randomVids
}
