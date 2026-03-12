*** Settings ***
Library   RequestsLibrary

*** Keywords ***
Create Booking
    [Arguments]    ${firstname}    ${lastname}    ${totalprice}    ${depositpaid}    ${checkin}    ${checkout}
    ${booking_dates}=    Create Dictionary    checkin=${checkin}    checkout=${checkout}
    ${deposit}=    Set Variable If    '${depositpaid}'=='true'    ${True}    ${False}
    ${price}=    Convert To Integer    ${totalprice}
    ${payload}=    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=${price}
    ...    depositpaid=${deposit}
    ...    bookingdates=${booking_dates}
    ...    additionalneeds=Breakfast
    ${response}=    POST On Session    mysession    /booking    json=${payload}
    Set Global Variable    ${response}
    RETURN    ${response}

Get Booking By Id
    [Arguments]    ${booking_id}
    ${response}=    GET On Session    mysession    /booking/${booking_id}
    Set Global Variable    ${response}
    RETURN    ${response}

Get All Users
    ${response}=    GET On Session    mysession    /booking
    Set Global Variable    ${LAST_RESPONSE}    ${response}
    RETURN    ${response}
