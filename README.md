# FoldableTableView
A Foldable TableView And Easily Configure It. Using Swift!

Using FoldItem to configure the fold tableview.


```swift
//1. add one menu item
let personalCenterItem = FoldItem(foldIdentifier: "personalItem", foldName:"Personal Center")

```

```swift
//2. use above menu items to configure the fold tableview 
tableView.configureFoldMenuItems([personalCenterItem])
```

// result 
<br>
![AnimationView.gif]("https://github.com/liuwin7/FoldableTableView/raw/master/AnimationView.gif")

