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
                                 <div class="col-md-4">
                                        <h2>{{$products->name}}</h2>
                                        <small>{{$products->description}}</small>
                                        <ul class="list-group clear-list m-t">
                                            <li class="list-group-item fist-item">
                                                <span class="pull-right">
                                                    {{$products->public_id}}
                                                </span>
                                                Código
                                            </li>
                                            <li class="list-group-item">
                                                <span class="pull-right">
                                                    {{$products->reference}}
                                                </span>
                                                Referencia
                                            </li>
                                            <li class="list-group-item">
                                                <span class="pull-right">
                                                    {{$products->sale_price}}
                                                </span>
                                                Precio de venta
                                            </li>
                                            <li class="list-group-item">
                                                <span class="pull-right">
                                                    {{$products->inv_unit_cost}}
                                                </span>
                                                Precio de compra
                                            </li>
                                        
                                            <li class="list-group-item">
                                                <span class="pull-right">
                                                    @if (count($products->category) > 0)
                                                        {{$products->category->name}}
                                                    @endif
                                                </span>
                                                Categoría
                                            </li>
                                            <li class="list-group-item">
                                                <span class="pull-right">
                                                    @if (count($products->list_price) > 0)
                                                        {{$products->list_price->name}}                                                
                                                    @endif
                                                </span>
                                                Lista de precios
                                            </li>
                                            
                                        </ul>
                                </div>

                                <div class="col-lg-4">
                                    <div class="ibox float-e-margins">
                                        <div class="ibox-title">
                                        <div class="tooltip-demo">                                                
                                                <a  class="fa fa-exclamation-circle fa-2x text-info pull-left" 
                                                    data-toggle="tooltip" 
                                                    data-placement="left"
                                                    title="En esta opción usted podrá filtrar los datos de cada una de las transacciones asociadas al contacto actual.">
                                                </a>
                                            </div>
                                            <h5>Reportes</h5>                                            
                                            <div class="ibox-tools">
                                                <a class="collapse-link">
                                                    <i class="fa fa-chevron-up"></i>
                                                </a>
                                                
                                            </div>
                                        </div>
                                        <div class="ibox-content">
                                        <small>A continuación seleccione la opción que desea ver</small>
                                            <ul class="todo-list m-t small-list">
                                                <li>
                                                     <a id="invoice">Facturas de venta</a>
                                                </li>
                                                <li>
                                                   <a id="bill">Facturas de compra</a>
                                                </li>
                                                <li>
                                                    <a id="credit_note">Notas crédito</a>
                                                </li>
                                                <li>
                                                    <a id="debit_note">Notas débito</a>
                                                </li>
                                                <li>
                                                   <a id="estimate">Cotizaciones</a>
                                                </li>
                                                <li>
                                                   <a id="remision">Remisiones</a>
                                                </li>
                                                <li>
                                                    <a id="po">Ordenes de compra</a>
                                                </li>
                                            </ul>
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
