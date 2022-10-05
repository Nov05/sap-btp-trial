CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE   ztnov05_booking AS data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer.

    TYPES tt_bookings TYPE SORTED TABLE OF ty_buffer WITH UNIQUE KEY booking.

    CLASS-DATA mt_buffer TYPE tt_bookings.
ENDCLASS.


CLASS lcl_handler DEFINITION FINAL INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS modify FOR BEHAVIOR IMPORTING
                                  roots_to_create FOR CREATE booking
                                  roots_to_update FOR UPDATE booking
                                  roots_to_delete FOR DELETE booking.

    METHODS read FOR BEHAVIOR
      IMPORTING it_booking_key FOR READ booking RESULT et_booking.

    METHODS lock FOR BEHAVIOR
      IMPORTING it_booking_key FOR LOCK booking.
ENDCLASS.


CLASS lcl_handler IMPLEMENTATION.
  METHOD modify.

    " %cid = control field

    LOOP AT roots_to_delete INTO DATA(ls_delete).
      IF ls_delete-booking IS INITIAL.
        ls_delete-booking = mapped-booking[ %cid = ls_delete-%cid_ref ]-booking.
      ENDIF.

      READ TABLE lhc_buffer=>mt_buffer WITH KEY booking = ls_delete-booking ASSIGNING FIELD-SYMBOL(<ls_buffer>).
      IF sy-subrc = 0.
        IF <ls_buffer>-flag = 'C'.
          DELETE TABLE lhc_buffer=>mt_buffer WITH TABLE KEY booking = ls_delete-booking.
        ELSE.
          <ls_buffer>-flag = 'D'.
        ENDIF.
      ELSE.
        INSERT VALUE #( flag = 'D' booking = ls_delete-booking ) INTO TABLE lhc_buffer=>mt_buffer.
      ENDIF.
    ENDLOOP.

    " handle create
    IF roots_to_create IS NOT INITIAL.

      SELECT SINGLE MAX( booking ) FROM ztbooking_xxx INTO @DATA(lv_max_booking).
    ENDIF.

    LOOP AT roots_to_create INTO DATA(ls_create).
      "ADD 1 TO lv_max_booking.
      lv_max_booking = lv_max_booking + 1.
      ls_create-%data-booking = lv_max_booking.
      GET TIME STAMP FIELD DATA(zv_tsl).
      ls_create-%data-lastchangedat = zv_tsl.
      INSERT VALUE #( flag = 'C' data = CORRESPONDING #( ls_create-%data ) ) INTO TABLE lhc_buffer=>mt_buffer.

      IF ls_create-%cid IS NOT INITIAL.
        INSERT VALUE #( %cid = ls_create-%cid  booking = ls_create-booking ) INTO TABLE mapped-booking.
      ENDIF.
    ENDLOOP.

    " handle update
    IF roots_to_update IS NOT INITIAL.
      LOOP AT roots_to_update INTO DATA(ls_update).
        IF ls_update-booking IS INITIAL.
          ls_update-booking = mapped-booking[ %cid = ls_update-%cid_ref ]-booking.
        ENDIF.

        READ TABLE lhc_buffer=>mt_buffer WITH KEY booking = ls_update-booking ASSIGNING <ls_buffer>.
        IF sy-subrc <> 0.

          SELECT SINGLE * FROM ztbooking_xxx WHERE booking = @ls_update-booking INTO @DATA(ls_db).
          INSERT VALUE #( flag = 'U' data = ls_db ) INTO TABLE lhc_buffer=>mt_buffer ASSIGNING <ls_buffer>.
        ENDIF.

        IF ls_update-%control-customername IS NOT INITIAL..
          <ls_buffer>-customername = ls_update-customername.
        ENDIF.
        IF ls_update-%control-cost  IS NOT INITIAL..
          <ls_buffer>-cost = ls_update-cost.
        ENDIF.
        IF ls_update-%control-dateoftravel   IS NOT INITIAL..
          <ls_buffer>-dateoftravel  = ls_update-dateoftravel .
        ENDIF.
        IF ls_update-%control-currencycode  IS NOT INITIAL..
          <ls_buffer>-currencycode = ls_update-currencycode.
        ENDIF.
        GET TIME STAMP FIELD DATA(zv_tsl2).
        <ls_buffer>-lastchangedat = zv_tsl2.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD read.
    LOOP AT it_booking_key INTO DATA(ls_booking_key).
      " check if it is in buffer (and not deleted).
      READ TABLE lhc_buffer=>mt_buffer WITH KEY booking = ls_booking_key-booking INTO DATA(ls_booking).
      IF sy-subrc = 0 AND ls_booking-flag <> 'U'.
        INSERT CORRESPONDING #( ls_booking-data ) INTO TABLE et_booking.
      ELSE.
        SELECT SINGLE * FROM ztnov05_booking WHERE booking = @ls_booking_key-booking INTO @DATA(ls_db).
        IF sy-subrc = 0.
          INSERT CORRESPONDING #( ls_db ) INTO TABLE et_booking.
        ELSE.
          INSERT VALUE #( booking = ls_booking_key-booking ) INTO TABLE failed-booking.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD lock.
    "provide the appropriate lock handling if required
  ENDMETHOD.

  "METHOD get_instance_authorizations.
  "ENDMETHOD.

ENDCLASS.


CLASS lcl_saver DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS finalize          REDEFINITION.
    METHODS check_before_save REDEFINITION.
    METHODS save              REDEFINITION.
ENDCLASS.


CLASS lcl_saver IMPLEMENTATION.

  METHOD save.
    DATA lt_data TYPE STANDARD TABLE OF ztnov05_booking.

    lt_data = VALUE #(  FOR row IN lhc_buffer=>mt_buffer WHERE  ( flag = 'C' ) (  row-data ) ).
    IF lt_data IS NOT INITIAL.
      INSERT ztnov05_booking FROM TABLE @lt_data.
    ENDIF.
    lt_data = VALUE #(  FOR row IN lhc_buffer=>mt_buffer WHERE  ( flag = 'U' ) (  row-data ) ).
    IF lt_data IS NOT INITIAL.
      UPDATE ztnov05_booking FROM TABLE @lt_data.
    ENDIF.
    lt_data = VALUE #(  FOR row IN lhc_buffer=>mt_buffer WHERE  ( flag = 'D' ) (  row-data ) ).
    IF lt_data IS NOT INITIAL.
      DELETE ztnov05_booking FROM TABLE @lt_data.
    ENDIF.
  ENDMETHOD.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.
ENDCLASS.
