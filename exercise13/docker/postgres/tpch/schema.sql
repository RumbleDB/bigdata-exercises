CREATE TABLE REGION  (
        regionId        INTEGER NOT NULL PRIMARY KEY,
        regionName      CHAR(25) NOT NULL);

CREATE TABLE NATION  (
        nationId        INTEGER NOT NULL PRIMARY KEY,
        nationName      CHAR(25) NOT NULL,
        regionId        INTEGER NOT NULL REFERENCES REGION(regionId));

CREATE TABLE PART  (
        partId          INTEGER NOT NULL PRIMARY KEY,
        partName        VARCHAR(55) NOT NULL,
        partBrand       CHAR(10) NOT NULL,
        partType        VARCHAR(25) NOT NULL,
        partRetailPrice DECIMAL(15,2) NOT NULL);

CREATE TABLE SUPPLIER (
        supplierId      INTEGER NOT NULL PRIMARY KEY,
        supplierName    CHAR(25) NOT NULL,
        nationId        INTEGER NOT NULL REFERENCES NATION(nationId));

CREATE TABLE SUPPLYPART(
        partId          INTEGER NOT NULL REFERENCES PART(partId),
        supplierId      INTEGER NOT NULL REFERENCES SUPPLIER(supplierId),
        supplyPartCost  DECIMAL(15,2)  NOT NULL,
        PRIMARY KEY (partId, supplierId) );

CREATE TABLE CUSTOMER (
        customerId      INTEGER NOT NULL PRIMARY KEY,
        customerName    VARCHAR(25) NOT NULL,
        nationId        INTEGER NOT NULL REFERENCES NATION(nationId));

CREATE TABLE ORDERS  (
        orderId         INTEGER NOT NULL PRIMARY KEY,
        customerId      INTEGER NOT NULL REFERENCES CUSTOMER(customerId),
        orderDate       DATE NOT NULL,
        orderPriority   CHAR(15) NOT NULL);

CREATE TABLE ORDERLINE (
        orderId         INTEGER NOT NULL REFERENCES ORDERS(orderId),
        partId          INTEGER NOT NULL,
        supplierId      INTEGER NOT NULL,
        olId            INTEGER NOT NULL,
        olQuantity      DECIMAL(15,2) NOT NULL,
        olDiscount      DECIMAL(15,2) NOT NULL,
        olReturnFlag    CHAR(1) NOT NULL,
        olShipDate      DATE NOT NULL,
        olCommitDate    DATE NOT NULL,
        olReceiptdate   DATE NOT NULL,
        FOREIGN KEY (partId, supplierId) REFERENCES SUPPLYPART(partId, supplierId),
        PRIMARY KEY (orderId, olId));
