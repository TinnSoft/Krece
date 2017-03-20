@extends('home',['title' =>  'Factura Proveedores'])



@section('content')
 
    <div  class="row wrapper border-bottom white-bg page-heading">
            <div class="col-sm-4">
                <h2 >Factura de venta No: <span class="text-navy">{{$bill->resolution_id}}</span></h2>
                <ol class="breadcrumb">
                <li>
                    <a href="{{route('bill.index')}}">Inicio</a>
                </li>
                <li class="active">
                    <strong>Ver</strong>                            
                </li>
            </ol>
        </div>                
    </div>           

            <div id="bill_show" class="row wrapper wrapper-content">
            
                                       <div class="ibox-title">
                                       
                                            <p>
                                            @if($bill->status_id==1)                                                 
                                                
                                                <a href="{{route('payment-out.create')}}?{{$bill->contact->public_id}}" class="btn btn-info btn-sm "> 
                                                <span class="fa fa-money"></span>&nbsp;Agregar Pago</a>

                                                <a href="{{route('bill.edit', $bill->public_id)}}" class="btn btn-info btn-sm "> 
                                                <span class="glyphicon glyphicon-pencil"></span>&nbsp;Editar</a>                                                 

                                                <a href="{{route('bill.edit', $bill->public_id)}}?convert=clone" class="btn btn-warning btn-sm btn-outline"> 
                                                <span ></span>&nbsp;Anular</a> 
                                           @endif 
                                           @if($bill->status_id==2)
                                            <a href="{{route('bill.edit', $bill->public_id)}}?convert=clone" class="btn btn-warning btn-sm btn-outline"> 
                                                <span ></span>&nbsp;Volver a abrir</a>
                                           @endif 
                                                <a href="{{route('bill.create')}}" class="btn btn-primary btn-sm pull-right"> 
                                                <span class="glyphicon glyphicon-plus"></span>&nbsp;Nueva Factura de Proveedores</a> 

                                                <a class="btn btn-info btn-sm btn-outline"  @click="printPdf({{$bill->public_id}})"> 
                                                <span class="fa fa-print"></span>&nbsp;Imprimir</a> 
                                            </p>                                     
                                        </div>                            
                 </div>
          

  <div class="row">
         
                <div class="wrapper wrapper-content">
                    <div class="ibox-content p-xl">
                            <div class="row">
                                <div class="col-sm-6">
                                    <span><strong>Cliente: </strong>  <h4 class="text-navy">
                                      @if (count($bill->contact) > 0)
                                                 <a href="{{route('contact.show', $bill->contact->public_id)}}">{{$bill->contact->name}}</a>
                                        @endif</h4>
                                    </span><br/>
                                    
                                 
                                      <span><strong>Total: $</strong>  
                                        {{$bill->total}}
                                    </span><br/>
                                      <span><strong>Moneda: </strong>  
                                        {{$bill->currency_code}}
                                    </span><br/>
                                    <span><strong>Observaciones: </strong>  
                                      {{$bill->observations}}
                                    </span><br/>

                                </div>
                                    
                                <div class="col-sm-6 text-right">                                                                   
                                    <p>
                                        <span><strong>Fecha de creación:</strong>  {{$bill->date}} </span><br/>
                                        <span><strong>Fecha de vencimiento:</strong> {{$bill->due_date}}      </span>
                                       

                                        @if ($bill->status_id==1)                                    
                                           <p>Estado: <span class='label label-primary'>ABIERTA</span></p>                                         
                                        @elseif ($bill->status_id==2) 
                                            <p>Estado: <span class='label label-warning'>ANULADA</span></p>
                                         @elseif ($bill->status_id==6) 
                                            <p>Estado: <span class='label label-info'>CERRADA</span></p>
                                        @endif
                
                                    </p>
                                </div>
                            </div>

                            <div class="table-responsive m-t">
                                <table class="table invoice-table">
                                    <thead>
                                    <tr>
                                        <th>CATEGORIA</th>                                       
                                        <th>PRECIO</th>
                                        <th>CANTIDAD</th>
                                        <th>DESCUENTO</th>
                                        <th>IMPUESTO</th>           
                                        <th>TOTAL</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                     
                                        @foreach($bill->detail as $prod)
                                            <tr>
                                                <td class="table-product_id">
                                                    <div><strong>{{$prod->category->name}}</strong></div>
                                                    <small>{{$prod->description}}</small>
                                                </td>                                                
                                              
                                                <td class="table-price">$ {{$prod->unit_price  }}</td>
                                                <td class="table-qty">{{$prod->quantity}}</td>
                                                <td class="table-discount">{{$prod->discount}}%</td>
                                                <td class="table-taxes">{{$prod->tax_amount}}%</td>
                                                <td class="table-total text-right">$ {{$prod->total}}</td>
                                            </tr>
                                        @endforeach                                   

                                    </tbody>
                                </table>
                            </div>

                            
                            <table class="table invoice-total">
                                <tbody>
                                <tr>
                                    <td><strong>Sub Total :</strong></td>
                                    <td>$ {{$bill->sub_total}}</td>
                                </tr>
                                <tr>
                                    <td><strong>Descuentos :</strong></td>
                                    <td>$ {{$bill->total_discounts}}</td>
                                </tr>
                                 @foreach($taxes as $tax)
                                    <tr>
                                        <td><strong>{{$tax->name}}</strong></td>
                                        <td>${{$tax->total}}</td>
                                    </tr>
                                @endforeach
                                <tr>
                                    <td><strong>TOTAL COP:</strong></td>
                                    <td>$ {{$bill->total}}</td>                                    
                                </tr>                                
                                </tbody>
                            </table>
                                <ul class="nav nav-tabs">
                                        <li class="active"><a data-toggle="tab" href="#tab-1">PAGOS ASOCIADOS</a></li>
                                </ul>
                                <div class="tab-content">
                                    <div id="tab-1" class="tab-pane active">
                                        <div class="panel-body">
                                            <div class="table-responsive m-t">
                                                <table class="table bill-table">
                                                    <thead>
                                                        <tr>
                                                            <th>Fecha</th>                                       
                                                            <th>Comprobante de Egreso #</th>
                                                            <th>Estado</th> 
                                                            <th>Monto</th>
                                                            <th>Observaciones</th>     
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        @foreach($paymentHistorical as $item)
                                                            <tr>
                                                                <td> {{$item->date  }}</td>
                                                                <td > <a href="{{route('payment-out.show', $item->public_id)}}">
                                                                {{$item->resolution_id  }}</a></td>                                                               
                                                               
                                                                <td class="">
                                                                @if ($item->status_id==1)                                    
                                                                <p><span class='label label-primary'>{{$item->status}}</span></p>                                         
                                                                @elseif ($item->status_id==2) 
                                                                    <p><span class='label label-warning'>{{$item->status}}</span></p>                                                              
                                                                @else
                                                                    {{$item->status}}
                                                                @endif
                                                                </td>
                                                                <td class="text-info">${{$item->total_payed}}</td>
                                                                 <td>{{$item->observations}}</td>
                                                                
                                                            </tr>
                                                        @endforeach      
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>                                        
                                </div>
                        </div>        
                </div>
        </div>




<script>

 var appInvoiceShow = new Vue({
  el: '#bill_show',
  methods: {
       printPdf: function(val){
        window.open('/bill/'+val+'/pdf', '_blank');
    },
    goShow: function(val){
          alert();
   
      },
  }
})
</script>

@endsection
