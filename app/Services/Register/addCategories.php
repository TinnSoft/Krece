<?php
namespace App\Services\Register;

class CategoryController 
{
      //Set up default categories for the registered user
    public function defaultCategories()
    {
        $account_id= Auth::user()->account_id;
        $user_ID=Auth::user()->id;
       
        $category_type=1;
        $Ingresos=[
            'name' => 'Ingresos',
            'account_id'=>$account_id,
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