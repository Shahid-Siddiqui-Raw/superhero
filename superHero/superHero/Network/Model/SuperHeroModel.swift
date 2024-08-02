//
//  SuperHeroModel.swift
//  superHero
//
//  Created by Muhammed Siddiqui on 7/31/24.
//

import Foundation

// MARK: - SuperHeroModel
struct SuperHeroModel: Codable {
    let superheroes: Superheroes
    let teams: [String: Team]

    enum CodingKeys: String, CodingKey {
        case superheroes = "Superheroes"
        case teams
    }
}

// MARK: - Superheroes
struct Superheroes: Codable {
    let marvel, dc: String

    enum CodingKeys: String, CodingKey {
        case marvel = "Marvel"
        case dc = "DC"
    }
}

// MARK: - Team
struct Team: Codable {
    let name: String
    let superheroes: [String: Superhero]

    enum CodingKeys: String, CodingKey {
        case name
        case superheroes = "Superheroes"
    }
}

// MARK: - Superhero
struct Superhero: Codable {
    let name: String
    let isLeader: Bool?
}
