int wrap(int val, int size) {
  if (val < 0) {
    val = size - 1;
  } else if (val >= size) {
    val = 0;
  }
  return val;
}

boolean choose(float chance) {
  float rnd = random(1);
  boolean rtn = rnd < chance;
  return rtn;
}
