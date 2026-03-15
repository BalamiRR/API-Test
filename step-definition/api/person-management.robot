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

Update Booking
    [Arguments]    ${id}    ${firstname}    ${lastname}    ${totalprice}    ${depositpaid}    ${checkin}    ${checkout}
    ${booking_dates}=    Create Dictionary    checkin=${checkin}    checkout=${checkout}
    ${deposit}=    Set Variable If    '${depositpaid}'=='false'    ${False}    ${True}
    ${price}=    Convert To Integer    ${totalprice}
    ${payload}=    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=${price}
    ...    depositpaid=${deposit}
    ...    bookingdates=${booking_dates}
    ...    additionalneeds=Breakfast
    ${token}=    Get Auth Token
    ${headers}=    Create Dictionary    Cookie=token=${token}
    ${response}=    PUT On Session    mysession    /booking/${id}    json=${payload}    headers=${headers}
    RETURN    ${response}

Get Auth Token
    ${payload}=    Create Dictionary    username=admin    password=password123
    ${response}=    POST On Session    mysession    /auth    json=${payload}
    RETURN    ${response.json()['token']}