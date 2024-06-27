import Map "mo:base/HashMap";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Text "mo:base/Text";

actor asistan {

  type ToDo = {
    description: Text;
    completed: Bool;
  };

  func natHash(n: Nat): Hash.Hash {
    Text.hash(Nat.toText(n))
  };

  var todos = Map.HashMap<Nat, ToDo>(0, Nat.equal, natHash);
  var nextId: Nat = 0;

  // query metodu
  public query func getTodos(): async [ToDo] {
    Iter.toArray(todos.vals())
  };

  public func addTodo(description: Text): async Nat {
    let id = nextId;
    todos.put(id, {description = description; completed = false});
    nextId += 1;
    id
  };

  public func completeTodo(id: Nat): async () {
    ignore do ? {
      let description = todos.get(id)!.description;
      todos.put(id, {description = description; completed = true});
    }
  };

  public query func showTodos(): async Text {
    var output: Text = "\n__TO-DOs__";
    for (todo in todos.vals()) {
      output #= "\n" # todo.description;
      if (todo.completed) {
        output #= " !";
      };
    };
    output # "\n"
  };

};
