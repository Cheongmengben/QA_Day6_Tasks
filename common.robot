*** Settings ***


*** Keywords ***
Login
    [arguments]     ${email}    ${pw}
    Open Browser    url=https://app.deriv.com   browser=chrome
    set window size     1920    1080
#    wait until page does not contain element    dt_core_header_acc-info-pre
    wait until page contains element    ${login_btn}     60
    Click Element   ${login_btn}
    wait until page contains element    ${email_field}  15
    input text      ${email_field}  ${email}
    input text      ${pw_field}   ${pw}
    Click Element   ${login_oauth_btn}


Check Account Status
    wait until page does not contain element    ${header_preloader}    60
    wait until page contains element    ${check_acc_status}    60
    Click Element   ${check_acc_status}
    Click Element   ${demo_acc_tab}
    Click Element   ${select_demo}

Underlying
    reload page
    wait until page does not contain element   //*[@class="chart-container__loader"]      60
    wait until page contains element    ${volatility}       60
    Click Element   ${volatility}
    wait until page contains element       //*[@class="sc-mcd "]

Rise Contract
#   choose volatility 10 (1s) Index
    Click Element       //*[text()="Synthetic Indices" and contains(@class, "sc-mcd__filter__item")]
    Click Element       //*[text()="Volatility 10 (1s) Index" and contains(@class, "sc-mcd__item__name")]
#   select rise/fall
    wait until page contains element       ${contract_dropdown}     60
    Click Element       ${contract_dropdown}
    Click Element       dt_contract_rise_fall_item
#   buy rise contract
    wait until element is enabled       dt_purchase_call_button     60
    Click Element       dt_purchase_call_button
    Sleep   5


Lower Contract
#   select AUD/USD
    Click Element       //*[@class="ic-icon ic-forex"]
    wait until page contains element    //*[@class="sc-mcd__item sc-mcd__item--frxAUDUSD "]  60
    Click Element       //*[@class="sc-mcd__item sc-mcd__item--frxAUDUSD "]
#   select high/low
    wait until page contains element       ${contract_dropdown}      60
    Click Element       ${contract_dropdown}
    Click Element       dt_contract_high_low_item
#   change duration
    Input Text      //*[@class="dc-input__field"]   2   True
#   change payout
    Click Element       //*[@class="dc-input-wrapper"]
    press keys         dt_amount_input      CTRL+A  DELETE
    Input Text      dt_amount_input     15.50
#   buy lower contract
    wait until element is enabled       dt_purchase_put_button     60
    Click Element       dt_purchase_put_button

Relative Barrier Error
#   change barrier to output that has error
    Click Element       dt_barrier_1_input
    press keys         dt_barrier_1_input     CTRL+A  DELETE
    Input Text      dt_barrier_1_input     +1

#   change payout to 10
    Click Element       //*[@class="dc-input-wrapper"]
    press keys         dt_amount_input      CTRL+A  DELETE
    Input Text      dt_amount_input     10

#   check if the lower buttom is disabled
    Wait until page contains element       //*[text()="Contracts more than 24 hours in duration would need an absolute barrier." and contains(@class, "dc-text")]   60
    Element should be disabled      dt_purchase_put_button

Multiplier Contract
#   select Volatility 50
    Click Element       //*[text()="Synthetic Indices" and contains(@class, "sc-mcd__filter__item")]
    Click Element       //*[@class="sc-mcd__item sc-mcd__item--R_50 "]
#   select multiplier
    wait until page contains element       ${contract_dropdown}      60
    Click Element       ${contract_dropdown}
    Click Element       dt_contract_multiplier_item
Multiplier Contract (a)
#   No payout option
    wait until page contains element        //*[text()="Stake" and contains(@class, "trade-container__fieldset-info trade-container__fieldset-info--left")]   60
    Page should contain element  //*[text()="Stake" and contains(@class, "trade-container__fieldset-info trade-container__fieldset-info--left")]
    Page should not contain element     //*[text()="Payout" and contains(@class, "trade-container__fieldset-info trade-container__fieldset-info--left")]
#   Check only one of Deal cancelation or stop/loss can be selected

Multiplier Contract (b)
    wait until element is enabled   dt_purchase_multup_button     60
#    select stop/loss and take profit
    Click element   //*[@class="dc-checkbox take_profit-checkbox__input"]
    Click element  //*[@class="dc-checkbox stop_loss-checkbox__input"]
#    checking for checked checkbox
    Checkbox should be selected     dc_take_profit-checkbox_input
    Checkbox should be selected     dc_stop_loss-checkbox_input
    Checkbox should not be selected     dt_cancellation-checkbox_input
#    unselect stop/loss and take profit
    Click element   //*[@class="dc-checkbox take_profit-checkbox__input"]
    Click element  //*[@class="dc-checkbox stop_loss-checkbox__input"]
#    select deal cancellation
    Click element   //*[@class="dc-checkbox"]
#    checking for checked checkbox
    Checkbox should be selected     dt_cancellation-checkbox_input
    Checkbox should not be selected     dc_stop_loss-checkbox_input
    Checkbox should not be selected     dc_take_profit-checkbox_input





