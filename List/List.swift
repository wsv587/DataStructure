//
//  List.swift
//  List
//
//  Created by sw on 2018/5/15.
//  Copyright © 2018年 ws. All rights reserved.
//

import Foundation


let MAXSIZE = 20 // 线性表的最大长度

typealias ElemType = Int

// 线性表的顺序存储的结构代码，如下：
struct SqList {
    // var data = [ElemType]() // 一维数组村粗数据元素，最大值为MAXSIZE
    var data = Array(repeating: -1, count: MAXSIZE) // 或者使用默认值初始化一个指定大小的数组
    var length = 0 // 线性表当前长度
}

/*
 线性表的定义是从1开始的，而C语言中数组是从0开始第一个下标的，于是线性表的第i个元素就是数组中下标为i-1的元素
 */

// 线性表的顺序存储结构获得元素的操作，如下:
// 假设线性表L已经存在 1<= i <= listLength(L),用元素e返回L中第i个元素的值
func getElem(L: SqList, i: Int, e: inout ElemType) -> Bool {
    if L.length == 0 || i < 1 || i > L.length {
        return false
    }
    e = L.data[i - 1]
    
    return true
}

// 线性表的顺序存储结构插入元素的操作，如下：
// 假设线性表L已经存在 1<= i <= listLength(L)，在L中第i个位置之前插入新的数据元素e，l的长度+1
func insertElem(L: inout SqList, i: Int, e: ElemType) -> Bool {
    
    guard L.length < MAXSIZE else { // 线性表已满
        return false
    }
    guard i >= 1 && i <= MAXSIZE + 1 else { // 数组越界
        return false
    }
    
    //var k = 0
    if i <= L.length { // 待插入的元素不在末尾
        for k in L.length - 1 ... i - 1 { // 把下标在i-1之后的元素向后移动
            L.data[k+1] = L.data[k]
        }
    }
    
    L.data[i - 1] = e
    L.length += 1
    
    return true
}

// 线性表的顺序存储结构删除元素的操作，如下：
// 假设线性表L已经存在 1<= i <= listLength(L)，删除L的第i个数据元素，并用e返回其值，L的长度-1
func elemDeleate(L: inout SqList, i: Int, e: inout ElemType) -> Bool {
    guard L.length > 1 else { // 空表
        return false
    }
    guard i >= 1 && i <= L.length else { // 越界
        return false
    }
    
    e = L.data[i - 1]
    
    if i < L.length { // 删除的不是最后一个元素
        // 第i个元素后面的所有元素向前移动
        for k in i ... L.length - 1 {
            L.data[k - 1] = L.data[k]
        }
    }
    
    L.length -= 1
    
    return true
}

/**
 * 线性表的存储结构的优缺点：
 优点： 无需为表中的元素的逻辑增加额外的存储空间
 可以快速的存取表中的任一位置的元素
 
 缺点：
 插入和删除操作需要移动大量元素
 当线性表长度变大时，难以确定存储空间的容量
 造成存储空间的“碎片”
 */

