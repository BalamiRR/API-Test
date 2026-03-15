# :fallen_leaf: :leavesRestful Booker API Test Automation :leaves: :fallen_leaf:

<div align="center">

![Python](https://img.shields.io/badge/Python-3.11+-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Robot Framework](https://img.shields.io/badge/Robot%20Framework-7.0-000000?style=for-the-badge&logo=robot-framework&logoColor=white)
![Cucumber](https://img.shields.io/badge/Cucumber-BDD-23D96C?style=for-the-badge&logo=cucumber&logoColor=white)
![Bruno](https://img.shields.io/badge/Bruno-API%20Client-FF6C37?style=for-the-badge&logo=bruno&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)

**Automated API test suite for Restful Booker built with Robot Framework, Python & Cucumber (BDD).**

[📖 API Docs](https://restful-booker.herokuapp.com/apidoc/index.html)

</div>

---

## About

This project contains a fully automated test suite covering all endpoints of the **[Restful Booker](https://restful-booker.herokuapp.com)** API. Tests are written following the **BDD (Behavior Driven Development)** approach using Gherkin syntax, making them readable by both technical and non-technical stakeholders.

### Covered API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/auth` | Generate authentication token |
| `GET` | `/booking` | Get all booking IDs |
| `GET` | `/booking/:id` | Get a single booking |
| `POST` | `/booking` | Create a new booking |
| `PUT` | `/booking/:id` | Full update of a booking |
| `PATCH` | `/booking/:id` | Partial update of a booking |
| `DELETE` | `/booking/:id` | Delete a booking |

---

## 🛠 Tech Stack

| Technology | Version | Purpose |
|------------|---------|---------|
| **Python** | 3.11+ | Core programming language |
| **Robot Framework** | 7.0 | Test automation framework |
| **robotframework-requests** | 0.9.7 | HTTP request library |
| **Cucumber / Gherkin** | BDD | Scenario definition language |

---

## Installation

### Prerequisites

- Python 3.11+
- pip

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/your-username/restful-booker-robot-tests.git
cd restful-booker-robot-tests

# 2. Create a virtual environment (recommended)
python -m venv venv
venv\Scripts\activate           # Windows

# 3. Install dependencies
pip install -r requirements.txt
```

### `requirements.txt`

```txt
robotframework==7.0
robotframework-requests==0.9.7
```

---

## Running Tests

### Run all tests

```bash
robot -d results tests/
```

### Run a specific suite

```bash
robot -d results tests/booking/create_booking_tests.robot
```

### Run by tag

```bash
# Run only smoke tests
robot -d results -i smoke tests/

# Exclude regression tests
robot -d results -e regression tests/
```

### Run in parallel (pabot)

```bash
pabot --processes 4 -d results tests/
```

### Run BDD / Cucumber scenarios

```bash
robot -d results --variable FEATURE_FILE:features/create_booking.feature tests/
```

---

## Test Scenarios

### Example Gherkin Scenario

```gherkin
*** Settings ***
Resource    ../step-definition/booking.step.robot
Suite Setup    the API service is available at the configured url

*** Test Cases ***
Scenario: Create a new booking and verify the details
    [Tags]    Regression
    [Documentation]    Create a new booking and verify the details
    Given the API service is available at the configured url
    When the user creates a booking with the following details
    ...    John    Wick    500    true    2026-05-01    2026-05-10
    Then the response status code should be 200
    And the created booking should have the firstname "John"
    And the API responds with a status code "200"

Scenario: Get all bookings and verify the list
    [Tags]    Regression
    [Documentation]    Get all bookings and verify the list is not empty
    When the user requests all bookings
    Then the response status code should be 200
    And the booking list should not be empty
```
## 📊 Test Reports

After running the tests, the following reports are generated in the `results/` folder:

| File | Description |
|------|-------------|
| `report.html` | High-level test summary report |
| `log.html` | Detailed step-by-step execution log |
| `output.xml` | XML output for CI/CD integration |

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

<div align="center">


</div>
