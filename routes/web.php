<?php


/*Route::get('/', function () {
         if(Auth::check()) {
            return view('home');
        }
        return view('welcome');
});
*/
Route::get('/', 'AppController@index');

Route::post('login', 'AppController@login')->middleware('guest');
Route::post('register', 'AppController@login')->middleware('auth');
Route::post('/logout', 'AppController@logout')->middleware('auth');
Route::get('getLogo','AppController@getLogo');

/*
Route::group(['middleware'=>['api']],function()
{
    Route::post('validate/user',['uses'=>'Validation\UserController@user',]);
});
*/
//Auth::routes();
//Route::get('/home','HomeController@index');


//Información del header de la cotización
Route::resource('estimate', 'EstimateController');
Route::get('getEstimateBaseInfo','EstimateController@BaseInfo');
Route::get('getEstimateList','EstimateController@getEstimateList');
Route::get('estimate/{id}/pdf', 'EstimateController@pdf');

//taxes
Route::resource('taxes', 'TaxesController');
Route::get('getTaxesBaseInfo','TaxesController@BaseInfo');
//Retentions
Route::resource('retention', 'RetentionController');
Route::get('getRetentionBaseInfo','RetentionController@BaseInfo');
//payment terms
Route::resource('payterms', 'PaymentTermsController');

//profile
Route::resource('profile', 'ProfileController');
Route::get('getProfileInfo','ProfileController@BaseInfo');
//Bank accounts
Route::resource('bank_account', 'BankAccountController');
Route::get('getBankAccount_Type','BankAccountController@BaseInfo');

//precio de lista
Route::resource('list_price', 'ListPriceController');

//Contacts
Route::resource('contact', 'ContactsController');
Route::get('getContactBaseInfo','ContactsController@BaseInfo');
Route::get('getContactlist/{filter}','ContactsController@ContactIndex');

//Seller
Route::resource('seller', 'SellerController');

//Inventory
Route::resource('inventory', 'InventoryController');
Route::get('getInventoryBaseInfo','InventoryController@BaseInfo');
Route::get('getInventorylist','InventoryController@InventoryIndex');

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


//Invoice for sale
Route::resource('invoice', 'InvoiceSaleOrderController');
Route::get('getInvoiceBaseInfo','InvoiceSaleOrderController@BaseInfo');
Route::get('getInvoiceList','InvoiceSaleOrderController@getInvoiceList');
Route::get('invoice/{id}/pdf', 'InvoiceSaleOrderController@pdf');
Route::put('invoice_update_state/{req}','InvoiceSaleOrderController@update_state');
