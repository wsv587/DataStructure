//
//  LinkListTest.swift
//  List
//
//  Created by sw on 2018/6/2.
//  Copyright © 2018年 ws. All rights reserved.
//

import Foundation
class LinkListTest {
    class func getElem() {
        //创建一个单链表
        var node4: Node = Node(data: 4, next: nil)
        var node3: Node = Node(data: 3, next: &node4)
        var node2: Node = Node(data: 2, next: &node3)
        var node1: Node = Node(data: 1, next: &node2)
        let node0: Node = Node(data: nil, next: &node1) // 头结点
        
        let L: LinkList = LinkList.allocate(capacity: 1)
        L.initialize(to: node0)
        
//        var e: UnsafeMutablePointer<ElemType> = UnsafeMutablePointer.allocate(capacity: 1)
//        e.initialize(to: -1)
        var e: ElemType = 0
        let result = GetElem(L: L, i: 2, e: &e)
        
//        print("result == \(result), e == \(e.pointee)")
        print("result == \(result), e == \(e)")
    }
    
    class func insertElem() {
        let linkList = GetLinkList(length: 10)
        let result = InsertElem(L: linkList, i: 8, e: 998)
        print("插入结果：result == \(result)")
        print("插入后单链表各个节点的值:")
        printElem(L: linkList)
    }
    
    class func deleteElem() {
        let L: LinkList = CreateLinkList(length: 6)
        let result = DeleteElem(L: L, i: 3)
        print("删除结果：result == \(result)")
        print("删除后的单链表的各个节点的值:")
        printElem(L: L)
    }
    
    class func getLinkList() {
        let L = GetLinkList(length: 10)
        
        print("创建的单链表的各个节点的值1:")
        printElem(L: L)
    }
    
    class func createLinkList() {
        let L = CreateLinkList(length: 12)

        print("创建的单链表的各个节点的值2:")
        printElem(L: L)

    }
    
    class func deleteLinkList() {
        let L = CreateLinkList(length: 13)
        print("创建的单链表的各个节点的值2:")
        printElem(L: L)
        
        DeleteLinkList(L: L)
        print("删除后的单链表的各个节点的值：")
        printElem(L: L)

        
    }
}
