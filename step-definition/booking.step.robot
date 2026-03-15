*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    ../libraries/ConfigLibrary.py 
Resource    ../step-definition/api/person-management.robot

*** Keywords ***
the API service is available at the configured url
    ${url}=    Get Base URL
    Create Session    mysession    ${url}    verify=True

the user creates a booking with the following details
    [Arguments]    ${firstname}    ${lastname}    ${totalprice}    ${depositpaid}    ${checkin}    ${checkout}
    ${response}=    Create Booking    ${firstname}    ${lastname}    ${totalprice}    ${depositpaid}    ${checkin}    ${checkout}
    Set Global Variable    ${LAST_RESPONSE}    ${response}
    Set Global Variable    ${BOOKING_ID}    ${response.json()['bookingid']}

the response status code should be ${status_code}
    Status Should Be    ${status_code}    ${LAST_RESPONSE}

the created booking should have the firstname "${expected_name}"
    ${get_response}=    Get Booking By Id    ${BOOKING_ID}
    Should Be Equal As Strings    ${get_response.json()['firstname']}    ${expected_name}

the API responds with a status code "${expected_code}"
    Should Be Equal As Strings    ${LAST_RESPONSE.status_code}    ${expected_code}

the user requests all bookings
    ${response}=    Get All Users
    Log    All Bookings: ${response.json()}

the booking list should not be empty
    ${bookings}=    Set Variable    ${LAST_RESPONSE.json()}
    Should Not Be Empty    ${bookings}
    Log    Total bookings found: ${bookings.__len__()}

the user updates the booking with the following details
    [Arguments]    ${firstname}    ${lastname}    ${totalprice}    ${depositpaid}    ${checkin}    ${checkout}
    ${response}=    Update Booking    ${BOOKING_ID}    ${firstname}    ${lastname}    ${totalprice}    ${depositpaid}    ${checkin}    ${checkout}
    Set Global Variable    ${LAST_RESPONSE}    ${response}

the updated booking should have the firstname "${expected_name}"
    ${get_response}=    Get Booking By Id    ${BOOKING_ID}
    Should Be Equal As Strings    ${get_response.json()['firstname']}    ${expected_name}