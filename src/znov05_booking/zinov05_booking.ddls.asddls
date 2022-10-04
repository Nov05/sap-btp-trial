@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '20221004 SAP BTP Trial'
define root view entity zinov05_booking
  as select from ztnov05_booking
  association [0..1] to I_Country  as _Country  on $projection.country = _Country.Country
  association [0..1] to I_Currency as _Currency on $projection.currencycode = _Currency.Currency
{
  key booking,
      customername,
      numberofpassengers,
      emailaddress,
      country,
      dateofbooking,
      dateoftravel,
      cost,
      currencycode,
      lastchangedat,
      /* Associations */
      _Country,
      _Currency
}
