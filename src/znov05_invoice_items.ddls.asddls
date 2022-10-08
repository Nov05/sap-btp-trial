@AbapCatalog.sqlViewName: 'ZNOV05_ITEM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Items'
define view znov05_invoice_items
  as select from zte_ta_so_item
{
  key item_id  as ItemId,
  key order_id as OrderId,
      amount   as GrossAmount,
      currency as CurrencyCode
}
where
  currency = 'INR'
