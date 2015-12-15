--drop table members
--drop table items
--drop table shipping
--drop table bid
--drop table rating

--Table for member information
create table members 
(
    MemberId int auto_increment=100,
    MemberUname varchar (20),
    MemberPassword varchar (15),
    Name varchar (50),
    Address varchar (100),
    Phone int (10),
    Email varchar (50),
    primary key (MemberId, MemberUname)
);

--Table for item information
create table item
(
    ItemNumber int primary key auto_increment=100,
    Category varchar (20) not null,
    ItemTitle varchar (30) not null,
    Description varchar (60) not null,
    SellerId int foreign key references members.UserID,
    QuantityAvailable int (4) not null,
    StartPrice fl (6) not null,
    BidIncrement float (4),
    LastBidRecPrice float (4),
    CloseTime datetime not null
);

--Table for shipping information
create table shipping 
(
    ItemNumber int foreign key references items.ItemNumber,
    ShippingType varchar (20) not null,
    ShippingPrice float not null,
    primary key (ItemNumber, ShippingType, ShippingPrice)
);

--Table for bid information
create table bid 
(
    BuyerId varchar foreign key references member,
    ItemNumber int foreign key references item.ItemNumber,
    BidPrice float, -- This will auto-update the price of the item in the item table
    QtyWanted int (4),
    BidTime timestamp,
    primary key (BuyerId, ItemId, BidPrice)
);

--Table for winning bid information
create table winningBid
(
    ItemNumber int foreign key references item.ItemNumber,
    BuyerId foreign key references members,
    SellerId foreign key references members,
    FinalPrice float foreign key references items.LastBidRecPrice
    ShippingType varchar (20) foreign key references shipping,
    ShippingPrice float foreign key references shipping,
    primary key (ItemNumber, BuyerId, SellerId, FinalPrice)
);

--Table for buyer ratings (rates members recieve as buyers)
creat table buyerRating
(
    ItemNumber int foreign key references item.ItemNumber,
    ItemTitle int foreign key references item.ItemTitle,
    BuyerId int foreign key references member,
    BuyerUname varchar (20) foreign key references member,
    bComment varchar (50),
    bScale int 
);

--Table for seller ratings (rates members recieve as buyers)
creat table sellerRating
(
    ItemNumber int foreign key references item.ItemNumber,
    ItemTitle int foreign key references item.ItemTitle,
    SellerId int foreign key references member,
    SellerUname varchar (20) foreign key references member,
    bComment varchar (50),
    bScale int 
);









