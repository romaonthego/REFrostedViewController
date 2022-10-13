import PackageDescription

let package = Package(
    name: "REFrostedViewController",
    products: [
       .library(name: "REFrostedViewController", targets: ["REFrostedViewController"])
   ],
   targets: [
       .target(
           name: "REFrostedViewController",
           path: "REFrostedViewController"
       )
   ]
)
