import UIKit

class StudentDetailViewController: UIViewController {
    var student: Student?

    private let profileImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let scholarshipIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subjectsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupUI()
        displayStudentDetails()
    }

    private func setupUI() {
        view.addSubview(profileImageView)
        view.addSubview(scholarshipIndicator)
        view.addSubview(nameLabel)
        view.addSubview(ageLabel)
        view.addSubview(addressLabel)
        view.addSubview(subjectsStackView)

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 200),
            profileImageView.heightAnchor.constraint(equalToConstant: 200)
        ])

        NSLayoutConstraint.activate([
            scholarshipIndicator.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: -10),
            scholarshipIndicator.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -10),
            scholarshipIndicator.widthAnchor.constraint(equalToConstant: 20),
            scholarshipIndicator.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            ageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            addressLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 10),
            addressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            subjectsStackView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            subjectsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subjectsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func addressToString(_ inAddress: Address?) -> String {
        guard let address = inAddress else {
            return "No address"
        }
        return "\(address.street ?? "N/A") \(address.city ?? "N/A") \(address.postalCode ?? "N/A")"
    }

    private func displayStudentDetails() {
        guard let student = student else { return }

        view.backgroundColor = .white
        nameLabel.text = student.name
        ageLabel.text = "Age: \(student.age ?? 0)"
        addressLabel.text = "Address: \(addressToString(student.address))"

        if let scores = student.scores {
            for (subject, score) in scores {
                let subjectLabel = UILabel()
                subjectLabel.text = "\(subject): \(score ?? 0)"
                subjectLabel.backgroundColor = .lightGray
                subjectLabel.textAlignment = .center
                subjectLabel.font = UIFont.systemFont(ofSize: 16)
                subjectLabel.layer.cornerRadius = 5
                subjectLabel.layer.masksToBounds = true
                subjectLabel.translatesAutoresizingMaskIntoConstraints = false
                subjectLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
                subjectsStackView.addArrangedSubview(subjectLabel)
            }
        }
    }
}
