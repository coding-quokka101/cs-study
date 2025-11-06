# 이터레이터(Iterator) 패턴

## 개념

- 행위 패턴
- 내부 구조를 노출하지 않고 **객체 집합의 요소를 순차적으로 접근**할 수 있게 함
- 컬렉션의 순회 방식을 일관된 인터페이스로 제공

## 구조

- **Iterator**: 요소를 순회하기 위한 인터페이스 (hasNext(), next())
- **ConcreteIterator**: 실제 순회 로직 구현
- **Aggregate (Collection)**: Iterator를 생성하는 인터페이스
- **ConcreteAggregate**: 실제 컬렉션 클래스, Iterator 객체를 반환

## 예시 코드 (Java)

```java
import java.util.List;
import java.util.ArrayList;

interface Iterator<T> {
    boolean hasNext();
    T next();
}

interface Aggregate<T> {
    Iterator<T> createIterator();
}

class Book {
    String title;
    public Book(String title) { this.title = title; }
    public String getTitle() { return title; }
}

class BookShelf implements Aggregate<Book> {
    private List<Book> books = new ArrayList<>();

    public void addBook(Book book) { books.add(book); }

    public Iterator<Book> createIterator() {
        return new BookIterator(this);
    }

    public List<Book> getBooks() { return books; }
}

class BookIterator implements Iterator<Book> {
    private BookShelf shelf;
    private int index = 0;

    public BookIterator(BookShelf shelf) { this.shelf = shelf; }

    public boolean hasNext() {
        return index < shelf.getBooks().size();
    }

    public Book next() {
        return shelf.getBooks().get(index++);
    }
}

public class Main {
    public static void main(String[] args) {
        BookShelf shelf = new BookShelf();
        shelf.addBook(new Book("Design Patterns"));
        shelf.addBook(new Book("Clean Code"));
        shelf.addBook(new Book("Effective Java"));

        Iterator<Book> it = shelf.createIterator();
        while(it.hasNext()) {
            System.out.println(it.next().getTitle());
        }
    }
}
```
