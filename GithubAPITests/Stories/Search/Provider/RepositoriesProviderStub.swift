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
    
    var repositories: [Repository] {
        let repositoryOwners: [RepositoryOwner] = [
            RepositoryOwner(login: "Iron Man", avatarURL: "github_pic_1.jpg"),
            RepositoryOwner(login: "Thor", avatarURL: "github_pic_2.jpg"),
            RepositoryOwner(login: "Spiderman", avatarURL: "github_pic_3.png"),
            RepositoryOwner(login: "Captain america", avatarURL: "github_pic_4.jpg")
        ]
        
        let repositories: [Repository] = [
            Repository(id: 1,
                       fullName: "Hextris/hextris",
                       description: "It is really nice game Tetris, this text should not fit the screen, so we need to add three dots at the end of the label",
                       language: "Javascript",
                       forksCount: 2,
                       watchers: 24,
                       owner: repositoryOwners[0]),
            
            Repository(id: 2,
                       fullName: "LoveDaisy/tetris_game",
                       description: "It is really nice game Tetris, this text should not fit the screen, so we need to add three dots at the end of the label",
                       language: "C++",
                       forksCount: 2,
                       watchers: 24,
                       owner: repositoryOwners[1]),
            
            Repository(id: 3,
                       fullName: "dionyziz/canvas-tetris",
                       description: "short description",
                       language: "Swift",
                       forksCount: 2,
                       watchers: 24,
                       owner: repositoryOwners[2]),
            
            Repository(id: 4,
                       fullName: "exyte/ARTetris",
                       description: "It is really nice game Tetris, this text should not fit the screen, so we need to add three dots at the end of the label",
                       language: "Objective-C",
                       forksCount: 2,
                       watchers: 24,
                       owner: repositoryOwners[3])
        ]
    
        return repositories
    }

    func search(_ query: String, with completion: @escaping RepositoriesSearchProviderCompletion) {
        completion(.success(repositories))
    }
    
}
