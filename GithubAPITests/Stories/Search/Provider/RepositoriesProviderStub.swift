//
//  RepositoriesProviderStub.swift
//  GithubAPITests
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

@testable import GithubAPI
import Foundation

class RepositoriesProviderStub: RepositoriesProviding {
    

    
    var repositories: [Repository] = [
        Repository(id: 1,
                   fullName: "Hextris/hextris",
                   description: "It is really nice game Tetris, this text should not fit the screen, so we need to add three dots at the end of the label",
                   language: "Javascript",
                   forksCount: 2,
                   watchersCount: 24,
                   owner: RepositoryOwner(login: "Iron Man", avatarURL: "github_pic_1.jpg")),
        
        Repository(id: 2,
                   fullName: "LoveDaisy/tetris_game",
                   description: "It is really nice game Tetris, this text should not fit the screen, so we need to add three dots at the end of the label",
                   language: "C++",
                   forksCount: 2,
                   watchersCount: 24,
                   owner: RepositoryOwner(login: "Thor", avatarURL: "github_pic_2.jpg")),
        
        Repository(id: 3,
                   fullName: "dionyziz/canvas-tetris",
                   description: nil,
                   language: "Swift",
                   forksCount: 2,
                   watchersCount: 24,
                   owner: RepositoryOwner(login: "Spiderman", avatarURL: "github_pic_3.png")),
        
        Repository(id: 4,
                   fullName: "exyte/ARTetris",
                   description: "It is really nice game Tetris, this text should not fit the screen, so we need to add three dots at the end of the label",
                   language: "Objective-C",
                   forksCount: 2,
                   watchersCount: 24,
                   owner: RepositoryOwner(login: "Captain america", avatarURL: "github_pic_4.jpg"))
    ]

    func search(_ query: String, with completion: @escaping RepositoriesSearchProviderCompletion) {
        repositories = repositories.filter{ $0.fullName.contains(query) }
        completion(.success(repositories))
    }
    
}
