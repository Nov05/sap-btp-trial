CLASS zclnov05_get_account_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zclnov05_get_account_data IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: lt_accounts TYPE ZTTnov05_ACCOUNTS.

    SELECT * FROM zaccounts_cgnk
    INTO TABLE @lt_accounts.

    out->write( EXPORTING
                data = lt_accounts
                name = 'Accounts:' ).
  ENDMETHOD.
ENDCLASS.
