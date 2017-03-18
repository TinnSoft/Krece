@extends('home',['title' =>  'Inventario'])


@section('content')
    <div class="row wrapper border-bottom white-bg page-heading">
            <div class="col-sm-4">
                <h2>Producto: {{$products->name}}</h2>
                <ol class="breadcrumb">
                <li>
                    <a href="{{route('inventory.index')}}">Inicio</a>
                </li>
                <li class="active">
                    <strong>ver</strong>                            
                </li>
            </ol>
        </div>
                
    </div>           

          
    <div class="row wrapper wrapper-content">
            
                                       <div class="ibox-title">
                                       
                                            <p>
                                                <a href="{{route('invoice.create')}}?item/{{$products->public_id}}" class="btn btn-info btn-sm ">
                                                <span class="fa fa-edit"></span>&nbsp;Facturar este item</a> 
                                                <!--
                                                <a href="{{route('inventory.index')}}" class="btn btn-info btn-sm "> 
                                                <span class="fa fa-share-square-o"></span>&nbsp;Comprar este ítem</a> 
                                                -->
                                                <a href="{{route('inventory.edit', $products->public_id)}}" class="btn btn-info btn-sm "> 
                                                <span class="glyphicon glyphicon-pencil"></span>&nbsp;Editar</a> 
                                                
                                                <a href="{{route('inventory.create')}}" class="btn btn-primary btn-sm pull-right"> 
                                                <span class="glyphicon glyphicon-plus"></span>&nbsp;Nuevo producto</a> 
                                            </p>
                                            
                                        </div>
                            
                
          
            <div class="row">         
                <div class="wrapper wrapper-content">
                    <div class="ibox-content p-xxl">
                            <div class="row">
                                
                                <div class="col-sm-5">
                                    <table class="table" style="width: 100%;font-size:90%;height: 0px">                                        
                                         <tr>
                                            <td  class="bg-muted p-xxs b-r-sm" >Código</td>
                                            <td>{{$products->public_id}}</td>                                             
                                        </tr>
                                         <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Referencia</td>
                                            <td>{{$products->reference}}</td>                                             
                                        </tr>
                                          <tr>
                                            <td class="bg-muted p-xxs b-r-sm">Nombre</td>
                                            <td >  
                                               {{$products->name}}
                                            </td>                                             
                                        </tr>
                                         <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Precio de venta</td>
                                            <td>  
                                               {{$products->sale_price}}
                                            </td>                                             
                                        </tr>
                                        <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Precio de compra</td>
                                            <td>  
                                               {{$products->inv_unit_cost}}
                                            </td>                                             
                                        </tr>
                                         <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Impuesto</td>
                                            <td>  
                                                @if (count($products->tax) > 0)
                                                    {{$products->tax->name}}
                                                @endif
                                               
                                            </td>                                             
                                        </tr>
                                         <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Descripción</td>
                                            <td>  
                                               {{$products->description}}
                                            </td>                                             
                                        </tr>
                                         <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Categoría</td>
                                            <td>  
                                                @if (count($products->category) > 0)
                                                    {{$products->category->name}}
                                                @endif
                                            </td>                                             
                                        </tr>
                                         <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Cantidad inicial</td>
                                            <td>                                                 
                                                {{$products->inv_quantity_initial}}
                                           
                                            </td>                                             
                                        </tr>
                                          <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Cantidad en Inventario</td>
                                            <td>  
                                                @if($products->inv_quantity_actual!=="")
                                                    {{$products->inv_quantity_initial}}
                                                @else
                                                    {{$products->inv_quantity_actual}}
                                                @endif
                                            </td>                                             
                                        </tr>
                                         <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Lista de precios</td>
                                            <td>  
                                                @if (count($products->list_price) > 0)
                                                    {{$products->list_price->name}}                                                
                                                @endif
                                                
                                            </td>                                             
                                        </tr>
                                         <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Archivos adjuntos</td>
                                            <td>  
                                             
                                            </td>                                             
                                        </tr>


                                    </table>
                                </div>
                                <div class="col-lg-5">
                                    <div class="ibox float-e-margins">
                                        <div class="ibox-title">
                                            <div class="tooltip-demo">                                                
                                                <a  class="fa fa-exclamation-circle fa-2x text-info pull-left" 
                                                    data-toggle="tooltip" 
                                                    data-placement="left"
                                                    title="En esta opción usted podrá filtrar los datos de cada una de las transacciones asociadas al contacto actual.">
                                                </a>
                                            </div>
                                            <h5><strong><label class="pull-center">REPORTES</label></strong></h5>
                                            
                                            <div class="ibox-tools">
                                                <a class="collapse-link">
                                                    <i class="fa fa-chevron-up"></i>
                                                </a>   
                                            </div>
                                        </div>
                                        <div class="ibox-content">
                                            <a id="invoice">Facturas de venta</a><br>
                                            <a id="bill">Facturas de compra</a><br>
                                            <a id="credit_note">Notas crédito</a><br>
                                            <a id="debit_note">Notas débito</a><br>
                                            <a id="estimate">Cotizaciones</a><br>
                                            <a id="remision">Remisiones</a><br>
                                            <a id="po">Ordenes de compra</a>
                                        </div>
                                    </div>
                                </div>
                                 
                            </div>
                            <div class="row">
                                @include('inventory.transactions-grid')
                            </div>
                        </div>        
                </div>
         
            </div>          
 </div>
  

@endsection
