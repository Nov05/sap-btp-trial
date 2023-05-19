CLASS zclnov05_graph_01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zclnov05_graph_01 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA(lv_str) = 'testing'.
    out->write( lv_str && | "Hello World"| ).
  ENDMETHOD.
ENDCLASS.
