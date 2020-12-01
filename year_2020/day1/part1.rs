use std::fs::File;
use std::io::{BufRead, BufReader};
use std::time::Instant;

fn main() {
  println!("Hello World!");

  let file = File::open("./input").unwrap();
  let reader = BufReader::new(file);

  let mut vec: Vec<i32> = Vec::new();
  for line in reader.lines() {
    let line = line.unwrap();
    vec.push(line.parse::<i32>().unwrap());
  }

  let start = Instant::now();
  for i in 0..vec.len() {
    for j in i..vec.len() {
      if (vec[i] + vec[j] == 2020) {
        println!("Result {}", vec[i] * vec[j]);
        println!("Exec time: {}", start.elapsed().as_millis());
        return ();
      }
    }
  }
}
