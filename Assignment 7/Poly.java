import static java.lang.System.out;

class Person {
  String name;
  Person (String name) {
    this.name = name;
  }
  public String toString() {
    return "Name: " .concat (name);
  }
}

class Student extends Person {
  Integer sid;
  Student (String name, Integer sid) {
    super (name);
    this.sid = sid;
  }
  public String toString() {
    return super.toString() .concat (", SID: ") .concat (sid.toString());
  }
}


public class Poly {

  static void print (Person p) {
    out.printf ("%s\n", p.toString());
  }

  public static void main (String[] args) {
    Person[] people = {new Person ("Alex"), new Student ("Alice", 300)};
    for (Person person : people)
      print (person);
  }
}