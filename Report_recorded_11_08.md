# Отчет

## Part 1: Выбор Сценария

Для данной работы выбран сценарий: **Онлайн-магазин электроники**: Управление категориями товаров, товарами, покупателями и оформленными заказами.

## Part 2: Проектирование Базы Данных и Документация

### Идентификация Сущностей и Атрибутов

1. Товары (Products)
2. Пользователи (Users)
3. Категория (Category)
4. Заказ (Order)
5. Действия пользователей (User_Actions)
6. Описание заказа (Order_Items)

### Проектирование Таблиц

**1. Table Name: Products**

- **Description:** Хранит информацию о товарах.
- **Attributes:**
  - ProductID: INTEGER, PK, NOT NULL, UNIQUE
  - ProductName: VARCHAR(150), NOT NULL
  - Description: TEXT, NOT NULL
  - Price: NUMERIC(10, 2), NOT NULL
  - CategoryID: INTEGER, FK (REFERENCES Category), NOT NULL
- **Constraints:**
  - PK_Products: PRIMARY KEY (ProductID)
  - FK_Products_Category: FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)

**2. Table Name: Users**

- **Description:** Хранит информацию о пользователях.
- **Attributes:**
  - UserID: INTEGER, PK, NOT NULL, UNIQUE
  - FirstName: VARCHAR(100), NOT NULL
  - LastName: VARCHAR(100), NOT NULL
  - Email: VARCHAR(255), NOT NULL
- **Constraints:**
  - PK_Users: PRIMARY KEY (UserID)
  - UQ_UserEmail: UNIQUE (Email)

**3. Table Name: Category**

- **Description:** Хранит информацию о категориях товаров.
- **Attributes:**
  - CategoryID: INTEGER, PK, NOT NULL, UNIQUE
  - CategoryName: VARCHAR(100), NOT NULL
- **Constraints:**
  - PK_Category: PRIMARY KEY (CategoryID)

**4. Table Name: Order**

- **Description:** Хранит информацию о заказах.
- **Attributes:**
  - OrderID: INTEGER, PK, NOT NULL, UNIQUE
  - UserID: INTEGER, FK (REFERENCES Users), NOT NULL
  - Creation_time: TIMESTAMP, NOT NULL
  - OrderStatus: VARCHAR(20), NOT NULL, DEFAULT 'PENDING'
- **Constraints:**
  - PK_Order: PRIMARY KEY (OrderID)
  - FK_Order_Users: FOREIGN KEY (UserID) REFERENCES Users(UserID)

**5. Table Name: User_Actions**

- **Description:** Хранит информацию о действиях пользователей.
- **Attributes:**
  - User_ActionsID: INTEGER, PK, NOT NULL, UNIQUE
  - UserID: INTEGER, FK (REFERENCES Users), NOT NULL
  - OrderID: INTEGER, FK (REFERENCES Order), NOT NULL
  - Action: VARCHAR(50), NULL
  - Creation_time: TIMESTAMP, NOT NULL
- **Constraints:**
  - PK_User_Actions: PRIMARY KEY (User_ActionsID)
  - FK_User_Actions_Users: FOREIGN KEY (UserID) REFERENCES Users(UserID)
  - FK_User_Actions_Order: FOREIGN KEY (OrderID) REFERENCES Order(OrderID)

**6. Table Name: Order_Items**

- **Description:** Промежуточная таблица для реализации связи многие-ко-многим между Order и Products. Хранит, какие товары и в каком количестве входят в заказ.
- **Attributes:**
  - OrderItemID: INTEGER, PK, NOT NULL, UNIQUE
  - OrderID: INTEGER, FK (REFERENCES Order), NOT NULL
  - ProductID: INTEGER, FK (REFERENCES Products), NOT NULL
  - Quantity: INTEGER, NOT NULL
  - PriceAtPurchase: NUMERIC(10, 2), NOT NULL
- **Constraints:**
  - PK_OrderItems: PRIMARY KEY (OrderItemID)
  - FK_OrderItems_Order: FOREIGN KEY (OrderID) REFERENCES Order(OrderID)
  - FK_OrderItems_Products: FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
  - UQ_OrderItems_OrderProduct: UNIQUE (OrderID, ProductID)
  - CHK_OrderItems_Quantity: CHECK (Quantity > 0)

### Взаимосвязи

**Category и Products (Один-ко-Многим):** Одной категории может принадлежать множество товаров, но каждый товар относится к одной конкретной категории.
- Products.CategoryID является внешним ключом, ссылающимся на Category.CategoryID.

**Users и Order (Один-ко-Многим):** Один пользователь может оформить множество заказов, но каждый заказ относится к одному конкретному пользователю.
- Order.UserID является внешним ключом, ссылающимся на Users.UserID.

**Users и User_Actions (Один-ко-Многим):** Один пользователь может совершить множество действий, но каждое действие относится к одному конкретному пользователю.
- User_Actions.UserID является внешним ключом, ссылающимся на Users.UserID.

**Order и User_Actions (Один-ко-Многим):** С одним заказом может быть связано множество действий пользователя, но каждое действие относится к одному конкретному заказу.
- User_Actions.OrderID является внешним ключом, ссылающимся на Order.OrderID.

**Order и Order_Items (Один-ко-Многим):** Один заказ может содержать множество позиций (товарных строк), но каждая позиция относится к одному конкретному заказу.
- Order_Items.OrderID является внешним ключом, ссылающимся на Order.OrderID.

**Products и Order_Items (Один-ко-Многим):** Один товар может входить во множество позиций разных заказов, но каждая позиция ссылается на один конкретный товар.
- Order_Items.ProductID является внешним ключом, ссылающимся на Products.ProductID.

**Order и Products (Многие-ко-Многим):** Один заказ может содержать множество товаров, и один товар может входить в состав множества заказов. Эта связь реализована через промежуточную таблицу Order_Items, которая разбивает её на две связи "один-ко-многим", описанные выше.

## Part 3: ER-Диаграмма

