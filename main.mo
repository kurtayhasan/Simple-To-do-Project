import Map "mo:base/HashMap";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Text "mo:base/Text";
import Types "Types";
import Utils "Utils";

actor Asistan {
  var todos = Map.HashMap<Nat, Types.ToDo>(0, Nat.equal, Utils.natHash);
  var nextId: Nat = 0;

  public query func getTodos(): async [Types.ToDo] {
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
