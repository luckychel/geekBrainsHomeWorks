//
//  DataNews.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 16.11.2022.
//

import Foundation

class DataV2 {
    
    var news = [NewsV2(author: "Irina",
                           avatarAuthor: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80",
                           timePublication: "15.11.2022",
                           text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                           likeCount: 4,
                           userLikes: 2,
                           commentCount: 7
                          ),
                NewsV2(author: "Sergey",
                       avatarAuthor: "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3540&q=80",
                       timePublication: "14.11.2022",
                       text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Amet massa vitae tortor condimentum lacinia quis. Mauris sit amet massa vitae tortor condimentum lacinia. Sit amet cursus sit amet dictum sit amet justo. Est ultricies integer quis auctor. Ultrices tincidunt arcu non sodales neque. Eu facilisis sed odio morbi quis commodo odio. Neque egestas congue quisque egestas diam in. Varius quam quisque id diam. Egestas integer eget aliquet nibh praesent. Diam phasellus vestibulum lorem sed risus. Et malesuada fames ac turpis egestas sed tempus urna et. Consectetur adipiscing elit duis tristique sollicitudin nibh sit amet. Volutpat maecenas volutpat blandit aliquam etiam erat velit scelerisque. Purus sit amet volutpat consequat mauris nunc congue. Quis viverra nibh cras pulvinar mattis nunc sed blandit libero.",
                       photos: ["https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80"],
                       likeCount: 3,
                       userLikes: 6,
                       commentCount: 0),
                NewsV2(author: "Anna",
                       avatarAuthor: "https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1061&q=80",
                       timePublication: "17.11.2022",
                       text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ornare suspendisse sed nisi lacus sed. Suscipit adipiscing bibendum est ultricies integer. Elit scelerisque mauris pellentesque pulvinar pellentesque. Quis varius quam quisque id diam vel quam. Augue eget arcu dictum varius duis at consectetur lorem donec. Viverra justo nec ultrices dui sapien. Nisl tincidunt eget nullam non nisi est sit amet. Fames ac turpis egestas integer eget. Malesuada fames ac turpis egestas sed tempus urna et. Ipsum faucibus vitae aliquet nec ullamcorper sit amet. Dignissim cras tincidunt lobortis feugiat vivamus at augue eget arcu. Lectus magna fringilla urna porttitor rhoncus dolor purus. Morbi quis commodo odio aenean sed adipiscing. Nam libero justo laoreet sit amet. Felis eget nunc lobortis mattis." +
                       "Velit euismod in pellentesque massa placerat. Posuere urna nec tincidunt praesent semper feugiat nibh. Id diam maecenas ultricies mi eget. Amet volutpat consequat mauris nunc congue nisi vitae. Eu lobortis elementum nibh tellus molestie nunc. Mauris pharetra et ultrices neque. Lectus arcu bibendum at varius. Aliquam etiam erat velit scelerisque in. Sed vulputate odio ut enim blandit. Proin fermentum leo vel orci. Risus quis varius quam quisque id diam. Est lorem ipsum dolor sit amet consectetur adipiscing elit. Facilisi morbi tempus iaculis urna id volutpat lacus. Orci eu lobortis elementum nibh tellus molestie nunc. Ipsum dolor sit amet consectetur adipiscing elit. Lectus nulla at volutpat diam ut venenatis tellus. Arcu vitae elementum curabitur vitae nunc. Quam elementum pulvinar etiam non quam lacus suspendisse faucibus interdum. Facilisis volutpat est velit egestas dui. Diam quam nulla porttitor massa id neque aliquam vestibulum morbi.",
                       photos: ["https://images.unsplash.com/photo-1500259783852-0ca9ce8a64dc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80", "https://images.unsplash.com/photo-1534083264897-aeabfc7daf8a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80"],
                       likeCount: 52,
                       userLikes: 0,
                       commentCount: 21)]
}
