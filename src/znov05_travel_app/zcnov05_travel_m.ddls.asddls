@EndUserText.label: 'Travel projection view - Processor'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@UI: {
 headerInfo: { typeName: 'Travel', typeNamePlural: 'Travels', title: { type: #STANDARD, value: 'TravelID' } } }

@Search.searchable: true

define root view entity ZCNOV05_TRAVEL_M
  as projection on ZInov05_TRAVEL_M
{
      @UI.facet: [ { id:              'Travel',
                     purpose:         #STANDARD,
                     type:            #IDENTIFICATION_REFERENCE,
                     label:           'Travel',
                     position:        10 } ]

      @UI.hidden: true
  key mykey              as TravelUUID,


      @UI: {
          lineItem:       [ { position: 10, importance: #HIGH } ],
          identification: [ { position: 10, label: 'Travel ID [1,...,99999999]' } ] }
      @Search.defaultSearchElement: true
      travel_id          as TravelID,

      @UI: {
          lineItem:       [ { position: 20, importance: #HIGH } ],
          identification: [ { position: 20 } ],
          selectionField: [ { position: 20 } ] }
      @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Agency', element: 'AgencyID'  } }]

      @ObjectModel.text.element: ['AgencyName'] ----meaning?
      @Search.defaultSearchElement: true
      agency_id          as AgencyID,
      _Agency.Name       as AgencyName,

      @UI: {
          lineItem:       [ { position: 30, importance: #HIGH } ],
          identification: [ { position: 30 } ],
          selectionField: [ { position: 30 } ] }
      @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Customer', element: 'CustomerID'  } }]

      @ObjectModel.text.element: ['CustomerName']
      @Search.defaultSearchElement: true
      customer_id        as CustomerID,

      @UI.hidden: true
      _Customer.LastName as CustomerName,

      @UI: {
          lineItem:       [ { position: 40, importance: #MEDIUM } ],
          identification: [ { position: 40 } ] }
      begin_date         as BeginDate,

      @UI: {
          lineItem:       [ { position: 41, importance: #MEDIUM } ],
          identification: [ { position: 41 } ] }
      end_date           as EndDate,

      @UI: {
          lineItem:       [ { position: 50, importance: #MEDIUM } ],
          identification: [ { position: 50, label: 'Total Price' } ] }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price        as TotalPrice,

      @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
      currency_code      as CurrencyCode,

      @UI: {
      lineItem:       [ { position: 60, importance: #HIGH },
                        { type: #FOR_ACTION, dataAction: 'acceptTravel', label: 'Accept Travel' } ],
      identification: [ { position: 60, label: 'Status [O(Open)|A(Accepted)|X(Canceled)]' } ]  }
      overall_status     as TravelStatus,

      @UI.identification: [ { position: 70, label: 'Remarks' } ]
      description        as Description,

      @UI.hidden: true
      last_changed_at    as LastChangedAt

}
