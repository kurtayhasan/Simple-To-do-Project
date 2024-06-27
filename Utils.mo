import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module {
  public func natHash(n: Nat): Hash.Hash {
    Text.hash(Nat.toText(n))
  };
}
