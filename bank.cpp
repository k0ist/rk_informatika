#include <bits/stdc++.h>
using namespace std;


class BankAccount {
protected:
    string number;
    string owner;
    double balance;
public:
    BankAccount(const std::string& number, const std::string& owner, double balance): number(number), owner(owner),
    balance(balance) {}

    void withdraw(int su) {
        if (balance - su >= 0) {
            balance -= su;
        } else {
            cout << "Not enough money on your bank account";
        }
    }

    void deposit(double depo) {
        balance += depo;
    }
};


class SavingsAccount: public BankAccount {
private:
    double percent;
public:
    SavingsAccount(const string& number, const string& owner, double balance, double percent):
    BankAccount(number, owner, balance), percent(percent) {}

    void apply_percents() {
        deposit(balance * (percent / 100));
    }
    void display() {
        cout << balance;
    }
};

int main() {
    BankAccount bank("1337", "Stariy Bog", 133700.0);
    SavingsAccount savingsAccount("0696", "Lena Golovach", 133700.0, 18.0);
    bank.deposit(5000.0);
    savingsAccount.apply_percents();
    savingsAccount.display();
}