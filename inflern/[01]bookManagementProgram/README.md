## 📒 Section2 - 도서 관리 프로그램

### 📌 File Structure

```bash
└── book-manager
    ├── book-manager
    │   ├── Book.swift
    │   ├── BookManager.swift
    │   └── main.swift
    └── book-manager.xcodeproj
```

<br>

### 📌 Remind Swift-Grammar

#### Array Initialize

```swift
// Same Expression
var bookList = [Book]()  // 강의에서는 타입추론을 사용
var bookList: Array<Book> = Array<Book>()
var bookList: [Book] = [Book]()
```

<br>

#### Array Method - append()

```swift
// Same Expression
bookList += [bookObject] // 강의에서는 + 연산자 사용
bookList.append(bookObject)
```

<br>

#### Array Method - enumerated()

- (Index, value) 로 이루어진 튜플 리턴
- 값과 인덱스가 모두 필요할 때 사용

```swift
func removeBook(name: String){
    for (index, value) in bookList.enumerated(){ // enumerated : 튜플로 인덱스와 값을 넘겨줌
        if value.name == name { // 배열의 값 사용
            bookList.remove(at: index) // 배열의 인덱스 사용
        }    
    }
}
```