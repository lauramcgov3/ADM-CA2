-- drop table sellerRating;
-- drop table buyerRating;
-- drop table winningBid;
-- drop table bid;
-- drop table shipping;
-- drop table items;
-- drop table members;

-- Creates for tables

-- Table for member information
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

-- Table for item information
create table items
(
    ItemNumber int,
    ItemCategory varchar (20) not null,
    ItemTitle varchar (30) not null,
    Description varchar (150) not null,
    SellerId int,
    SellerUname varchar (20),
    QuantityAvailable int not null,
    ItemLocation varchar (50) not null,
    StartPrice float not null,
    LastBidRecPrice float,
    CloseTimeDate date,
    Closed boolean,
    primary key (ItemNumber, ItemTitle),
    foreign key (SellerId, SellerUname) 
    references members (MemberId, MemberUname)
);

-- Table for shipping information
create table shipping 
(
    ItemNumber int,
    ItemTitle varchar (30),
    ShippingType varchar (20) not null,
    ShippingPrice float not null,
    primary key (ItemNumber, ItemTitle, ShippingType, ShippingPrice),
    foreign key (ItemNumber, ItemTitle) references items (ItemNumber, ItemTitle)
);

-- Table for bid information
create table bid 
(
    BidId int,
    BuyerId int,
    BuyerUname varchar (20),
    ItemNumber int,
    ItemTitle varchar (30),
    BidPrice float, -- This will auto-update the price of the item in the item table (LastBidRecPrice)
    QtyWanted int,
    BidTime date,
    primary key (BuyerId, BuyerUname, ItemId, ItemNumber, BidPrice),
    foreign key (BuyerId, BuyerUname) 
    references members (MemberId, MemberUname),
    foreign key (ItemNumber, ItemTitle) references items (ItemNumber, ItemTitle)
);

-- Table for winning bid information
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
    ShippingType varchar (20), -- Auto-update shipping table
    ShippingPrice float, -- Get this from shipping table?
    foreign key (BuyerId, BuyerUname, ItemId, ItemNumber, FinalPrice) references bid (BidId, BuyerId, ItemNumber, BidPrice),
    foreign key (SellerId, SellerUname) references members (MemberId, MemberUname),
    foreign key (ItemNumber, ItemTitle, ShippingType, ShippingPrice) references shipping (ItemNumber, ItemTitle, ShippingType, ShippingPrice)
);

-- Table for buyer ratings (rates members recieve as buyers)
create table buyerRating
(
    bRatingId int,
    ItemNumber int,
    ItemTitle varchar (30),
    BuyerId int,
    BuyerUname varchar (20),
    bComment varchar (50),
    primary key (RatingId),
    foreign key (ItemNumber, ItemTitle) references items (ItemNumber, ItemTitle),
    foreign key (BuyerId, BuyerUname) references members (MemberId, MemberUname) 
);

-- Table for seller ratings (rates members recieve as buyers)
create table sellerRating
(
    sRatingId int,
    ItemNumber int,
    ItemTitle int,
    SellerId int,
    SellerUname varchar (20),
    bComment varchar (50),
    foreign key (ItemNumber, ItemTitle) references item (ItemNumber, ItemTitle),
    foreign key (SellerId, SellerUname) references members (MemberId, MemberUname)
);


-- Inserts

-- Inserts into members table
insert into members values (
    1, 
    'dlawson0', 
    'dlawson0', 
    'Debra Lawson', 
    '73 Blaine Alley', 
    '7-(742)595-6734', 
    'dlawson0@reddit.com'
);

insert into members values (
    2, 
    'mreyes1', 
    'mreyes1', 
    'Mary Reyes', 
    '572 Clarendon Road', 
    '63-(985)141-0322', 
    'mreyes1@artisteer.com'
);

insert into members values (
    3, 
    'lhill2', 
    'lhill2', 
    'Lillian Hill', 
    '83584 Corry Park', 
    '51-(857)811-1426', 
    'lhill2@jiathis.com'
);

insert into members values (
    4, 
    'hpayne3', 
    'hpayne3', 
    'Howard Payne', 
    '26161 Crowley Alley', 
    '57-(954)183-8495', 
    'hpayne3@vk.com'
);

insert into members values (
    5, 
    'awarren4', 
    'awarren4', 
    'Andrea Warren', 
    '8 Ilene Pass', 
    '86-(753)874-0751', 
    'awarren4@miibeian.gov.cn'
);


-- Inserts to item table
insert into items values (
    1, 
    'Electronics', 
    'iPhone 5', 
    'Black, perfect condition, 16GB, charger included', 
    1, 
    'dlawson', 
    5,
    'Newcastle, United Kingdom',
    140.00, 
    142.50, 
    TO_DATE('2015/12/30 15:22:00', 'yyyy/mm/dd hh24:mi:ss'),
    false
);

insert into items values 
(
    2, 
    'Books', 
    'The Fault in Our Stars', 
    'Books by John Greene, good condition, a few signs of use', 
    3, 
    'lhill2', 
    3,
    'Paris, France'
    7.00, 
    7.50, 
    TO_DATE('2016/01/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),
    false
);

insert into items values (
    3, 
    '‪‪Clothes', 
    'Game of Thrones t-shirt', 
    'Brand new, still in packaging, available in a variety of sizes, must go before 2016', 
    2, 
    'mreyes1', 
    50, 
    'Cork, Ireland'
    10.00, 
    12.00, 
    TO_DATE('2015/12/31 23:59:59', 'yyyy/mm/dd hh24:mi:ss'),
    false
);

insert into items values 
(
    4, 
    'Household appliances', 
    'Kettle', 
    'Hobbs kettle, packaging opened, kettle never used, perfect condition', 
    3, 
    'lhill2', 
    1,
    'Paris, France'
    30.00, 
    35.50, 
    TO_DATE('2016/03/31 15:40:59', 'yyyy/mm/dd hh24:mi:ss'),
    true
);

insert into items values (
    5, 
    'Toys', 
    'Romo Robot', 
    'Romo Robot by Romotive, for iPhone 5/iPod touch 5th generation, some signs of use, in original packaging', 
    5, 
    'awarren4', 
    2,
    'Dublin, Ireland'
    60.00, 
    65.50, 
    TO_DATE('2016/05/12 19:00:00', 'yyyy/mm/dd hh24:mi:ss'),
    true
);

insert into items values (
    6, 
    'Jewellery', 
    'Thomas Sabo Bracelet', 
    'Perfect condition, never worn, still in original packaging', 
    4 , 
    'hpayne3', 
    1,
    'London, United Kingdom'
    70.00, 
    75.50, 
    TO_DATE('2016/05/12 19:00:00', 'yyyy/mm/dd hh24:mi:ss'),
    true
);

-- Inserts into shipping table
insert into shipping values (
    4,
    'Kettle', 
    'International Shipping',
    10.99
);

insert into shipping values (
    5, 
    'Romo Robot',
    'Domestic Shipping',
    5.50
);

insert into shipping values (
    6,
    'Thomas Sabo Bracelet', 
    'International Shipping',
    10.99
);


-- Inserts into bid table
insert into bid values (
    1, 
    1, 
    'dlawson0', 
    3, 
    'Game of Thrones t-shirt', 
    11.50, 
    2,
    sysdate
);

insert into bid values (
    2, 
    3, 
    'lhill2', 
    3, 
    'Game of Thrones t-shirt', 
    12.00, 
    1,
    sysdate
);

insert into bid values (
    3, 
    4, 
    'hpayne3', 
    1, 
    'iPhone 5', 
    140.50, 
    1,
    sysdate
);

insert into bid values (
    4, 
    3, 
    'lhill2', 
    1, 
    'iPhone 5', 
    142.50, 
    1,
    sysdate
);


insert into bid values (
    5, 
    4, 
    'hpayne3', 
    5, 
    'Romo Robot', 
    61.50, 
    1,
    sysdate
);

insert into bid values (
    6, 
    1, 
    'dlawson', 
    5, 
    'Romo Robot', 
    65.50, 
    1,
    sysdate
);

insert into bid values (
    7, 
    5, 
    'awarren4', 
    2, 
    'The Fault in Our Stars', 
    1, 
    7.05,
    sysdate
);

insert into bid values (
    8, 
    2, 
    'mreyers1', 
    2, 
    'The Fault in Our Stars', 
    1, 
    7.50,
    sysdate
);

insert into bid values (
    9, 
    4, 
    'hpayne3', 
    4, 
    'Kettle', 
    1, 
    30.50,
    sysdate
);

insert into bid values (
    10, 
    1, 
    'dlawson0', 
    4, 
    'Kettle', 
    1, 
    33.50,
    sysdate
);

insert into bid values (
    11, 
    2, 
    'mreyes1', 
    6, 
    'Thomas Sabo Bracelet', 
    1, 
    72.00,
    sysdate
);

insert into bid values (
    12, 
    3, 
    'lhill2', 
    6, 
    'Thomas Sabo Bracelet', 
    1, 
    75.50,
    sysdate
);


-- Inserts into winningBid table
insert into winningBid values (
    1, 
    4, 
    'Kettle', 
    1, 
    'dlawson0', 
    3,
    'lhill2',
    35.50, 
    1, 
    'International Shipping', 
    10.99
);

insert into winningBid values (
    2, 
    5, 
    'Romo Robot', 
    4, 
    'hpayne3', 
    5, 
    'awarren4', 
    61.50, 
    1, 
    'Domestic Shipping', 
    5.50
);

insert into winningBid values (
    3, 
    6, 
    'Thomas Sabo Bracelet', 
    2, 
    'mreyes1', 
    4, 
    'hpayne3', 
    75.50, 
    1, 
    'International Shipping', 
    10.99
);

-- Inserts into buyerRating table
insert into buyerRating values (
    1, 
    4, 
    'Kettle', 
    1, 
    'dlawson0', 
    'Reliable buyer'
);

insert into buyerRating values (
    2, 
    5, 
    'Romo', 
    4, 
    'hpayne', 
    'Unreliable buyer'
);

insert into buyerRating values (
    3, 
    6, 
    'Thomas Sabo Bracelet', 
    2, 
    'mreyes1', 
    'Very reliable buyer'
);

-- Inserts into sellerRating table
insert into sellerRating values (
    1, 
    4, 
    'Kettle', 
    3, 
    'lhill2', 
    'Reliable Seller'
);

insert into sellerRating values (
    2, 
    5, 
    'Romo', 
    5, 
    'awarren4', 
    'Unreliable Seller'
);

insert into sellerRating values (
    3, 
    6, 
    'Thomas Sabo Bracelet', 
    4, 
    'hpayne3',
    'Very Reliable Seller'
);

