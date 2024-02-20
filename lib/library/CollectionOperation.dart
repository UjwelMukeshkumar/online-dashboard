extension MyCollection<E> on Iterable<E>{
  E? get tryFirst=>this.length>0?this.first:null;
}