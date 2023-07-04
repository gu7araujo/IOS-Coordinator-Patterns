import UIKit

class Coordinator {

    private var navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let myViewModel = MyViewModel(navigateToAnotherScreenByClosure: navigateToAnotherScreen)
        myViewModel.delegate = self
        let myViewController = MyViewController(viewModel: myViewModel)
        navigationController.pushViewController(myViewController, animated: true)
    }

    func navigateToAnotherScreen() {
        let viewController = AnotherViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension Coordinator: MyViewDelegate {
    func navigateToAnotherScreenByDelegate() {
        navigateToAnotherScreen()
    }
}

class MyViewController : UIViewController {

    private var viewModel: MyViewModel?

    init(viewModel: MyViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black

        view.addSubview(label)
        self.view = view
    }
}

protocol MyViewDelegate: AnyObject {
    func navigateToAnotherScreenByDelegate()
}

class MyViewModel {

    weak var delegate: MyViewDelegate?
    var navigateToAnotherScreenByClosure: () -> Void

    init(navigateToAnotherScreenByClosure: @escaping () -> Void) {
        self.navigateToAnotherScreenByClosure = navigateToAnotherScreenByClosure
    }

    func navigateToAnotherScreen() {
//        navigateToAnotherScreenByClosure()
        delegate?.navigateToAnotherScreenByDelegate()
    }
}

class AnotherViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "happy!"
        label.textColor = .black

        view.addSubview(label)
        self.view = view
    }
}
