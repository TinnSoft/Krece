<?php
namespace App\Utilities;
use App\Models\{
    User,
    Account,
    Category,
    Tax,
    Resolution,
    ResolutionNumber,
    Retention,
    PaymentTerms,
    ListPrice,
    BankAccount
};
use DB;

class DataFillNewUsers
{
    
    //constructor
    public function fill(User $user)
    {        
        //verificar/crear si el usuario actual ya tiene una cuenta asociada, la cuenta es la información de la empresa
        $account=$this->createAccountForCurrentUser($user);
        
        //Asociar el usuario creado con el id de la organización
        DB::table('user')
            ->where('id', $user->id)
            ->update(['account_id' => $account->id]);

        //Verificar la tabla categorías que el usuario actual tenga asociados los correspondientes items
        $userHasCategories=Category::where('account_id',$account->id)->count();
        
        if ($userHasCategories==0)
        {
            //categorias
            $this->fillCategories($account->id, $user->id);
        }
        
        //Impuestos
        $this->fillTaxes($user, $account);

        //Numeros de resolución para las facturas de venta
        $this->fillResolutionNumberForInvoice($user, $account);

        //Numeros de resolución para todos los modulos excepto invoice
        $this->fillResolutionNumbers($user, $account);

        //retenciones en la fuente
        $this->fillRetention($user, $account);

        $this->fillPaymentTerms($user, $account);

        $this->fillListPrice($user, $account);

        $this->fillBanks($user, $account);
    }

     private static function fillListPrice(User $user, Account $account)
    {
        $userHasListPrice=ListPrice::where('account_id',$account->id)->count();
        if ($userHasListPrice==0)
        {
            
            ListPrice::create([
                'account_id'=>$account->id,
                'public_id'=>1,
                'user_id'=>$user->id,
                'name'=>'General',
                'value'=>0,
                'type_id'=>2,
                'isDefault'=>1,
                'isEnabled'=>1
            ]);
        }
    }

    private static function fillBanks(User $user, Account $account)
    {
        $userHasBanks=BankAccount::where('account_id',$account->id)->count();
        if ($userHasBanks==0)
        {
            DB::table('bank_account')->insert([
                [
                    'account_id'=>$account->id,
                    'public_id'=>1,
                    'user_id'=>$user->id,
                    'bank_account_name'=>'Banco 1',
                    'bank_account_type_id'=>1,
                    'initial_balance'=>0,
                    'isDefault'=>1
                ],
                [
                    'account_id'=>$account->id,
                    'public_id'=>2,
                    'user_id'=>$user->id,
                    'bank_account_name'=>'Tarjeta de crédito 1',
                    'bank_account_type_id'=>2,
                    'initial_balance'=>0,
                    'isDefault'=>0
                ],
                [
                    'account_id'=>$account->id,
                    'public_id'=>3,
                    'user_id'=>$user->id,
                    'bank_account_name'=>'Caja general',
                    'bank_account_type_id'=>3,
                    'initial_balance'=>0,
                    'isDefault'=>0
                ]
            ]);

            /*
            BankAccount::create([
                'account_id'=>$account->id,
                'public_id'=>BankAccount::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'bank_account_name'=>'Banco 1',
                'bank_account_type_id'=>1,
                'initial_balance'=>0,
                'isDefault'=>1
            ]);

            BankAccount::create([
                'account_id'=>$account->id,
                'public_id'=>BankAccount::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'bank_account_name'=>'Tarjeta de crédito 1',
                'bank_account_type_id'=>2,
                'initial_balance'=>0,
                'isDefault'=>0
            ]);

            BankAccount::create([
                'account_id'=>$account->id,
                'public_id'=>BankAccount::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'bank_account_name'=>'Caja general',
                'bank_account_type_id'=>3,
                'initial_balance'=>0,
                'isDefault'=>0
            ]);
            */
        }
    }

     private static function fillPaymentTerms(User $user, Account $account)
    {
        $userHasPaymentTerm=PaymentTerms::where('account_id',$account->id)->count();
        if ($userHasPaymentTerm==0)
        {
            DB::table('payment_terms')->insert([
               [
                    'account_id'=>$account->id,
                    'public_id'=>1,
                    'user_id'=>$user->id,
                    'name'=>'Vencimiento manual',
                    'days'=>0
                ],
                [
                    'account_id'=>$account->id,
                    'public_id'=>2,
                    'user_id'=>$user->id,
                    'name'=>'De contado',
                    'days'=>0
                ],
                [
                    'account_id'=>$account->id,
                    'public_id'=>3,
                    'user_id'=>$user->id,
                    'name'=>'8 días',
                    'days'=>8
                ],
                [
                    'account_id'=>$account->id,
                    'public_id'=>4,
                    'user_id'=>$user->id,
                    'name'=>'15 días',
                    'days'=>15
                ],
                [
                    'account_id'=>$account->id,
                    'public_id'=>5,
                    'user_id'=>$user->id,
                    'name'=>'30 días',
                    'days'=>30
                ],
                [
                    'account_id'=>$account->id,
                    'public_id'=>6,
                    'user_id'=>$user->id,
                    'name'=>'60 días',
                    'days'=>60
                ]
                ]);
            
            /*
            PaymentTerms::create([
                'account_id'=>$account->id,
                'public_id'=>PaymentTerms::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'Vencimiento manual',
                'days'=>0
            ]);

            PaymentTerms::create([
                'account_id'=>$account->id,
                'public_id'=>PaymentTerms::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'De contado',
                'days'=>0
            ]);

            PaymentTerms::create([
                'account_id'=>$account->id,
                'public_id'=>PaymentTerms::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'8 días',
                'days'=>8
            ]);

            PaymentTerms::create([
                'account_id'=>$account->id,
                'public_id'=>PaymentTerms::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'15 días',
                'days'=>15
            ]);

            PaymentTerms::create([
                'account_id'=>$account->id,
                'public_id'=>PaymentTerms::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'30 días',
                'days'=>30
            ]);

            PaymentTerms::create([
                'account_id'=>$account->id,
                'public_id'=>PaymentTerms::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'60 días',
                'days'=>60
            ]);
           */
        }
    }
    
    private static function fillRetention(User $user, Account $account)
    {
        $userHasRetention=Retention::where('account_id',$account->id)->count();
        if ($userHasRetention==0)
        {
             DB::table('retention')->insert([
              [
                'account_id'=>$account->id,
                'public_id'=>1,
                'user_id'=>$user->id,
                'name'=>'Arrendamiento de bienes inmuebles',
                'value'=>4,
                'Description'=>'',
                'type_id'=>2
            ],
            [
                'account_id'=>$account->id,
                'public_id'=>2,
                'user_id'=>$user->id,
                'name'=>'Arrendamiento de bienes raices',
                'value'=>3.5,
                'Description'=>'Retencion aplicada a pagos de arrendamiento de bienes raices',
                'type_id'=>2
            ],
            [
                'account_id'=>$account->id,
                'public_id'=>3,
                'user_id'=>$user->id,
                'name'=>'Compras declarantes',
                'value'=>2.5,
                'Description'=>'Retencion aplicada a compras declarantes',
                'type_id'=>2
            ],
            [
                'account_id'=>$account->id,
                'public_id'=>4,
                'user_id'=>$user->id,
                'name'=>'Compras no declarantes',
                'value'=>3.5,
                'Description'=>'Retencion aplicada a compras no declarantes',
                'type_id'=>2
            ],
            [
                'account_id'=>$account->id,
                'public_id'=>5,
                'user_id'=>$user->id,
                'name'=>'Honorarios y comisiones (naturales)',
                'value'=>10,
                'Description'=>'Retencion aplicada a personas naturales',
                'type_id'=>2
            ],
            [
                'account_id'=>$account->id,
                'public_id'=>6,
                'user_id'=>$user->id,
                'name'=>'Honoraios y comisiones (jurídicas)',
                'value'=>11,
                'Description'=>'Retencion aplicada a personas juridicas',
                'type_id'=>2
            ],
            [
                'account_id'=>$account->id,
                'public_id'=>7,
                'user_id'=>$user->id,
                'name'=>'Servicios de aseo y vigilancia',
                'value'=>2,
                'Description'=>'Retencion aplicada a pagos de servicios en aseo y/o vigilancia',
                'type_id'=>2
            ],
            [
                'account_id'=>$account->id,
                'public_id'=>8,
                'user_id'=>$user->id,
                'name'=>'Servicios de hoteles y restaurantes',
                'value'=>3.5,
                'Description'=>'Retencion aplicada por servicios de hoteles, restaurantes y hospedaje a declarantes y no declarantes',
                'type_id'=>2
            ],
            [
                'account_id'=>$account->id,
                'public_id'=>9,
                'user_id'=>$user->id,
                'name'=>'Servicios generales (declarantes)',
                'value'=>4,
                'Description'=>'Retencion aplicada a pagos de personas declarantes',
                'type_id'=>2
            ],
            [
                'account_id'=>$account->id,
                'public_id'=>10,
                'user_id'=>$user->id,
                'name'=>'Servicios generales (no declarantes)',
                'value'=>6,
                'Description'=>'Retencion aplicada a pagos de personas no declarantes',
                'type_id'=>2
            ],
            [
                'account_id'=>$account->id,
                'public_id'=>11,
                'user_id'=>$user->id,
                'name'=>'ReteIca',
                'value'=>0,
                'Description'=>'Retencion de industria y comercio',
                'type_id'=>3
            ],
            [
                'account_id'=>$account->id,
                'public_id'=>12,
                'user_id'=>$user->id,
                'name'=>'ReteIva',
                'value'=>15,
                'Description'=>'Retencion sobre el total del IVA asociado a una factura',
                'type_id'=>1
            ],
            [
                'account_id'=>$account->id,
                'public_id'=>13,
                'user_id'=>$user->id,
                'name'=>'Transporte de carga',
                'value'=>15,
                'Description'=>'',
                'type_id'=>2
            ]
             ]);
             /*
            Retention::create([
                'account_id'=>$account->id,
                'public_id'=>Retention::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'Arrendamiento de bienes inmuebles',
                'value'=>4,
                'Description'=>'',
                'type_id'=>2
            ]);

            Retention::create([
                'account_id'=>$account->id,
                'public_id'=>Retention::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'Arrendamiento de bienes raices',
                'value'=>3.5,
                'Description'=>'Retencion aplicada a pagos de arrendamiento de bienes raices',
                'type_id'=>2
            ]);

            Retention::create([
                'account_id'=>$account->id,
                'public_id'=>Retention::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'Compras declarantes',
                'value'=>2.5,
                'Description'=>'Retencion aplicada a compras declarantes',
                'type_id'=>2
            ]);

            Retention::create([
                'account_id'=>$account->id,
                'public_id'=>Retention::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'Compras no declarantes',
                'value'=>3.5,
                'Description'=>'Retencion aplicada a compras no declarantes',
                'type_id'=>2
            ]);

            Retention::create([
                'account_id'=>$account->id,
                'public_id'=>Retention::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'Honorarios y comisiones (naturales)',
                'value'=>10,
                'Description'=>'Retencion aplicada a personas naturales',
                'type_id'=>2
            ]);

            Retention::create([
                'account_id'=>$account->id,
                'public_id'=>Retention::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'Honoraios y comisiones (jurídicas)',
                'value'=>11,
                'Description'=>'Retencion aplicada a personas juridicas',
                'type_id'=>2
            ]);

            Retention::create([
                'account_id'=>$account->id,
                'public_id'=>Retention::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'Servicios de aseo y vigilancia',
                'value'=>2,
                'Description'=>'Retencion aplicada a pagos de servicios en aseo y/o vigilancia',
                'type_id'=>2
            ]);

            Retention::create([
                'account_id'=>$account->id,
                'public_id'=>Retention::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'Servicios de hoteles y restaurantes',
                'value'=>3.5,
                'Description'=>'Retencion aplicada por servicios de hoteles, restaurantes y hospedaje a declarantes y no declarantes',
                'type_id'=>2
            ]);

            Retention::create([
                'account_id'=>$account->id,
                'public_id'=>Retention::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'Servicios generales (declarantes)',
                'value'=>4,
                'Description'=>'Retencion aplicada a pagos de personas declarantes',
                'type_id'=>2
            ]);

            Retention::create([
                'account_id'=>$account->id,
                'public_id'=>Retention::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'Servicios generales (no declarantes)',
                'value'=>6,
                'Description'=>'Retencion aplicada a pagos de personas no declarantes',
                'type_id'=>2
            ]);

            Retention::create([
                'account_id'=>$account->id,
                'public_id'=>Retention::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'ReteIca',
                'value'=>0,
                'Description'=>'Retencion de industria y comercio',
                'type_id'=>3
            ]);

            Retention::create([
                'account_id'=>$account->id,
                'public_id'=>Retention::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'ReteIva',
                'value'=>15,
                'Description'=>'Retencion sobre el total del IVA asociado a una factura',
                'type_id'=>1
            ]);

            Retention::create([
                'account_id'=>$account->id,
                'public_id'=>Retention::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'Transporte de carga',
                'value'=>15,
                'Description'=>'',
                'type_id'=>2
            ]); */
        }
    }

    private static function fillTaxes(User $user, Account $account)
    {
        $userHasTaxes=Tax::where('account_id',$account->id)->count();
        if ($userHasTaxes==0)
        {
            DB::table('tax')->insert([
               [
                    'account_id'=>$account->id,
                    'public_id'=>1,
                    'user_id'=>$user->id,
                    'name'=>'IVA',
                    'amount'=>19,
                    'Description'=>'IVA',
                    'type_id'=>1,
                    'isEditable'=>1
                ],
                [
                    'account_id'=>$account->id,
                    'public_id'=>2,
                    'user_id'=>$user->id,
                    'name'=>'ICO',
                    'amount'=>19,
                    'Description'=>'ICO',
                    'type_id'=>2,
                    'isEditable'=>1
                ],
                [
                    'account_id'=>$account->id,
                    'public_id'=>3,
                    'user_id'=>$user->id,
                    'name'=>'Ninguno',
                    'amount'=>0,
                    'Description'=>'Ninguno',
                    'type_id'=>3,
                    'isEditable'=>1
                ]
            ]);

            /*
            Tax::create([
                'account_id'=>$account->id,
                'public_id'=>Tax::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'IVA',
                'amount'=>19,
                'Description'=>'IVA',
                'type_id'=>1,
                'isEditable'=>1
            ]);

            Tax::create([
                'account_id'=>$account->id,
                'public_id'=>Tax::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'ICO',
                'amount'=>19,
                'Description'=>'ICO',
                'type_id'=>2,
                'isEditable'=>1
            ]);

            Tax::create([
                'account_id'=>$account->id,
                'public_id'=>Tax::where('account_id', $account->id)->max('public_id')+1,
                'user_id'=>$user->id,
                'name'=>'Ninguno',
                'amount'=>0,
                'Description'=>'Ninguno',
                'type_id'=>3,
                'isEditable'=>1
            ]);
            */
        }
    }

    private static function fillResolutionNumberForInvoice(User $user, Account $account)
    {
        $userHasResolution=Resolution::where('account_id',$account->id)->count();
        if ($userHasResolution==0)
        {            
            Resolution::create([
                'account_id'=>$account->id,
                'public_id'=>1,
                'user_id'=>$user->id,
                'initial_number'=>1,
                'next_invoice_number'=>1,
                'name'=>'Principal',
                'isDefault'=>1,
                'isActive'=>1,
                'auto_increment'=>1
            ]);

        }
    }
    
    private static function fillResolutionNumbers(User $user, Account $account)
    {
        $userHasResolution=ResolutionNumber::where('account_id',$account->id)->count();
        if ($userHasResolution==0)
        {          

             DB::table('resolution_numbers')->insert([
              [
                'account_id'=>$account->id,
                'key'=>'estimate',
                'number'=>1,
                'text'=>'Siguiente número de cotizaciones'
            ],
            [
                'account_id'=>$account->id,
                'key'=>'purchase_order',
                'number'=>1,
                'text'=>'Siguiente número de órdenes de compra'
            ],
            [
                'account_id'=>$account->id,
                'key'=>'credit_note',
                'number'=>1,
                'text'=>'Siguiente número de nota credito'
            ],
            [
                'account_id'=>$account->id,
                'key'=>'remision',
                'number'=>1,
                'text'=>'Siguiente número de remisiones'
            ],
            [
                'account_id'=>$account->id,
                'key'=>'in-come',
                'number'=>1,
                'text'=>'Siguiente número de recibo de caja'
            ],
            [
                'account_id'=>$account->id,
                'key'=>'debit_note',
                'number'=>1,
                'text'=>'Siguiente número de nota debito'
            ],
            [
                'account_id'=>$account->id,
                'key'=>'bill',
                'number'=>1,
                'text'=>'Siguiente número de factura de proveedores'
            ],
            [
                'account_id'=>$account->id,
                'key'=>'out-come',
                'number'=>1,
                'text'=>'Siguiente número de comprobante de pago'
            ]
            ]);
             /*
            ResolutionNumber::create([
                'account_id'=>$account->id,
                'key'=>'estimate',
                'number'=>1,
                'text'=>'Siguiente número de cotizaciones'
            ]);

            ResolutionNumber::create([
                'account_id'=>$account->id,
                'key'=>'purchase_order',
                'number'=>1,
                'text'=>'Siguiente número de órdenes de compra'
            ]);

            ResolutionNumber::create([
                'account_id'=>$account->id,
                'key'=>'credit_note',
                'number'=>1,
                'text'=>'Siguiente número de nota credito'
            ]);

            ResolutionNumber::create([
                'account_id'=>$account->id,
                'key'=>'remision',
                'number'=>1,
                'text'=>'Siguiente número de remisiones'
            ]);

            ResolutionNumber::create([
                'account_id'=>$account->id,
                'key'=>'in-come',
                'number'=>1,
                'text'=>'Siguiente número de recibo de caja'
            ]);

            ResolutionNumber::create([
                'account_id'=>$account->id,
                'key'=>'debit_note',
                'number'=>1,
                'text'=>'Siguiente número de nota debito'
            ]);

            ResolutionNumber::create([
                'account_id'=>$account->id,
                'key'=>'bill',
                'number'=>1,
                'text'=>'Siguiente número de factura de proveedores'
            ]);

            ResolutionNumber::create([
                'account_id'=>$account->id,
                'key'=>'out-come',
                'number'=>1,
                'text'=>'Siguiente número de comprobante de pago'
            ]);
            */

        }
    }

    private static function createAccountForCurrentUser(User $user)
    {
        $userAccountExists=Account::where('email','=',$user->email)->count();
        if ($userAccountExists==0)
        {
            return Account::create([
            'name' => $user->name,
            'email' => $user->email,
            'decimal_precision' => '0',
            'decimal_separator' => '.'
            ]);
        }
        
        return Account::where('email','=',$user->email)->select('id','name')->first();
        
    }
    
    private static function fillCategories($accountID, $user_id)
    {
        $account_id = $accountID;
        $user_ID = $user_id;
        
        $category_type=1;
        $Ingresos=[
        'name' => 'Ingresos',
        'account_id' => $account_id,
        'user_id'=>   $user_ID  ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'description'=>'Bajo esta categoría se encuentran todos los Ingresos de la compañía',
        'children' => [
        [
        'name' => 'Devoluciones de ventas',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Ingreso sin identificar',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Ingresos no operacionales',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'children' => [
        [
        'name' => 'Otros Ingresos',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'children' => [
        [
        'name' => 'Ingresos por interes',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'description'=>'Ingresos por intereses bancarios',
        'isEditable'=>0,
        ],
        ],
        ],
        ],
        ],
        [
        'name' => 'Ventas',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'description'=>'Bajo esta categoría se encuentran todos los Ingresos principales',
        'isEditable'=>0,
        ],
        ],
        
        
        ];
        
        $category_type=3;
        $Activos=[
        'name' => 'Activos',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID  ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'description'=>'Bajo esta categoría se encuentran todos los activos de la compañía',
        'children' => [
        [
        'name' => 'Activo corriente',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'children' => [
        [
        'name' => 'Bancos',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Cuentas por cobrar',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Inventario',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        ],
        ],
        [
        'name' => 'Activos fijos',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'description'=>'Bajo esta categoría se encuentran todos los activos principales de la compañía',
        ],
        [
        'name' => 'Avances y anticipos entregados',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Cuentas por cobrar - devoluciones',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Impuestos a favor',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'children' => [
        [
        'name' => 'ICO a favor',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'IVA a favor',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        ],
        ],
        [
        'name' => 'Inversiones',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Préstamos a terceros',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Retenciones a favor',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'children' => [
        [
        'name' => 'Retención de CREE a favor',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        ],
        [
        'name' => 'Retención de Industria y comercio a favor',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        ],
        [
        'name' => 'Retención de IVA a favor',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        ],
        [
        'name' => 'Retención en la fuente a favor',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        ],
        ],
        ],
        ],
        
        
        ];
        
        $category_type=2;
        $Egresos=[
        'name' => 'Egresos',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID  ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'description'=>'Bajo esta categoría se encuentran todos los egresos de la compañía',
        'children' => [
        [
        'name' => 'Alquiler de equipos y licencias',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Comisiones y honorarios',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Costo de la mercancía vendida',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'children' => [
        [
        'name' => 'Ajustes del inventario',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Compras inventariables',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Fletes y envíos',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Mano de obra',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Materias primas',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        ],
        ],
        [
        'name' => 'Costo servicios vendidos',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Cuentas incobrables',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Devoluciones en compras de ítem',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Egresos no operacionales',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'children' => [
        [
        'name' => 'Descuento financiero',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Diferencia en cambio',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'description'=>'Bajo esta categoría se encuentran las perdidas y ganancias por diferencias en tasas de cambio',
        ],
        ],
        ],
        [
        'name' => 'Gastos administrativos',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'children' => [
        [
        'name' => 'Arrendamiento',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        ],
        [
        'name' => 'Aseo y cafetería',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        ],
        [
        'name' => 'Internet y telecomunicaciones',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        ],
        [
        'name' => 'Papelería',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        ],
        [
        'name' => 'Servicios públicos',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        ],
        ],
        ],
        [
        'name' => 'Gastos bancarios',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'description'=>'Bajo esta categoría se encuentran todos los gastos bancarios de la compañía',
        ],
        [
        'name' => 'Legales',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Mantenimiento e instalaciones',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Nómina',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'children' => [
        [
        'name' => 'Dotación',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        ],
        [
        'name' => 'Prestaciones sociales',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        ],
        [
        'name' => 'Salarios',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        ],
        [
        'name' => 'Seguridad social y parafiscales',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        ],
        ],
        ],
        [
        'name' => 'Otros impuestos',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Publicidad',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Seguros y seguridad',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Servicios bancarios',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Subscripciones y afiliaciones',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Transporte y mensajería',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Varios',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Viajes y viáticos',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        ],
        
        
        ];
        
        $category_type=4;
        $Pasivos=[
        'name' => 'Pasivos',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID  ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'children' => [
        [
        'name' => 'Avances y anticipos recibidos',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Cuentas por pagar - devoluciones',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Cuentas por pagar - proveedores',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'description'=>'Bajo esta categoría se encuentran los pasivos principales',
        ],
        [
        'name' => 'Cuentas por pagar - tarjetas de crédito',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Impuestos por pagar',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'children' => [
        [
        'name' => 'ICO por pagar',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'IVA por pagar',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        ],
        ],
        [
        'name' => 'Obligaciones financieras y préstamos a terceros',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'description'=>'Bajo esta categoría se encuentran todos los Ingresos principales',
        'isEditable'=>0,
        ],
        [
        'name' => 'Retenciones por pagar',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'children' => [
        [
        'name' => 'Retención de CREE por pagar',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Retención de industria y Comercio por pagar',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Retención de IVA por pagar',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Retención en la fuente por pagar',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        ],
        ],
        ],
        
        
        ];
        
        $category_type=5;
        $Patrimonio=[
        'name' => 'Patrimonio',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID  ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'children' => [
        [
        'name' => 'Ajustes iniciales - Bancos',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Ajustes iniciales - Inventario',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Capital accionistas',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'isEditable'=>0,
        ],
        [
        'name' => 'Utilidades',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID,
        'type_id'=>$category_type,
        'description'=>'Bajo esta categoría se encuentra el patrimonio principal',
        'isEditable'=>0,
        ],
        ],
        ];
        
        $category_type=6;
        $TransferenciasBan=[
        'name' => 'Transferencias bancarias',
        'account_id'=>$account_id,
        'user_id'=>   $user_ID  ,
        'type_id'=>$category_type,
        'isEditable'=>0,
        'description'=>'Bajo esta categoría se encuentran todas las transferencias que se realizen entre bancos de la empresa',
        ];
        
        $node = Category::create($Ingresos);
        $node = Category::create($Egresos);
        $node = Category::create($Activos);
        $node = Category::create($Pasivos);
        $node = Category::create($Patrimonio);
        $node = Category::create($TransferenciasBan);
    }
}