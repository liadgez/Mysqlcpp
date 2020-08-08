#ifndef _DB_H
#define _DB_H

#include "mysql_connection.h"

#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>
#include <cppconn/prepared_statement.h>
#include <iostream>

using namespace sql;
using namespace std;
#define DB_NAME "books_store"
#define DB_HOST "tcp://127.0.0.1/"
#define DB_PORT 3306
#define DB_USER "root"
#define DB_PASS "ZXC12VBN"

class Database {
private:
	// singleton instance
	static Database *instance;

	Driver *driver;
	ConnectOptionsMap connection_properties;

	// private CTOR (singleton)s
	Database();
public:
	static Database& getInstance();

	Connection *getConnection();

	virtual ~Database() {}
	

	/* Menu Options Functions */

	//Option 1
	void CheckIfBookOnStock();
	//Option 2
	void TheFirstClient();
	//Option 3
	void TheOldestBook();
	//Option 4
	void CurrentShippingList();
	//Option 5
	void SellsOfSpecificBook();
	//Option 6
	void MostPopularAuthorDates();
	//Option 7
	void ThreeBestClients();
	// Option 8
	void BookWithMostLangOnStock();
	// Option 9
	void SpecificClientHistoryCosts();
	// Option 10
	void SpecificClientHistory();
	// Option 11 
	void CalcShipping();
	//Option 12
	void ClientoOrderShipping();
	//Option 13
	void CurrentShippingStatus();
	//Option 14
	void SumXpressDelivery();
	//Option 15
	void SumBitPayment();
	//Option 16
	void OrdersMoreThenOrders();
	//Option 17
	void XpreesAndIsrPost();
	//Option 18
	void DeliveryBy2Versions();
	//Option 19
	void CustomersOver24Months();
	//Option 20
	void ClientContact();
	//Option 21
	void InventoryByMonth();
	//Option 22
	void StoreBuyCosts();
	//Option 23
	void StoreProfitMonth();
	//Option 24
	void AvgSellsMonth();
	//Option 25
	void AvgSelaryEmp();
	//Option 26
	void StaffBestSeller();






};
#endif