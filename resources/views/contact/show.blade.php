@extends('home',['title' =>  'Contactos'])

<!--<link href="/css/style_tables.css" rel="stylesheet">
-->

@section('content')
    <div class="row wrapper border-bottom white-bg page-heading">
            <div class="col-sm-4">
                <h2>Contacto: {{$contact->name}}</h2>
                <ol class="breadcrumb">
                <li>
                    <a href="{{route('contact.index')}}">Inicio</a>
                </li>
                <li class="active">
                    <strong>Cotizaciones</strong>                            
                </li>
            </ol>
        </div>
                
    </div>           

          
            <div class="row wrapper wrapper-content">
            
                                       <div class="ibox-title">
                                       
                                            <p>
                                                <a href="{{route('contact.index')}}" class="btn btn-info btn-sm "> 
                                                <span class="glyphicon glyphicon-plus"></span>&nbsp;Crear factura de venta</a> 
                                                
                                                <a href="{{route('contact.index')}}" class="btn btn-info btn-sm "> 
                                                <span class="glyphicon glyphicon-plus"></span>&nbsp;Crear factura de compra</a> 

                                                <a href="{{route('contact.edit', $contact->public_id)}}" class="btn btn-info btn-sm "> 
                                                <span class="glyphicon glyphicon-pencil"></span>&nbsp;Editar</a> 
                                                
                                                <a href="{{route('contact.create')}}" class="btn btn-primary btn-sm pull-right"> 
                                                <span class="glyphicon glyphicon-user"></span>&nbsp;Nuevo contacto</a> 
                                            </p>
                                        </div>
                            
                 
          
            <div class="row">         
                <div class="wrapper wrapper-content">
                    <div class="ibox-content p-xxl">
                            <div class="row">
                                
                                <div class="col-xs-5">
                                    <table class="table">
                                        <thead>
                                            <tr  class="bg-primary p-xxs b-r-sm ">
                                                <th ><strong>Datos generales: </strong></th>
                                                <th></th> 
                                            </tr>
                                        </thead>
                                         <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Nombre</td>
                                            <td>{{$contact->name}}</td>                                             
                                        </tr>
                                         <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Nit</td>
                                            <td>{{$contact->nit}}</td>                                             
                                        </tr>
                                          <tr>
                                            <td class="bg-muted p-xxs b-r-sm">Teléfono</td>
                                            <td >  
                                               {{$contact->phone1}}
                                            </td>                                             
                                        </tr>
                                         <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Teléfono 2</td>
                                            <td>  
                                               {{$contact->phone2}}
                                            </td>                                             
                                        </tr>
                                         <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Celular</td>
                                            <td>  
                                               {{$contact->phone_mobile}}
                                            </td>                                             
                                        </tr>
                                         <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Ciudad</td>
                                            <td>  
                                               {{$contact->city}}
                                            </td>                                             
                                        </tr>
                                         <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Correo electrónico</td>
                                            <td>  
                                               {{$contact->email}}
                                            </td>                                             
                                        </tr>
                                         <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Lista de precio</td>
                                            <td>  
                                                @if (count($contact->list_price) > 0)
                                                    {{$contact->list_price->name}}
                                                @endif
                                            </td>                                             
                                        </tr>
                                          <tr>
                                            <td  class="bg-muted p-xxs b-r-sm">Observaciones</td>
                                            <td>  
                                               {{$contact->observation}}
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
                                            <a id="">Transacciones</a><br>
                                            <a id="invoice">Facturas de venta</a><br>
                                            <a id="">Facturas de compra</a><br>
                                            <a id="">Notas crédito</a><br>
                                            <a id="">Notas débito</a><br>
                                            <a id="estimate">Cotizaciones</a><br>
                                            <a id="remision">Remisiones</a><br>
                                            <a id="">Ordenes de compra</a>
                                        </div>
                                    </div>
                                </div>


                            </div>

                           <div class="row">
                                @include('contact.transactions-grid')
                            </div>

                            
                        </div>
                </div>
         
        </div>
        </div>
    


@endsection
