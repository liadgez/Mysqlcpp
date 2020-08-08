#include "Database.h"
//#include <iostream>
#include <exception>

using namespace std;
void clearCin() {
	string temp;
	getline(cin, temp);
}


Database *Database::instance = 0;

Database::Database() : driver(get_driver_instance()) {
	connection_properties["hostName"] = DB_HOST;
	connection_properties["port"] = DB_PORT;
	connection_properties["userName"] = DB_USER;
	connection_properties["password"] = DB_PASS;
	connection_properties["OPT_RECONNECT"] = true;
}
	

Database & Database::getInstance() {
	if (Database::instance == 0) {
		instance = new Database();
	}
	return *instance;
}

Connection * Database::getConnection() {
	try {
		Connection *con = driver->connect(connection_properties);
		con->setSchema(DB_NAME);
		return con;
	}
	catch (SQLException &e) {
		cout << e.what();
	}
	return 0;
}


//Option 1
void Database::CheckIfBookOnStock() {
	string temp1;
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet* rset;
	PreparedStatement* pstmt = con->prepareStatement("SELECT b.book_name, bv.publish_year FROM Book_inventory as bi JOIN Book_Version bv ON bv.book_version_id = bi.book_version_id JOIN Books b ON b.book_id = bv.book_id LEFT JOIN orders o  ON o.inventory_id = bi.inventory_id WHERE book_name LIKE ? and order_id IS NULL; ");
	cout << "Please write the book name you would like to check if its on stock: ";
	clearCin();
	getline(cin, temp1);
	pstmt->setString(1, temp1);
	rset = pstmt->executeQuery();

	if (rset->first()) {
		cout << "The book  " << "book_name" << " is on stock " << " there are: " << rset->rowsCount() << " left" << endl;
	}
	else cout << "Invalid name or its not on stock, sorry.." << endl;


	delete con;
	delete pstmt;
	delete rset;
}

//Option 2
void Database::TheFirstClient() {
	
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	Statement* stmt = con->createStatement();
	ResultSet* rset = stmt->executeQuery("SELECT * FROM clients order by join_date ASC limit 1;");
	rset->beforeFirst();

	if (rset->first()) {
		cout << "The first client is: " <<"id: "<< rset->getString("client_id") << " " << rset->getString("f_name") << " appears " << rset->getString("join_date") << " times." << endl;
	}

	delete con;
	delete stmt;
	delete rset;
}

//Option 3
void Database::TheOldestBook() {
	string temp1, temp2, temp3;
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet* rset;
	PreparedStatement* pstmt = con->prepareStatement("SELECT * FROM Book_inventory bi JOIN Book_Version bv ON bv.book_version_id = bi.book_version_id JOIN Books b ON b.book_id = bv.book_id  ORDER BY added_date ASC limit 1;");
	rset = pstmt->executeQuery();

	if (rset->first()) {
		cout << "The Oldest book in inventory is:  " << rset->getString("book_name") << " " << rset->getString("added_date") ;
	}
	else cout << "There was an error or there was not books." << endl;

	delete con;
	delete pstmt;
	delete rset;
}

//Option 4
void Database::CurrentShippingList() {
	Connection *con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	Statement *stmt = con->createStatement();
	ResultSet* rset = stmt->executeQuery("SELECT * FROM orders o JOIN Shipping_Books sp ON sp.shipping_id = o.shipping_id WHERE sp.shipping_status_id NOT IN(2, 3) ORDER BY o.order_date;");


	if (rset->first()) {
		cout << "Current shipping list: " << endl;
		do {
			cout <<"order id: " << rset->getString("order_id") << endl;
		} while (rset->next());
	}
	else cout << "All orders are done!" << endl;

	delete con;
	delete stmt;
	delete rset;
}

//Option 5
void Database::SellsOfSpecificBook() {
	string temp1;
	int counter = 1;
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet* rset;
	PreparedStatement* pstmt = con->prepareStatement("SELECT count(*) AS count FROM Book_inventory as bi JOIN Book_Version bv ON bv.book_version_id = bi.book_version_id JOIN Books b ON b.book_id = bv.book_id JOIN orders o  ON o.inventory_id = bi.inventory_id WHERE book_name LIKE ? and order_date IS NOT NULL; ");

	cout << "Please enter book name: ";
	clearCin();
	getline(cin, temp1);
	pstmt->setString(1, temp1);

	rset = pstmt->executeQuery();

	if (rset->rowsCount() == 0) {
		cout << "No orders for your book" << endl;
		return;
	}

	if (rset->first())
	cout << "The number of orders for " << temp1 << " is: " << rset->getString("count") << endl;

	delete con;
	delete pstmt;
	delete rset;
}

//Option 6
void Database::MostPopularAuthorDates() {
	string temp1, temp2;
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet* rset;
	PreparedStatement* pstmt = con->prepareStatement("SELECT au.author_name, COUNT(book_name) AS count FROM Book_inventory AS bi JOIN Book_Version bv ON bv.book_version_id = bi.book_version_id JOIN Books b ON b.book_id = bv.book_id JOIN Authors_Books ab  ON ab.book_id = b.book_id JOIN authors au  ON au.author_id = ab.author_id JOIN orders o  ON o.inventory_id = bi.inventory_id WHERE o.order_date Between ? and ? GROUP BY book_name ORDER BY COUNT(book_name) desc LIMIT 1;");
	cout << endl << "Please enter date in this pattern YYYY-MM-DD\n" << endl;
	cout << "Please enter from date: ";
	clearCin();
	getline(cin, temp1);
	pstmt->setString(1, temp1);
	cout << "Please enter to date: ";
	getline(cin, temp2);
	pstmt->setString(2, temp2);
	rset = pstmt->executeQuery();

	if (rset->first()) {
		cout << "Most readable author is: " << rset->getString("author_name") << " times of purchases: " << rset->getString("count") << endl;
	}
	else cout << "Invalid Date or No Orders Found That Where Ordered Between Dates." << endl;

	delete con;
	delete pstmt;
	delete rset;
}

//Option 7
void Database::ThreeBestClients() {
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	Statement* stmt = con->createStatement();
	ResultSet* rset = stmt->executeQuery("SELECT c.f_name, COUNT(*) AS count, o.order_date FROM clients c JOIN orders o  ON o.client_id = c.client_id GROUP BY c.client_id ORDER BY COUNT(*) desc LIMIT 3; ");

	if (rset->first()) {
		cout << "3 most valuable clients are: " << endl;
		do {
			cout << rset->getString("f_name") << " with "<< rset->getString("count") << " total orders" <<  endl;
		} while (rset->next());
	}
	else cout << "There are no orders " << endl;

	delete con;
	delete stmt;
	delete rset;
}

// Option 8
void Database::BookWithMostLangOnStock() {

	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	Statement* stmt = con->createStatement();
	ResultSet* rset = stmt->executeQuery("SELECT b.book_name, COUNT(*) AS num_of_translation_stock FROM Book_inventory AS bi JOIN Book_Version bv ON bv.book_version_id = bi.book_version_id JOIN languages l ON l.id = bv.language_id JOIN Translators t ON t.id = bv.translator_id JOIN Books b ON b.book_id = bv.book_id LEFT JOIN orders o ON o.inventory_id = bi.inventory_id WHERE o.order_date IS NULL GROUP BY bv.book_version_id LIMIT 1;");
	rset->beforeFirst();

	if (rset->first()) {
		cout << "The book with the most languages on stock is : " << rset->getString("book_name") <<" and we have " << rset->getString("num_of_translation_stock") <<" on stock" << endl;
	}

	delete con;
	delete stmt;
	delete rset;
}

// Option 9
void Database::SpecificClientHistoryCosts() {

	string temp1;
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet* rset;

	PreparedStatement* pstmt = con->prepareStatement("SELECT c.f_name,b.book_name, o.order_date, b.sell_value FROM book_inventory AS bi JOIN Book_Version bv ON bv.book_version_id = bi.book_version_id JOIN Books b ON b.book_id = bv.book_id JOIN orders o  ON o.inventory_id = bi.inventory_id JOIN clients c  ON c.client_id = o.client_id WHERE c.f_name LIKE ? ORDER BY o.order_date ASC;");
	
	cout << "Please enter client name: ";
	clearCin();
	getline(cin, temp1);
	pstmt->setString(1, temp1);
	

	rset = pstmt->executeQuery();
	rset->beforeFirst();

	if (rset->first()) {
		cout << "Client order list is: " << endl;
		do {
			cout << rset->getString("f_name") << " book name: " << rset->getString("book_name") << " order date:" << rset->getString("order_date") << " book cost: " << rset->getString("sell_value") << endl;
		} while (rset->next());


		delete con;
		delete pstmt;
		delete rset;
	}
}

// Option 10
void Database::SpecificClientHistory() { /*
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	Statement* stmt = con->createStatement();
	ResultSet* rset = stmt->executeQuery("SELECT genre , count(genre) AS ct FROM musical_track GROUP BY musical_track.genre ORDER BY ct DESC LIMIT 1;");
	rset->beforeFirst();

	if (rset->first()) {
		cout << "Most popular genre : " << rset->getString("genre") << " with " << rset->getString("ct") << " songs" << endl;
	}

	delete con;
	delete stmt;
	delete rset;
	*/
}

// Option 11 
void Database::CalcShipping() { /*

	string temp1;
	Connection *con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet *rset;
	PreparedStatement *pstmt = con->prepareStatement("SELECT technician_id, person.name,count(musical_track.technician_id) AS ct FROM musical_track LEFT JOIN `person` ON musical_track.technician_id = person.Id WHERE (recording_date >= ? AND recording_date <= ? ) GROUP BY musical_track.technician_id ORDER BY ct DESC LIMIT 1;");
	cout << "\nPlease enter date in this pattern YYYY-MM-DD\n" << endl;
	cout << "Enter book name to check delivery cost ";
	clearCin();
	getline(cin, temp1);
	pstmt->setString(1, temp1);

	rset = pstmt->executeQuery();

	if (rset->first()) {
		cout <<"the delivety cost for: "<< rset->getString("book_name") << " " << ", and he recorded " << rset->getUInt("ct") << "tracks " <<"from:"<< temp1<<" to: "<<temp2 << endl;
	}

	else cout << "Invalid Date or No tracks who recorded in those dates." << endl;


	delete con;
	delete pstmt;
	delete rset;
	*/
}

//Option 12
void Database::ClientoOrderShipping() {
	string temp1;
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet* rset;

	PreparedStatement* pstmt = con->prepareStatement("SELECT o.order_id,c.f_name,b.book_name, bv.book_version_id,o.order_date,sp.shipping_id FROM  orders  AS o JOIN Shipping_Books sp ON sp.shipping_id = o.shipping_id JOIN Book_inventory bi ON  bi.inventory_id = o.inventory_id JOIN Book_Version bv ON bv.book_version_id = bi.book_version_id JOIN Books b ON b.book_id = bv.book_id JOIN clients c  ON c.client_id = o.client_id WHERE c.f_name LIKE ? ;");
	cout << "Please enter client name: ";
	clearCin();
	getline(cin, temp1);
	pstmt->setString(1, temp1);


	rset = pstmt->executeQuery();
	rset->beforeFirst();

	if (rset->first()) {
		cout << "Client order list is: " << endl;
		do {
			cout << rset->getString("f_name") << " book_name: " << rset->getString("book_name") << " order_id:" << rset->getString("order_id") << "shipping id: " << "shipping_id" << endl;
		} while (rset->next());


		delete con;
		delete pstmt;
		delete rset;
	}
}

//Option 13
void Database::CurrentShippingStatus() {

	int temp1;
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet* rset;

	PreparedStatement* pstmt = con->prepareStatement("SELECT o.order_id ,ss.status_type FROM  orders  AS o JOIN Shipping_Books sp ON sp.shipping_id = o.shipping_id JOIN Shipping_Status ss ON  ss.status_id = sp.shipping_status_id WHERE o.order_id = ? ;");
	cout << "Please shipping id: ";
	clearCin();
	cin >> temp1;
	pstmt->setInt(1, temp1);


	rset = pstmt->executeQuery();

	if (rset->first()) {
		cout << "The status of your chosen shipping id is " << endl;
		do {
			cout  << rset->getInt("order_id") << " status is " << rset->getString("status_type") << endl;
		} while (rset->next());
	}
	else cout << "No order found." << endl;

	delete con;
	delete pstmt;
	delete rset;
}

//Option 14
void Database::SumXpressDelivery() {
	/*

	string temp1;
	string temp2;
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet* rset;
	PreparedStatement* pstmt = con->prepareStatement("SELECT sum(S.delivery_cost)  FROM( SELECT sm.method,b.wheight,sm.cost_per_gram, SUM(sm.cost_per_gram * b.wheight) AS delivery_cost FROM  orders  AS o JOIN Shipping_Books sp ON sp.shipping_id = o.shipping_id JOIN shipping_method sm ON  sm.shipping_method_id = sp.shipping_type_id JOIN Book_inventory bi ON  bi.inventory_id = o.inventory_id JOIN Book_Version bv ON bv.book_version_id = bi.book_version_id JOIN Books b ON b.book_id = bv.book_id WHERE sm.method LIKE ? and sp.shipping_date LIKE ? GROUP BY sp.shipping_id) AS S ;");
	cout << endl << "Please enter month like 2020-08 \n" << endl;
	clearCin();
	temp1 = "xpress";
	getline(cin, temp2);

	pstmt->setString(1, temp1);
	pstmt->setString(2, temp2);

	rset = pstmt->executeQuery();

	if (rset->first()) {
		cout << "Xpress SUM DELIVERY IS: " << rset->getInt("sum(S.delivery_cost)") <<  endl;
	}
	else cout << "Invalid Date or No Orders Found That Where Ordered Between Dates." << endl;
	*/
}

//Option 15
void Database::SumBitPayment() {
	/*
	string temp1="bit";
	string temp2;
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet* rset;
	PreparedStatement* pstmt = con->prepareStatement("SELECT pm.payment_type,SUM(b.sell_value) AS money_transfer,o.order_date ,COUNT(*) AS num_of_orders FROM  orders  AS o JOIN Payment_Method pm ON pm.payment_method_id = o.payment_method_id JOIN Shipping_Books sp ON sp.shipping_id = o.shipping_id JOIN shipping_method sm ON  sm.shipping_method_id = sp.shipping_type_id JOIN Book_inventory bi ON  bi.inventory_id = o.inventory_id JOIN Book_Version bv ON bv.book_version_id = bi.book_version_id JOIN Books b ON b.book_id = bv.book_id WHERE pm.payment_type LIKE  ?  and o.order_date LIKE ? GROUP BY o.payment_method_id;");
	cout << "\nPlease enter date in this pattern YYYY-MM-DD\n" << endl;
	cout << "Enter book name to check delivery cost ";
	clearCin();
	getline(cin, temp2);
	pstmt->setString(1, temp1);
	pstmt->setString(2, temp2);

	rset = pstmt->executeQuery();

	if (rset->first()) {
		cout << "sell value for bit is: " << rset->getString("money_transfer") << endl;
	}

	else cout << "Invalid Date or No tracks who recorded in those dates." << endl;


	delete con;
	delete pstmt;
	delete rset;
	*/
}
//Option 16
void Database::OrdersMoreThenOrders() {

	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	Statement* stmt = con->createStatement();
	ResultSet* rset = stmt->executeQuery("SELECT o.order_id ,SUM(b.sell_value - b.buy_value) AS reve FROM orders o LEFT JOIN Payment_Method pm ON pm.payment_method_id = o.payment_method_id LEFT JOIN Shipping_Books sp ON sp.shipping_id = o.shipping_id LEFT JOIN shipping_method sm ON  sm.shipping_method_id = sp.shipping_type_id LEFT JOIN Book_inventory bi ON  bi.inventory_id = o.inventory_id LEFT JOIN Book_Version bv ON bv.book_version_id = bi.book_version_id LEFT JOIN Books b ON b.book_id = bv.book_id GROUP BY o.order_id Having reve  > ( (SELECT AVG(SUM_group.rev) AS AVG_group from(SELECT o.order_id ,SUM(b.sell_value - b.buy_value)  AS rev FROM orders o LEFT JOIN Payment_Method pm ON pm.payment_method_id = o.payment_method_id LEFT JOIN Shipping_Books sp ON sp.shipping_id = o.shipping_id LEFT JOIN shipping_method sm ON  sm.shipping_method_id = sp.shipping_type_id LEFT JOIN Book_inventory bi ON  bi.inventory_id = o.inventory_id LEFT JOIN Book_Version bv ON bv.book_version_id = bi.book_version_id LEFT JOIN Books b ON b.book_id = bv.book_id WHERE o.order_date > DATE_ADD(Now(), INTERVAL- 12 MONTH) GROUP BY o.order_id) AS SUM_group)) ; ");
	rset->beforeFirst();


	if (rset->first()) {
		cout << "orders more revenue then other orders: " << endl;
		do {
			cout << "order_id: " << rset->getString("order_id") << " with value of " << rset->getString("reve") << endl;
		} while (rset->next());

		delete con;
		delete stmt;
		delete rset;

	}
}
//Option 17
void Database::XpreesAndIsrPost() {
	string temp1 = "xpress";
	string temp2 = "israel_post";
	string temp3 = "דואר ישראל";
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet* rset;

	PreparedStatement* pstmt = con->prepareStatement("SELECT 'express' ,COUNT(sm.method) AS delivery_COUNT FROM Shipping_Books AS sb LEFT JOIN shipping_method sm ON sm.shipping_method_id = sb.shipping_type_id WHERE sm.method LIKE ? GROUP BY express UNION SELECT ? ,COUNT(sm.method) FROM Shipping_Books AS sb LEFT JOIN shipping_method sm ON sm.shipping_method_id = sb.shipping_type_id WHERE sm.method LIKE ? ;");
	cout << "Please enter client name: ";
	clearCin();

	pstmt->setString(1, temp1);
	pstmt->setString(2, temp2);
	pstmt->setString(3, temp3);

	rset = pstmt->executeQuery();
	
	
	if (rset->first()) {
		cout << "The number of shipping are: " << endl;
		do {
			cout << endl;
			cout << "delivery type: " << rset->getString(1) << " number of shipping: " << rset->getString(2) << endl; //using index column, but need to #include <resultset_metadata.h>
		} while (rset->next());


		delete con;
		delete pstmt;
		delete rset;

	}
}
//Option 18
void Database::DeliveryBy2Versions() {



}
//Option 19
void Database::CustomersOver24Months() {



}
//Option 20
void Database::ClientContact() {


}
//Option 21
void Database::InventoryByMonth() {


}
//Option 22
void Database::StoreBuyCosts() {


}
//Option 23
void Database::StoreProfitMonth() {


}

//Option 24
void Database::AvgSellsMonth() {



}

//Option 25
void Database::AvgSelaryEmp() {



}
//Option 26
void Database::StaffBestSeller() {


}