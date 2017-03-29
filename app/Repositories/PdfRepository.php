<?php

namespace App\Repositories;

use App\Utilities\Helper;
use App\Contracts\IPdfRepository;
use PDF;
use App\Models\{
    Account,
    Estimate
};

class PdfRepository implements IPdfRepository
{
    
    //Genera el pdf base que se exporta por cada vista
    //$model=nombre del modelo
    //public_id= id del documento
    //view= nombre de la vista que muestra el pdf
    
    public function create($model, $public_id)
    {
        $withArray=[];
        //nombres de las variables del array que se van a exportar
        $array1_name=null;
        $array2_name=null;
        
        //Nombres de las tablas del header y del detalle
        $table_header_name=null;
        $table_detail_name=null;
        
        $view=null;
        
        switch (class_basename($model))
        {
            case 'Estimate';
                $withArray=['account','detail','list_price','seller'];
                $array1_name='estimate';
                $array2_name='taxes';
                $table_header_name='estimate';
                $table_detail_name='estimate_detail';
                $view='pdf.estimate';

                break;

             case 'CreditNote';
                $withArray=['account','detail','list_price'];
                $array1_name='creditnote';
                $array2_name='taxes';
                $table_header_name='credit_note';
                $table_detail_name='credit_note_detail';
                $view='pdf.credit-note';

                break;

            case 'Remision';
                $withArray=['account','detail','list_price','seller'];
                $array1_name='remision';
                $array2_name='taxes';
                $table_header_name='remision';
                $table_detail_name='remision_detail';
                $view='pdf.remision';

                break;

            default;
            
            break;
    
        };

        $data = $model::with( $withArray)
        ->GetByPublicId(0,$public_id)
        ->GetSelectedFields()
        ->first();

        $data=Helper::_InvoiceFormatter($data);
        $taxes=Helper::getTotalTaxes($data->public_id,$table_header_name,$table_detail_name);

        return PDF::loadView($view, [$array1_name => $data, $array2_name=>$taxes]);

    }
}