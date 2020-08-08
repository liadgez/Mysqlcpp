#include "Database.h"
#include <stdlib.h>

using namespace std;

int main(int argc, char* argv[])
{
	Database &db = Database::getInstance();
	int select = 99;
	while (select != 0) {
		cout << "Welcome to our terrific book store panel \n";
		cout << "\n --------------------------------------------------------\n"
			<< " 1) CheckIfBookOnStock" << endl
			<< " 2) TheFirstClient." << endl
			<< " 3) TheOldestBook." << endl
			<< " 4) CurrentShippingList." << endl
			<< " 5) SellsOfSpecificBook." << endl
			<< " 6) MostPopularAuthorDates." << endl
			<< " 7) ThreeBestClients." << endl
			<< " 8) BookWithMostLangOnStock." << endl
			<< " 9) SpecificClientHistoryCosts." << endl
			<< " 10) SpecificClientHistory." << endl
			<< " 11) CalcShipping." << endl
			<< " 12) CurrentShippingStatus." << endl
			<< " 13) SumXpressDelivery." << endl
			<< " 14) SumBitPayment" << endl 
			<< " 15) OrdersMoreThenOrders" << endl    
			<< " 16) XpreesAndIsrPost." << endl
			<< " 16) XpreesAndIsrPost." << endl
			<< " 16) XpreesAndIsrPost." << endl
			<< " 16) XpreesAndIsrPost." << endl
			<< " 16) XpreesAndIsrPost." << endl
			<< " 16) XpreesAndIsrPost." << endl
			<< " Your Choice: ";
		cin >> select;

		switch (select) {

		case 1: {
			db.CheckIfBookOnStock();
			cin.clear();
			cin.ignore(10000, '\n');
			break;
		}

		case 2: {
			db.TheFirstClient();
			cin.clear();
			cin.ignore(10000, '\n');
			break;
		}

		case 3: {
			db.TheOldestBook();
			cin.clear();
			cin.ignore(10000, '\n');
			break;
		}

		case 4: {
			db.CurrentShippingList();
			cin.clear();
			cin.ignore(10000, '\n');
			break;
		}

		case 5: {
			db.SellsOfSpecificBook();
			cin.clear();
			cin.ignore(10000, '\n');
			break;
		}

		case 6: {
			db.MostPopularAuthorDates();
			cin.clear();
			cin.ignore(10000, '\n');
			break;
		}

		case 7: {
			db.ThreeBestClients();
			cin.clear();
			break;
		}

		case 8: {
			db.BookWithMostLangOnStock();
			cin.clear();
			break;
		}

		case 9: {
			db.SpecificClientHistoryCosts();
			cin.clear();
			break;
		}

		case 10: {
			db.SpecificClientHistory();
			cin.clear();
			break;
		}

		case 11: {
			db.CalcShipping();
			cin.clear();
			break;
		}
		case 12: {
			db.ClientoOrderShipping();
			cin.clear();
			break;
		}

		case 13: {
			db.CurrentShippingStatus();
			cin.clear();
			break;
		}

		case 14: {
			db.SumXpressDelivery();
			cin.ignore(10000, '\n');
			break;
		}

		case 15: {
			db.SumBitPayment();
			cin.clear();
			break;
		}
		case 16: {
			db.OrdersMoreThenOrders();
			cin.clear();
			break;

		}
		case 17: {
			db.XpreesAndIsrPost();
			cin.clear();
			break;

		}
		case 18: {
			db.DeliveryBy2Versions();
			cin.clear();
			break;

		}
		case 19: {
			db.CustomersOver24Months();
			cin.clear();
			break;

		}
		case 20: {
			db.ClientContact();
			cin.clear();
			break;

		}
		case 21: {
			db.InventoryByMonth();
			cin.clear();
			break;

		}
		case 22: {
			db.StoreBuyCosts();
			cin.clear();
			break;

		}
		case 23: {
			db.StoreProfitMonth();
			cin.clear();
			break;

		}
		case 24: {
			db.AvgSellsMonth();
			cin.clear();
			break;

		}
		case 25: {
			db.AvgSelaryEmp();
			cin.clear();
			break;

		}
		case 26: {
			db.StaffBestSeller();
			cin.clear();
			break;

		}

		default: {
			cout << "\ninvalid choice" << endl;
			select = 42;
			cin.clear();
			cin.ignore(10000, '\n');
			break;
		}

		}

		cout << endl << "Press 1 to Return To the Main Menu.\nYour Choice: " << endl;
		select = 0;
		while (select != 1) {
			cin >> select;
			cin.clear();
			cin.ignore(10000, '\n');
		}


	}

	return 0;
}