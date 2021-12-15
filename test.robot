*** Settings ***
Library     SeleniumLibrary
Resource    common.robot

*** Variable ***
${login_btn}    dt_login_button
${email_field}     name=email
${pw_field}     //*[@type="password"]
${login_oauth_btn}      //*[text()="Log in"]
${check_active}     //*[text()="Real" and contains(@class, "active")]
${header_preloader}     dt_core_header_acc-info-preloader
${check_acc_status}    dt_core_account-info_acc-info
${demo_acc_tab}     id=dt_core_account-switcher_demo-tab
${select_demo}      id=dt_VRTC4794148
${volatility}   //*[@class="cq-symbol-select-btn"]
${contract_dropdown}    dt_contract_dropdown

*** Keyword ***

*** Test Cases ***
Open Deriv
    Login   ${my_email}  ${my_pw}
Check Account
    Check Account Status
#Rise Contract
#    Underlying
#    Rise Contract
#Lower Contract
#    Underlying
#    Lower Contract
#Relative Barrier Error
#    Relative Barrier Error
Multiplier Contract
    Underlying
    Multiplier Contract
    Multiplier Contract (a)
    Multiplier Contract (b)

