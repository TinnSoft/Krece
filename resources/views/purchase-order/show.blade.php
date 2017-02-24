@extends('home',['title' =>  'Orden de Compra'])



@section('content')
 {!!Html::script('/js/vue-library/vue.min.js')!!}
 
    <div  class="row wrapper border-bottom white-bg page-heading">
            <div class="col-sm-4">
                <h2 >Orden de Compra No: <span class="text-navy">{{$po->resolution_id}}</span></h2>
                <ol class="breadcrumb">
                <li>
                    <a href="{{route('purchase-order.index')}}">Inicio</a>
                </li>
                <li class="active">
                    <strong>Ver</strong>                            
                </li>
            </ol>
        </div>                
    </div>           

            <div id="po_show" class="row wrapper wrapper-content">
            
                                       <div class="ibox-title">
                                       
                                            <p>
                                            @if($po->status_id==1)
                                                <a href="{{route('purchase-order.index')}}" class="btn btn-info btn-sm "> 
                                                <span class="glyphicon glyphicon-cog"></span>&nbsp;Convertir en factura de compra</a> 
                                                
                                                
                                                <a href="{{route('purchase-order.edit', $po->public_id)}}" class="btn btn-info btn-sm "> 
                                                <span class="glyphicon glyphicon-pencil"></span>&nbsp;Editar</a> 

                                                <a href="{{route('purchase-order.edit', $po->public_id)}}?convert=clone" 
                                                class="btn btn-info btn-sm "> 
                                                <span class="fa fa-envelope"></span>&nbsp;Enviar por correo</a> 

                                                <a href="{{route('purchase-order.edit', $po->public_id)}}?convert=clone" class="btn btn-info btn-sm "> 
                                                <span ></span>&nbsp;Anular</a> 
                                           @endif 
                                                <a href="{{route('purchase-order.create')}}" class="btn btn-primary btn-sm pull-right"> 
                                                <span class="glyphicon glyphicon-plus"></span>&nbsp;Nueva Orden de Compra</a> 

                                                <a class="btn btn-info btn-sm btn-outline"  @click="printPdf({{$po->public_id}})"> 
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
                                      @if (count($po->contact) > 0)
                                                 <a href="{{route('contact.show', $po->contact->public_id)}}">{{$po->contact->name}}</a>
                                        @endif</h4>
                                    </span><br/>
                                     
                                      <span><strong>Total: $</strong>  
                                        {{$po->total}}
                                    </span><br/>
                                      <span><strong>Moneda: </strong>  
                                        {{$po->currency_code}}
                                    </span><br/>
                                    <span><strong>Observaciones: </strong>  
                                      {{$po->observations}}
                                    </span><br/>
                                    <span><strong>Notas: </strong>  
                                      {{$po->notes}}
                                    </span><br/>
                                    <span><strong>Términos y condiciones: </strong>  
                                      {{$po->terms}}
                                    </span><br/>

                                </div>
                                    
                                <div class="col-sm-6 text-right">                                                                   
                                    <p>
                                        <span><strong>Fecha de creación:</strong>  {{$po->date}} </span><br/>
                                        <span><strong>Fecha de vencimiento:</strong> {{$po->due_date}}      </span>
                                       

                                        @if ($po->status_id==1)                                    
                                           <p>Estado: <span class='label label-primary'>BORRADOR</span></p>                                         
                                        @elseif ($po->status_id==2) 
                                            <p>Estado: <span class='label label-warning'>ANULADA</span></p>
                                         @elseif ($po->status_id==3) 
                                            <p>Estado: <span class='label label-info'>FACTURADA</span></p>
                                        @endif
                
                                    </p>
                                </div>
                            </div>

                            <div class="table-responsive m-t">
                                <table class="table invoice-table">
                                    <thead>
                                    <tr>
                                        <th>PRODUCTO</th>                                       
                                        <th>PRECIO</th>
                                        <th>REFERENCIA</th> 
                                        <th>CANTIDAD</th>
                                        <th>DESCUENTO</th>
                                        <th>IMPUESTO</th>           
                                        <th>TOTAL</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                     
                                        @foreach($po->detail as $prod)
                                            <tr>
                                                <td class="table-product_id">
                                                    <div><strong>{{$prod->category->name}}</strong></div>
                                                    <small>{{$prod->description}}</small>
                                                </td>                                                
                                              
                                                <td class="table-price">$ {{$prod->unit_price  }}</td>
                                                <td class="table-REF"> {{$prod->reference  }}</td>
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
                                    <td>$ {{$po->sub_total}}</td>
                                </tr>
                                <tr>
                                    <td><strong>Descuentos :</strong></td>
                                    <td>$ {{$po->total_discounts}}</td>
                                </tr>
                                 @foreach($taxes as $tax)
                                    <tr>
                                        <td><strong>{{$tax->name}}</strong></td>
                                        <td>${{$tax->total}}</td>
                                    </tr>
                                @endforeach
                                <tr>
                                    <td><strong>TOTAL COP:</strong></td>
                                    <td>$ {{$po->total}}</td>                                    
                                </tr>                                
                                </tbody>
                            </table>
                                <ul class="nav nav-tabs">
                                        <li class="active"><a data-toggle="tab" href="#tab-1">FACTURAS DE COMPRA ASOCIADAS</a></li>
                                </ul>
                                <div class="tab-content">
                                    <div id="tab-1" class="tab-pane active">
                                        <div class="panel-body">
                                            <div class="table-responsive m-t">
                                                <table class="table po-table">
                                                    <thead>
                                                        <tr>
                                                            <th>Fecha</th>                                       
                                                            <th>Factura #</th>
                                                            <th>Monto</th>                                                            
                                                            <th>Observaciones</th>     
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        @foreach($_invoice_History as $item)
                                                            <tr>
                                                                <td> {{$item->date  }}</td>
                                                                <td > <a href="{{route('payment.show', $item->public_id)}}">
                                                                {{$item->resolution_id  }}</a></td>  
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
  el: '#po_show',
  methods: {
       printPdf: function(val){
        window.open('/purchase-order/'+val+'/pdf', '_blank');
    },
    goShow: function(val){
          alert();
   
      },
  }
})
</script>

@endsection
