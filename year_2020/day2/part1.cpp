#include <fstream>
#include <chrono>
#include <iostream>
#include <regex>
#include <vector>

using namespace std;

int main() {
  vector<vector<string>> v;

  // load file
  ifstream my_file("./input");
  if (!my_file) {
    cerr << "No such file..." << endl;
    return 1;
  }

  // read file
  string line;
  while (std::getline(my_file, line)) {

    try {
      std::regex rgx("([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)");
 // std::regex rgx("([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)");
      smatch sm;
      regex_search (line, sm, rgx);
      vector<string> parsed_line = {sm[1].str(), sm[2].str(), sm[3].str(), sm[4].str()};
      v.push_back(parsed_line);
    } catch(regex_error& e) {
      cerr << e.code() << endl;
      return 1;
    }
  }

  auto start = chrono::high_resolution_clock::now();
  // iteration
  int counter;
  for (const auto& sm:  v) {
    unsigned int min = stoi(sm[0]);
    unsigned int max = stoi(sm[1]);
    char letter = sm[2].at(0);
    string passwd = sm[3];

    long unsigned int letter_counter = 0;
    for (unsigned int i = 0; i < passwd.length(); i++) {
      if (passwd[i] == letter) {
        letter_counter++;
      }
    }

    if (min <= letter_counter && max >= letter_counter) {
      counter++;
    }
  }
  cout << "VALID: " << counter << endl;
  auto end = chrono::high_resolution_clock::now();
  auto duration = chrono::duration_cast<chrono::microseconds>(end - start);
  cout << "Exec Time: " << duration.count() << endl;

  return 0;
}
