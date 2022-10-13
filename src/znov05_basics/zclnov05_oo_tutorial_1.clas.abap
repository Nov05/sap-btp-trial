
CLASS zclnov05_oo_tutorial_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES: simple_table_type TYPE STANDARD TABLE OF string.
    DATA: simple_internal_table TYPE simple_table_type.
    "! <p class="shorttext synchronized" lang="en">My First Method</p>
    "!
    "! @parameter import | <p class="shorttext synchronized" lang="en">string</p>
    "! @parameter export | <p class="shorttext synchronized" lang="en">string</p>
    METHODS my_first_method
      IMPORTING
                !import       TYPE string
      RETURNING VALUE(export) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zclnov05_oo_tutorial_1 IMPLEMENTATION.
  METHOD my_first_method.
    export = import.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    out->write( `Testing ABAP OOP tutorial 1 class` ).
    out->write( me->my_first_method( `Output is input` ) ).
  ENDMETHOD.

ENDCLASS.
