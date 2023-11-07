*** Settings ***
Documentation       In this challenge, you'll need to download the provided shopping list and add each item from the list to the shopping order before acknowledging the terms and submitting the order.

Library    RPA.Browser.Selenium
Library    RPA.HTTP
Library    RPA.Tables

*** Variables ***
${URL}    https://developer.automationanywhere.com/challenges/AutomationAnywhereLabs-ShoppingList.html?_gl=1*u0t2qc*_ga*NzIwODQxMjM4LjE2ODU4MTUzNDc.*_ga_DG1BTLENXK*MTY5OTM4MjUzNi4yLjEuMTY5OTM4NDIxMS41NC4wLjA.&_ga=2.176897381.1979049939.1699382537-720841238.1685815347&_fsi=oEULoW5l
${URL_ORDER_LIST}    https://aai-devportal-media.s3.us-west-2.amazonaws.com/challenges/shopping-list.csv

${PATH_DOWNLOAD_FILE}    ${OUTPUT DIR}${/}downloads${/}shopping-list.csv

*** Tasks ***
Submit Order for Groceries
    Open Available Browser    ${URL}    maximized=True
    Download Shopping List
    Add Items to Shopping List
    Acknowledge Terms
    Submit Order

*** Keywords ***
Download Shopping List
    Download    ${URL_ORDER_LIST}    target_file=${PATH_DOWNLOAD_FILE}    overwrite=True    
    Log To Console    Shopping list has been downloaded    

Add Items to Shopping List
    ${table_shopping_list}    Read table from CSV    ${PATH_DOWNLOAD_FILE}    header=True
    FOR    ${element}    IN    @{table_shopping_list}
        Log To Console    Added food item to cart: ${element}[Favorite Food]
        Input Text    xpath://*[@id="myInput"]    ${element}[Favorite Food]
        Click Element When Clickable    xpath://*[@id="add_button"]
    END
    Log To Console    All items have been added

Acknowledge Terms
    Click Element When Clickable    xpath://*[@id="agreeToTermsYes"]
    Log To Console    Accepted terms

Submit Order
    Click Element When Clickable    xpath://*[@id="submit_button"]
    Log To Console    Submitted order