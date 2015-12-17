drop table members;
drop table items;
drop table shipping;
drop table bid;
drop table winningBid;
--drop table buyerRating
--drop table sellerRating

--Table for member information
create table members 
(
    MemberId int,
    MemberUname varchar (20),
    MemberPassword varchar (15),
    Name varchar (50),
    Address varchar (100),
    Phone int,
    Email varchar (50),
    primary key (MemberId, MemberUname)
);

--Table for item information
create table items
(
    ItemNumber int,
    ItemCategory varchar (20) not null,
    ItemTitle varchar (30) not null,
    Description varchar (100) not null,
    SellerId int,
    SellerUname varchar (20),
    QuantityAvailable int not null,
    StartPrice float not null,
    LastBidRecPrice float, -- Highest current bid
    CloseTimeDate date not null,
    primary key (ItemNumber, ItemTitle),
    foreign key (SellerId, SellerUname) 
    references members (MemberId, MemberUname)
);

--Table for shipping information
create table shipping 
(
    ItemNumber int,
    ItemTitle varchar (30),
    ShippingType varchar (20) not null,
    ShippingPrice float not null,
    primary key (ItemNumber, ItemTitle, ShippingType, ShippingPrice),
    foreign key (ItemNumber, ItemTitle) references items (ItemNumber, ItemTitle)
);

--Table for bid information
create table bid 
(
    BidId int,
    BuyerId int,
    BuyerUname varchar (20),
    ItemNumber int,
    ItemTitle varchar (30),
    BidPrice float, -- This will auto-update the price of the item in the item table (LastBidRecPrice)
    QtyWanted int,
    BidTimeDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    primary key (BidId, BuyerId, ItemNumber, BidPrice),
    foreign key (BuyerId, BuyerUname) 
    references members (MemberId, MemberUname),
    foreign key (ItemNumber, ItemTitle) references items (ItemNumber, ItemTitle)
);

--Table for winning bid information
create table winningBid
(
    WinningBidId int primary key,
    ItemNumber int,
    ItemTitle varchar (30),
    BuyerId int,
    BuyerUname varchar (20),
    SellerId int,
    SellerUname varchar (20),
    FinalPrice float,
    QtyWanted int, --Will auto-update quantity available for item
    ShippingType varchar (20),
    ShippingPrice float,
    primary key (WinningBidId, BuyerId, ItemNumber, ItemTitle),
    foreign key (WinningBidId, BuyerId, ItemNumber, FinalPrice) references bid (BidId, BuyerId, ItemNumber, BidPrice),
    foreign key (SellerId, SellerUname) references members (MemberId, MemberUname),
    foreign key (ItemNumber, ItemTitle, ShippingType, ShippingPrice) references shipping (ItemNumber, ItemTitle, ShippingType, ShippingPrice)
);

--Table for buyer ratings (rates members recieve as buyers)
create table buyerRating
(
    RatingId int,
    ItemNumber int,
    ItemTitle varchar (30),
    BuyerId int,
    BuyerUname varchar (20),
    bComment varchar (50),
    bScale int,
    primary key (RatingId),
    foreign key (ItemNumber, ItemTitle) references items (ItemNumber, ItemTitle),
    foreign key (BuyerId, BuyerUname) references members (MemberId, MemberUname) 
);

--Table for seller ratings (rates members recieve as buyers)
create table sellerRating
(
    RatingId int,
    ItemNumber int,
    ItemTitle int,
    SellerId int,
    SellerUname varchar (20),
    bComment varchar (50),
    bScale int, 
    foreign key (ItemNumber, ItemTitle) references item (ItemNumber, ItemTitle),
    foreign key (SellerId, SellerUname) references members (MemberId, MemberUname)
);









