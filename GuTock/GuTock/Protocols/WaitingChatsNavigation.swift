//
//  WaitingChatsNavigation.swift
//  GuTock
//
//  Created by Владимир Гуль on 31.05.2021.
//

import Foundation

protocol WaitingChatsNavigation: class {
    func removeWaitingChat(chat: MChat)
    func changeToActive(chat: MChat)
}
