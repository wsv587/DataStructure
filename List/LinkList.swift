//
//  LinkList.swift
//  List
//
//  Created by sw on 2018/5/15.
//  Copyright © 2018年 ws. All rights reserved.
//

import Foundation

// 头指针    第一个节点    第二个节点    第n个节点
// 头指针 -> a1|指针域 -> a2|指针域... an|指针域（指向null）

// 线性表的链式存储的结构代码，如下：

//typealias ElemType = Int
struct Node {
    var data: ElemType?
    var next: UnsafeMutablePointer<Node>? // var next: ElemType?
}

//swift 中的typedef使用typealias替代
//以下代码相当于C语言中的 typedef struct Node *LinkList
typealias LinkList = UnsafeMutablePointer<Node>

//头指针是链表的必要元素，头结点不是
//若链表无头结点，那么头指针是指向第一个结点的指针
//头指针-> 第一个结点 -> 第二个结点 -> 第n个结点
//头指针[0900] -> a1[0900]|指针域[0800] -> a2[0800]|指针域 ... an|指针域（指向null）

//若链表有头结点，那么头指针是指向头结点
//头指针[0900] -> 头结点[0900]|指针域[0800] -> a1[0800]|指针域 ... an|指针域（指向null）

/*单链表的读取*/
//单链表L已经存在，1<=i<=ListLength(L)
//用e返回L中第i个数据元素的值

func GetElem(L: LinkList, i: Int, e: UnsafeMutablePointer<ElemType>?) -> Bool {
    guard i > 0 else {
        return false
    }
    
    var j: Int = 0
    var p: LinkList?
    p = L.pointee.next
    while p != nil && j < i { // 注意边界条件 是 j< i 而非 j <= i
        p = p?.pointee.next
        j += 1
    }
    
    guard p != nil else {
        return false
    }

    e?.pointee = (p?.pointee.data)!
    
    return true
}

/*单链表的插入*/
//单链表L已经存在，1<=i<=ListLength(L)
//在单链表的第i个位置插入元素e
func InsertElem(L: LinkList, i: Int, e: ElemType) -> Bool {
    guard i >= 0 else {
        return false
    }
    var j: Int = 0
    var p: LinkList?
    p = L.pointee.next
    
    while p != nil && j < i {
        p = p?.pointee.next
        j += 1
    }
    
    guard p != nil else {
        return false
    }
    
    let node: Node = Node(data: e, next: nil)
    let nodePtr: UnsafeMutablePointer<Node> = UnsafeMutablePointer.allocate(capacity: 1)
    nodePtr.initialize(to: node)
    
    if p?.pointee.next != nil { // p不是最后一个元素
        nodePtr.pointee.next = p?.pointee.next
        p?.pointee.next = nodePtr

    } else { // p是最后一个元素
        p?.pointee.next = nodePtr
        nodePtr.pointee.next = nil
    }
    
    return true
}

/*单链表的删除*/
//单链表L已经存在，1<=i<=ListLength(L)
//删除单链表第i个元素
func DeleteElem(L: LinkList, i: Int) -> Bool {
    guard i >= 0 else {
        return false
    }
    
    var j: Int = 0
    var p: LinkList?
    p = L.pointee.next
    
    while p != nil && j < i {
        p = p?.pointee.next
        j += 1
    }
    
    guard p != nil else {
        return false
    }
    
    //修改指向
    let q = p?.pointee.next
    p?.pointee.next = q?.pointee.next
    //以上两句等同于下面一句
    //p?.pointee.next = p?.pointee.next?.pointee.next
    
    //释放p.next节点
//    q?.deallocate()
//    q?.deinitialize(count: 0)
    
    return true
}

/*单链表的整表创建*/
//方式1:
func GetLinkList(length: Int) -> LinkList {
    
    let header: Node = Node(data: 0, next: nil)
    let L = LinkList.allocate(capacity: 1)
    L.initialize(to: header)
    
    //不能用节点变量的方式保存上一个节点，因为节点是结构体，值传递
    //var preNode: Node = header
    //var preNodePtr: UnsafeMutablePointer<Node> = UnsafeMutablePointer.allocate(capacity: 1)
    var preNodePtr: UnsafeMutablePointer<Node> = L
    
    preNodePtr.initialize(to: header)
    for i in 0 ..< length {
        let node: Node = Node(data: i + 1, next: nil)
        let nodePtr = UnsafeMutablePointer<Node>.allocate(capacity: 1)
        nodePtr.initialize(to: node)
        //preNode.next = nodePtr
        //preNode = node
        preNodePtr.pointee.next = nodePtr
        preNodePtr = nodePtr
    }
    return L
}

//方式2：
func CreateLinkList(length: Int) -> LinkList {
    
    let header: Node = Node(data: -1, next: nil)
    let L: LinkList = LinkList.allocate(capacity: 1)
    print("L 地址：\(L)")
    
    L.initialize(to: header)
    print("L 地址：\(L)")
    
    for i in 0 ..< length {
        //创建新节点
        let node: Node = Node(data: i+1, next: nil)
        //节点指针
        let nodePtr = UnsafeMutablePointer<Node>.allocate(capacity: 1)
        nodePtr.initialize(to: node)
        //节点插入到链表头部
        nodePtr.pointee.next = L.pointee.next
        L.pointee.next = nodePtr
    }
    return L
}

/*单链表的整表删除*/
func DeleteLinkList(L: LinkList) -> Bool {
    var p: UnsafeMutablePointer<Node>? = L.pointee.next
    var q: UnsafeMutablePointer<Node>?
    while p != nil {
        q = p?.pointee.next
        
        p?.deallocate()
        p?.deinitialize(count: 1)
        p = q
        
    }
    
    L.pointee.next = nil
    
    return true
}


/*给定一个不为空的单链表L，输出各个节点的值*/
func printElem(L: LinkList) {
    
    var p: LinkList?
    p = L.pointee.next
    
    while p != nil {
        print(p?.pointee.data ?? -999)
        p = p?.pointee.next
    }
}

