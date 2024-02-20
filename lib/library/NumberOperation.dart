extension NumberOperation on double{
  int get toSafeInt => (isNaN || isInfinite)?0 :toInt();
}
