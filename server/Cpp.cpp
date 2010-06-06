#include <iostream>
using namespace std;

int main(){

	int ival = 1024;
	int &refVal = ival;
	ival=5;
	cout<<refVal<<endl;

	cin.get();
	return 0;
}
