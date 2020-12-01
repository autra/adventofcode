#include <iostream>
#include <fstream>
#include <vector>
#include <chrono>

using namespace std;

int main() {
  vector<int> v;

  // load file
  ifstream my_file("./input");
  if (!my_file) {
    cerr << "No such file..." << endl;
    return 1;
  }

  // read file
  auto start = chrono::high_resolution_clock::now();
  int number;
  while (my_file >> number) {
    v.push_back(number);
  }

  // iteration
  for (auto i = begin(v); i != end(v); i++) {
    for (auto j = i; j != end(v); j++) {
      for (auto k = j; k != end(v); k++) {
        if (*i + *j + *k == 2020) {
          cout << "Result: " << *i * *j * *k << endl;
          auto end = chrono::high_resolution_clock::now();
          auto duration = chrono::duration_cast<chrono::microseconds>(end - start);
          cout << "Exec Time: " << duration.count() << endl;
          my_file.close();
          return 0;
        }
      }
    }
  }

  return 0;
}
