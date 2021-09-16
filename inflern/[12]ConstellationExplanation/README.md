# ConstellationExplanation

- 코드를 최소화하고 `UIImageView` 기반의 Application

<p align="center">
  <img src = "./img/1.png" width="37.3%" alt="1">
  <img src = "./img/2.png" width="40%" alt="2">
</p>

<br>

<p align="center">
  <img src = "./img/3.png" width="40%" alt="2">
</p>

<br>

## Remind UI-Kit

### popViewController(animated: Bool) -> UIViewController?
- stack에 쌓여있는 이전 ViewController로 이동하게 됩니다. 현재 ViewController는 사라집니다.

```swift
@IBAction func backButtonAction(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
}
```