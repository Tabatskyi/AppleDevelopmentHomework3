import UIKit

// https://www.ralfebert.com/ios-examples/uikit/uitableviewcontroller/
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let studentsLabel: UILabel = {
        let label = UILabel()
        label.text = "Students"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    private let tableView = UITableView()
    private var students: [Student] = []

    override func viewDidLoad() {
        do {
            let model = try ModelParser(path: "/Users/kerbi/Projects/Homework3/Homework3/students.json")
            students = model.getStudents()
        } catch { print(error); }

        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(studentsLabel)
        studentsLabel.translatesAutoresizingMaskIntoConstraints = false
        studentsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        studentsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        studentsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        studentsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: studentsLabel.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StudentCell.self, forCellReuseIdentifier: "StudentCell")

        tableView.rowHeight = 80
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as? StudentCell else {
            return UITableViewCell()
        }
        let student = students[indexPath.row]
        cell.configure(with: student)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedStudent = students[indexPath.row]

        let detailVC = StudentDetailViewController()
        detailVC.student = selectedStudent

        navigationController?.pushViewController(detailVC, animated: true)
    }
}
