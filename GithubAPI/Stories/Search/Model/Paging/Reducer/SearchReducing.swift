import Foundation

protocol SearchReducing {
    
    func reduce(oldState: SearchState,
                event: SearchServiceEvent,
                with completion: @escaping (SearchState) -> Void)
    
}
