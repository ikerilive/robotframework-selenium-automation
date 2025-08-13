*** Settings ***
Documentation     UI regression tests for an e-commerce site using Robot Framework + SeleniumLibrary
Library           SeleniumLibrary
Library           XML

*** Variables ***
${BASE_URL}               https://test.com/en/
${USERNAME}               %{SHOP_USERNAME}
${PASSWORD}               %{SHOP_PASSWORD}

# PRODUCTS LINKS
${PRICES_DROP}            //div[@class='col-md-6 wrapper']/ul/li/a[contains(., 'Prices drop')]
${HEADER_TEXT}            //section[@id='main']/h1
${NEW_PRODUCTS}           //div[@class='col-md-6 wrapper']/ul/li/a[contains(., 'New products')]
${BEST_SELLERS}           //div[@class='col-md-6 wrapper']/ul/li/a[contains(., 'Best sales')]

# SIGN IN
${SIGNIN_BUTTON}          class=user-info
${SIGNIN_SUBMIT}          id=submit-login
${LOGIN_EMAIL}            id=field-email
${LOGIN_PASSWORD}         id=field-password
${SIGN_OUT}               //div[@class='user-info']/a[contains(., 'Sign out')]

# ADD TO CART
${CLOTHES_TOP}            id=category-3
${TSHIRT_HUMMINGBIRD}     //img[@alt = 'Hummingbird printed t-shirt']
${ADD_CART}               //div[@class='add']/button
${ADD_SUCCESSFULL}        //div[@class='modal-header']/h4[text()='Product successfully added to your shopping cart']


*** Keywords ***

Open Browser To Homepage
    Open Browser    ${BASE_URL}    headlessfirefox

Click Prices Drop Link In Footer
    Click Element    ${PRICES_DROP}
    Element Should Contain    ${HEADER_TEXT}    PRICES DROP

Click New Products Link In Footer
    Click Element    ${NEW_PRODUCTS}
    Element Should Contain    ${HEADER_TEXT}    NEW PRODUCTS

Click Best Sales Link In Footer
    Click Element    ${BEST_SELLERS}
    Element Should Contain    ${HEADER_TEXT}    BEST SELLERS

Click Sign In link
    Click Element    ${SIGNIN_BUTTON}

Type In Username
    [Arguments]    ${username}
    Input Text    ${LOGIN_EMAIL}    ${username}

Type In Password
    [Arguments]    ${password}
    Input Text    ${LOGIN_PASSWORD}    ${password}

Submit Login
    Click Element    ${SIGNIN_SUBMIT}
    Title Should Be    My account

Log Out
    Click Element    ${SIGN_OUT}
    Element Should Contain    ${SIGNIN_BUTTON}    Sign in

Click Clothes Link In Top Bar
    Click Element    ${CLOTHES_TOP}

Click Hummingbird T-Shirt
    Click Element    ${TSHIRT_HUMMINGBIRD}

Add To Cart
    Click Element    ${ADD_CART}
    Wait Until Page Contains Element    ${ADD_SUCCESSFULL}
    Wait Until Element Contains         ${ADD_SUCCESSFULL}    Product successfully added to your shopping cart
    Element Should Contain              ${ADD_SUCCESSFULL}    Product successfully added to your shopping cart


*** Test Cases ***

Footer links test
    Open Browser To Homepage
    Click Prices Drop Link In Footer
    Click New Products Link In Footer
    Click Best Sales Link In Footer
    [Teardown]    Close Browser

Sign in and out
    Open Browser To Homepage
    Click Sign In link
    Type In Username    ${USERNAME}
    Type In Password    ${PASSWORD}
    Submit Login
    Log Out
    [Teardown]    Close Browser

Add item to cart
    Open Browser To Homepage
    Click Clothes Link In Top Bar
    Click Hummingbird T-Shirt
    Add To Cart
    [Teardown]    Close Browser
