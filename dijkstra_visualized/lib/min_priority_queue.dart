import "node.dart";

class MinPriorityQueue<T> {
  //properties
  Node<T> _head;
  int _numItems;

  //constructor
  MinPriorityQueue(){
    _numItems = 0;
  }

  //return true if the queue is empty
  bool isEmpty(){
    return _numItems == 0;
  }

  //return the number of elements in the queue
  int size(){
    return _numItems;
  }

  //insert an element into the queue based on priority (higher priority goes first)
  void addWithPriority(T element, int priority){
    Node<T> newNode =  new Node<T>(element, priority);
    //if there are no elements in the queue
    if(_head == null){
      _head = newNode;
      _numItems++;
      return;
    }
    //if there are existing elements
    Node<T> current = _head;
    for(int i=0;i<_numItems;i++){
      if(newNode.getPriority() >= current.getPriority()){
        //place node before current
        newNode.setNext(current);
        //check for first
        if(current.getPrevious() == null) _head = newNode;
        else{
          current.getPrevious().setNext(newNode);
        }
        current.setPrevious(newNode);
        break;
      }else{
        //throw new node at the end of queue
        if ( current.getNext() == null ){
          current.setNext(newNode);
          newNode.setPrevious(current);
          break;
        }
        current=current.getNext();
      }
    }
    _numItems++;
  }

  //remove the highest priority element from the queue
  T extractMin(){
    T headDataValue;
    if(_numItems > 0){
      headDataValue = _head.getValue();
      Node<T> oldHead = _head;
      _head = _head.getNext();
      _head.setPrevious(null);
      oldHead.setNext(null);
      oldHead.setPrevious(null);
      _numItems--;
    }
    return headDataValue;
  }

  //decrease the priority of an element in the queue
  void decreasePriority(T element, int priorityDelta){
    Node<T> current = _head;
    //if the element being changed is at the head
    if(element == current.getValue()){
      current.setPriority(current.getPriority() - priorityDelta);
      //if there is only one element in the queue
      if(current.getNext() == null) return;
      //otherwise remove the element and insert it back to the correct spot
      current.getNext().setPrevious(null);
      _head = current.getNext();
      _numItems--;
      addWithPriority(current.getValue(), current.getPriority());
      return;
    }
    //find the element being changed
    for(int i=0;i<_numItems;i++){
      if(current.getValue() ==  element){
        current.setPriority(current.getPriority() - priorityDelta);
        if(current.getNext() !=  null){
          current.getPrevious().setNext(current.getNext());
          current.getNext().setPrevious(current.getPrevious());
        }else{
          current.getPrevious().setNext(null);
        }
        _numItems--;
        addWithPriority(current.getValue(), current.getPriority());
        return;
      }
      current = current.getNext();
      if(current.getNext() == null) break;
    }
  }
}