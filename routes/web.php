<?php

/*
Route::get('inicio', function () {
    return view('landing.index');  
})->name('inicio');
*/

Route::get('/', 'AppController@index');

Route::post('login', 'AppController@login')->middleware('guest');
Route::get('register', 'Auth\RegisterController@showRegistrationForm')->name('register');
Route::post('register', 'Auth\RegisterController@register');
Route::post('/logout', 'AppController@logout')->middleware('auth');

// Password Reset Routes...
Route::get('password/reset', 'Auth\ForgotPasswordController@showLinkRequestForm')->name('password.request');
Route::post('password/email', 'Auth\ForgotPasswordController@sendResetLinkEmail')->name('password.email');
Route::get('password/reset/{token}', 'Auth\ResetPasswordController@showResetForm')->name('password.reset');
Route::post('password/reset', 'Auth\ResetPasswordController@reset');

Route::get('getLogo','AppController@getLogo');

//Cotizacion
Route::resource('estimate', 'EstimateController');
Route::get('getEstimateBaseInfo','EstimateController@BaseInfo');
Route::get('getEstimateList','EstimateController@getEstimateList');
Route::get('estimate/{id}/pdf', 'EstimateController@pdf');
Route::get('getTemplateEmailToCustomerEstimate/{resolution_id}', 'EstimateController@getTemplateEmailToCustomer');

//taxes
Route::resource('taxes', 'TaxesController');
Route::get('getTaxesBaseInfo','TaxesController@BaseInfo');
Route::get('getTaxesList','TaxesController@getTaxesList');

//Retentions
Route::resource('retention', 'RetentionController');
Route::get('getRetentionBaseInfo','RetentionController@BaseInfo');
Route::get('getRetentionList','RetentionController@getRetentionList');

//payment terms
Route::resource('payterms', 'PaymentTermsController');
Route::get('getPaymentTermsList','PaymentTermsController@getPaymentTermsList');

//profile
Route::resource('profile', 'ProfileController');
Route::get('getProfileInfo','ProfileController@BaseInfo');
//Bank accounts
Route::resource('bank_account', 'BankAccountController');
Route::get('getBankAccount_Type','BankAccountController@BaseInfo');
Route::get('getBankAccountlist','BankAccountController@BankAccountIndex');
Route::get('getBankList','BankAccountController@bankList');
Route::get('getbank_transaction_history/{bank_id}','BankAccountController@bank_transaction_history');
Route::post('saveBankTransference','BankAccountController@CreateBankTransference');

//precio de lista
Route::resource('list_price', 'ListPriceController');
Route::get('getListPriceList','ListPriceController@getListPriceList');
Route::put('listprice_update_state/{req}','ListPriceController@update_state');

//Contacts
Route::resource('contact', 'ContactsController');
Route::get('getContactBaseInfo','ContactsController@BaseInfo');
Route::get('getContactlist/{filter}','ContactsController@ContactIndex');
Route::get('getContactReports/{process_type}/{contact_id}', 'ContactsController@getContactReports');
Route::post('sendEmailToContact','ContactsController@sendEmailToContact');

//Seller
Route::resource('seller', 'SellerController');

//Inventory
Route::resource('inventory', 'InventoryController');
Route::get('getInventoryBaseInfo','InventoryController@BaseInfo');
Route::get('getInventorylist','InventoryController@InventoryIndex');
Route::get('inventory/getInventoryReports/{process_type}/{product_id}', 'InventoryController@getInventoryReports');


//Category
Route::resource('category', 'CategoryController');
Route::get('getCategoryIncome','CategoryController@CategoryIncome');
Route::get('getCategoryAll','CategoryController@CategoryAll');

//Company
Route::resource('account', 'AccountController');

//Resolution
Route::resource('resolution', 'ResolutionController');
Route::get('getresolutionlist','ResolutionController@resolutionIndex');
Route::get('getresolutionlist_number','ResolutionController@resolution_numbers');
Route::put('update_state/{req}','ResolutionController@update_state');
Route::put('update_numeration/{req}','ResolutionController@update_numeration');

//Remision
Route::resource('remision', 'RemisionController');
Route::get('getRemisionBaseInfo','RemisionController@BaseInfo');
Route::get('getRemisionList','RemisionController@getRemisionList');
Route::get('remision/{id}/pdf', 'RemisionController@pdf');
Route::put('remision_update_state/{req}','RemisionController@update_state');
Route::get('getTemplateEmailToCustomerRemision/{resolution_id}', 'RemisionController@getTemplateEmailToCustomer');


//Invoice for sale
Route::resource('invoice', 'InvoiceSaleOrderController');
Route::get('getInvoiceBaseInfo','InvoiceSaleOrderController@BaseInfo');
Route::get('getInvoiceList','InvoiceSaleOrderController@getInvoiceList');
Route::get('invoice/{id}/pdf', 'InvoiceSaleOrderController@pdf');
Route::put('invoice_update_state/{req}','InvoiceSaleOrderController@update_state');
Route::get('getTemplateEmailToCustomerInvoice/{resolution_id}', 'InvoiceSaleOrderController@getTemplateEmailToCustomer');

//Nota crédito
Route::resource('credit-note', 'CreditNoteController');
Route::get('getCreditNoteBaseInfo','CreditNoteController@BaseInfo');
Route::get('getCreditNoteList','CreditNoteController@getCreditNoteList');
Route::get('credit-note/{id}/pdf', 'CreditNoteController@pdf');
Route::get('getTemplateEmailToCustomerCreditNote/{resolution_id}', 'CreditNoteController@getTemplateEmailToCustomer');

//payment received
Route::resource('payment-in', 'PaymentIn_Controller');
Route::get('getPaymentList','PaymentIn_Controller@getPaymentList');
Route::get('getPaymentBaseInfo','PaymentIn_Controller@BaseInfo');
Route::get('getInvoicePendingtoPay/{customer_id}','PaymentIn_Controller@getInvoicePendingtoPay_data');
Route::get('getInvoicePendingtoPay_edit/{customer_id}','PaymentIn_Controller@getInvoicePendingtoPay_data_edit');
Route::put('payment_in_update_state/{req}','PaymentIn_Controller@update_state');
Route::get('payment_in_ToCategorySection','PaymentIn_Controller@getBaseInfoToCategorySection');
Route::get('payment-in/{id}/pdf', 'PaymentIn_Controller@pdf');
Route::get('getTemplateEmailToCustomerPaymentIn/{resolution_id}', 'PaymentIn_Controller@getTemplateEmailToCustomer');


//payment made by customer
Route::resource('payment-out', 'PaymentOut_Controller');
Route::get('getPaymentOut_List','PaymentOut_Controller@getPaymentList');
Route::get('getPaymentOut_BaseInfo','PaymentOut_Controller@BaseInfo');
Route::get('getInvoicePendingtoPay_out/{customer_id}','PaymentOut_Controller@getInvoicePendingtoPay_data');
Route::get('getInvoicePendingtoPay_edit_out/{customer_id}','PaymentOut_Controller@getInvoicePendingtoPay_data_edit');
Route::get('payment_out_ToCategorySection','PaymentOut_Controller@getBaseInfoToCategorySection');
Route::put('payment_out_update_state/{req}','PaymentOut_Controller@update_state');
Route::get('payment-out/{id}/pdf', 'PaymentOut_Controller@pdf');
Route::get('getTemplateEmailToCustomerPaymentOut/{resolution_id}', 'PaymentOut_Controller@getTemplateEmailToCustomer');

//purchase order
Route::resource('purchase-order', 'PurchaseOrderController');
Route::get('getPOBaseInfo','PurchaseOrderController@BaseInfo');
Route::get('getPOList','PurchaseOrderController@getPOList');
Route::get('purchase-order/{id}/pdf', 'PurchaseOrderController@pdf');
Route::get('getTemplateEmailToCustomerPO/{resolution_id}', 'PurchaseOrderController@getTemplateEmailToCustomer');

//Nota Debito
Route::resource('debit-note', 'DebitNoteController');
Route::get('getDebitNoteBaseInfo','DebitNoteController@BaseInfo');
Route::get('getDebitNoteList','DebitNoteController@getDebitNoteList');
Route::get('debit-note/{id}/pdf', 'DebitNoteController@pdf');

//Bill
Route::resource('bill', 'BillController');
Route::get('getBillBaseInfo','BillController@BaseInfo');
Route::get('getBillList','BillController@getBillList');
Route::get('bill/{id}/pdf', 'BillController@pdf');
Route::put('bill_update_state/{req}','BillController@update_state');




define('INVOICE_STATUS_OPEN', 1);
define('INVOICE_STATUS_VOIDED', 2);//=>NULL
define('INVOICE_STATUS_APPROVED', 3);
define('INVOICE_STATUS_PAID',4);
define('INVOICE_STATUS_DRAFT', 5);
define('INVOICE_STATUS_CLOSE', 6);
define('INVOICE_STATUS_SENT', 7);

define('BILL_STATUS_OPEN', 1);
define('BILL_STATUS_VOIDED', 2);
define('BILL_STATUS_APPROVED', 3);
define('BILL_STATUS_PAID',4);
define('BILL_STATUS_DRAFT', 5);
define('BILL_STATUS_CLOSE', 6);
define('BILL_STATUS_SENT', 7);

define('PAYMENT_STATUS_APPLIED', 1);
define('PAYMENT_STATUS_VOIDED', 2);
define('PAYMENT_STATUS_RETURNED', 3);
define('PAYMENT_STATUS_COMPLETE',4);

define('PAYMENT_INCOME_TYPE', 'in');
define('PAYMENT_OUTCOME_TYPE', 'eg');

define('CURRENCY_CODE_DEFAULT', 'COP');

define('CATEGORY_TYPE_INCOME', 1);
define('CATEGORY_TYPE_OUTCOME', 2);
define('CATEGORY_TYPE_ASSETS', 3); //ACTIVOS
define('CATEGORY_TYPE_LIABILITIES',4); //pasivos
define('CATEGORY_TYPE_PATRIMONY',5);
define('CATEGORY_TYPE_TRANSFERENCE',6);

define('CONTACT_IS_PROVIDER','p');
define('CONTACT_IS_CUSTOMER','c');

define('PAYMENT_LOCAL_VIEW_EVENT_OUT','/payment-out/');
define('PAYMENT_LOCAL_VIEW_OUT','payment-out');
define('PAYMENT_LOCAL_VIEW_EVENT_IN','/payment-in/');
define('PAYMENT_LOCAL_VIEW_IN','payment-in');

