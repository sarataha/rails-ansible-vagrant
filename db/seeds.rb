F1 = Product.create(name: "Tea",
                 description: "Stay awake, drink ITI on Rails tea!",
                 price: 5)

F2 = Product.create(name: "Coffee",
                 description: "Nice mix of ITI and NTI coffee",
                 price: 5,
                 status: "available")

F3 = Product.create(name: "Pepsi",
                 description: "ghany 3an el ta3reef",
                 price: 5)

C1 = Category.create(title: "Hot Drinks",
                     description: "Keep you awake, keep you warm")

C2 = Category.create(title: "Soda",
                     description: "ghany 3an el ta3reef tany")

U1 = User.create(first_name: "Sara",
                 last_name: "Taha",
                 email: "sara@sara.com",
                 password: "whatever",
                 password_confirmation: "whatever",
                 room_no: "2005",
                 ext: "123456789")

U2 = User.create(first_name: "Nesma",
                 last_name: "Mamdouh",
                 email: "nesma@nesma.com",
                 password: "whatever",
                 password_confirmation: "whatever",
                 room_no: "2005",
                 ext: "1234")

U3 = User.create(first_name: "Mohamed",
                 last_name: "Ehab",
                 email: "mohamed@mohamed.com",
                 password: "whatever",
                 password_confirmation: "whatever",
                 room_no: "2024",
                 ext: "1234")

A1 = User.create(first_name: "Admin",
                 last_name: "Admin",
                 email: "admin@admin.com",
                 password: "iamadmin",
                 password_confirmation: "iamadmin",
                 room_no: "2024",
                 ext: "01",
                 role: "admin")

O1 = Order.create(Status: "Completed", transaction_id: "123ss1", user_id: U1.id)
O2 = Order.create(Status: "Cancelled", transaction_id: "123ss2", user_id: U1.id)
O3 = Order.create(Status: "Processing", transaction_id: "123ss3", user_id: U1.id)
O4 = Order.create(Status: "Processing", transaction_id: "123ss4", user_id: U1.id)

Order_Item1 = OrderItem.create(quantity: 3, product_id: F1.id, order_id: 1)
Order_Item2 = OrderItem.create(quantity: 2, product_id: F2.id, order_id: 1)
Order_Item3 = OrderItem.create(quantity: 5, product_id: F3.id, order_id: 1)
Order_Item4 = OrderItem.create(quantity: 4, product_id: F3.id, order_id: 2)
Order_Item5 = OrderItem.create(quantity: 5, product_id: F3.id, order_id: 2)
Order_Item6 = OrderItem.create(quantity: 5, product_id: F3.id, order_id: 3)
Order_Item7 = OrderItem.create(quantity: 5, product_id: F3.id, order_id: 3)
Order_Item8 = OrderItem.create(quantity: 5, product_id: F3.id, order_id: 3)
Order_Item9 = OrderItem.create(quantity: 5, product_id: F3.id, order_id: 4)
Order_Item10 = OrderItem.create(quantity: 5, product_id: F3.id, order_id: 4)
Order_Item11 = OrderItem.create(quantity: 5, product_id: F3.id, order_id: 4)

C1.products << F1
C2.products << F3

Comment1 = Comment.create(comment: "Best product ever", product_id: F1.id, user_id: U1.id)
Comment2 = Comment.create(comment: "I love it!!", product_id: F1.id, user_id: U2.id)

F4 = Product.create(name: "Orange Juice",
                 description: "Home made orange juice",
                 price: 5)
