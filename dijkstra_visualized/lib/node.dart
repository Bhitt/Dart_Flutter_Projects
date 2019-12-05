  class Node<T> {
    //Properties
    T _value;
    int _priority;
    Node _previous, _next;

    //Default Constructor
    Node(T data, int b){
      _value = data;
      _previous = null;
      _next = null;
      _priority = b;
    }

    //Secondary constructor when placing in between nodes
    Node.insert(T data, int b, Node previousNode, Node nextNode){
      _value = data;
      _previous = previousNode;
      _next = nextNode;
      _priority = b;
    }

    Node getNext(){
      return _next;
    }
  
    Node getPrevious(){
      return _previous;
    }
          
    void setValue(T newValue){
      _value=newValue;
    }
      
    void setPriority(int newPriority){
      _priority = newPriority;
    }

    T getValue(){
      return _value;
    }
    
    int getPriority(){
      return _priority;
    }

    void setNext(Node newNextNode){
      _next = newNextNode;
    }
		
    void setPrevious(Node newPreviousNode){
      _previous = newPreviousNode;
    }
  }