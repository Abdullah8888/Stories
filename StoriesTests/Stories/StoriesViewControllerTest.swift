//
//  StoriesViewControllerTest.swift
//  StoriesTests
//
//  Created by Abdullah on 11/02/2022.
//

import XCTest
@testable import Stories
import RxSwift

class StoriesViewControllerTest: XCTestCase {

    func test_CreateStories_ViewController() {
        let sut = makeSut()
        XCTAssertNotNil(sut)
    }
    
    func test_StroriesViewController_HasTableView() {
        let sut = makeSut()
        XCTAssertNotNil(sut._view.subviews.contains(sut._view.tableView))
    }

    func test_ThatTableViewHasDelegate() {
        let sut = makeSut()
        XCTAssertNotNil(sut._view.tableView.delegate)
    }
    
    func test_EmptyData() {
        let sut = makeSut(data: [])
        XCTAssertTrue(sut._view.data?.isEmpty ?? true)
    }
    
    func test_FirstEntryData() {
        let sut = makeSut()
        let cell = sut._view.tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! StoryCell
        XCTAssertEqual(cell.captionLabel.text, "caption 1")
    }
    
    func test_TableViewNumberOfRowsSection() {
        let sut = makeSut()
        XCTAssertEqual(sut._view.tableView.numberOfRows(inSection: 0), 2, "Tableview has no rows")
    }
    
    func test_CellHeight() {
        let sut = makeSut()
        let cellHeight = sut._view.tableView(sut._view.tableView, heightForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cellHeight, 400)
    }
    
    func makeSut(data: [Story] =  MockStory().data) -> StoriesViewController {
        let tableView = UITableView()
        let storiesView = StoriesView()
        tableView.tag = 4567
        storiesView.tableView = tableView
        storiesView.setup()
        storiesView.data = data
        return StoriesViewController(view: storiesView)
    }

}

struct MockStory {
    var data: [Story] {
        return [Story(caption: "caption 1", id: "001", url: "", timestamp: 1.1, video: true),
        Story(caption: "caption 2", id: "002", url: "", timestamp: 2.1, video: false)]
    }
}
