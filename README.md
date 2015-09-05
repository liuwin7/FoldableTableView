# FoldableTableView
A Foldable TableView And Easily Configure It. Using Swift

Using FoldItem to configure the fold tableview.

//1. add one menu item
let personalCenterItem = FoldItem(foldIdentifier: "personalItem", foldName:"Personal Center")

//2. use above menu items to configure the fold tableview 
tableView.configureFoldMenuItems([personalCenterItem])

// result 
<br>
<img src="https://github.com/liuwin7/FoldableTableView/tree/master/FoldableTableView/animationView.gif"  alt="result" />
