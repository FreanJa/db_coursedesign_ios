//
//  Post.swift
//  testMysql
//
//  Created by FreanJa L on 2022/5/30.
//

import SwiftUI

struct specialColumn: Identifiable {
    let id = UUID()
    var index: Int
    var title: String
    var subtitle: String
    var text: String
    var image: String
}

var columns = [
    specialColumn(index: 1, title: "hades", subtitle: "Battle Out of Hell", text: "Hades is a rogue-like dungeon crawler in which you defy the god of the dead as you hack and slash your way out of the Underworld of Greek myth.", image: "hades"),
    specialColumn(index: 2, title: "dead cells", subtitle: "Just one more run!", text: "Dead Cells is a rogue-lite, Castlevania-inspired action-platformer, allowing you to explore a sprawling, ever-changing castle… assuming you’re able to fight your way past its keepers.\nTo beat the game, you’ll have to master 2D 'souls-lite combat' with the ever-present threat of permadeath looming. No checkpoints. Kill, die, learn, repeat.", image: "deadcells"),
    specialColumn(index: 3, title: "sifu", subtitle: "IS ONE LIFE ENOUGH TO KNOW KUNG FU?", text: "Sifu is the story of a young Kung Fu student on a path of revenge, hunting for the murderers of his family.\nOne against all, he has no allies, and countless enemies. He has to rely on his unique mastery of Kung Fu as well as a mysterious pendant to prevail and preserve his family’s legacy.", image: "sifu"),
    specialColumn(index: 4, title: "hollow knight", subtitle: "Brave the Depths of a Forgotten Kingdom", text: "Beneath the fading town of Dirtmouth sleeps a vast, ancient kingdom. Many are drawn beneath the surface, searching for riches, or glory, or answers to old secrets.\nAs the enigmatic Knight, you’ll traverse the depths, unravel its mysteries and conquer its evils.", image: "hollow_knight"),
    specialColumn(index: 5, title: "horizontal", subtitle: "zero dawn", text: "Horizon Zero Dawn takes place in the 31st century, in a post-apocalyptic world where colossal machines dominate the land. Human civilization has regressed to tribal societies of hunters and gatherers who survive in immense forests, imposing mountain ranges, and the atmospheric ruins of their ancestors – all while the machines become increasingly powerful. The player controls Aloy, a huntress who uses her speed, cunning, and agility to stay alive and protect herself and others against the force, size, and power of the machines.", image: "horizontal2"),
]
