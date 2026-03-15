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

Scenario: Update an existing booking and verify the details
    [Tags]    Regression
    [Documentation]    Update an existing booking and verify the details
    Given the API service is available at the configured url
    When the user creates a booking with the following details
    ...    John    Wick    500    true    2026-05-01    2026-05-10
    And the user updates the booking with the following details
    ...    Fuat    Kara    999    false    2027-01-01    2027-01-10
    Then the response status code should be 200
    And the updated booking should have the firstname "Fuat"

