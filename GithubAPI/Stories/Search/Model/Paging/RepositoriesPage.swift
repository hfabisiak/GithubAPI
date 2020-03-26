import Foundation

struct RepositoriesPage {
    let results: [Repository]
    let pageIndex: Int
    let nextPageIndex: Int?
    let numberOfAllRepositories: Int
}
