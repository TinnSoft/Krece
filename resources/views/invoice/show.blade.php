@extends('home')



@section('content')
 {!!Html::script('/js/vue-library/vue.min.js')!!}
 
    <div  class="row wrapper border-bottom white-bg page-heading">
            <div class="col-sm-4">
                <h2 >Invoice No: <span class="text-navy">{{$invoice->resolution_id}}</span></h2>
                <ol class="breadcrumb">
                <li>
                    <a href="{{route('invoice.index')}}">Inicio</a>
                </li>
                <li class="active">
                    <strong>Inicio</strong>                            
                </li>
            </ol>
        </div>                
    </div>           

            <div id="invoice_show" class="row wrapper wrapper-content">
            
                                       <div class="ibox-title">
                                       
                                            <p>
                                            @if($invoice->status_id==1)
                                                <a href="{{route('invoice.index')}}" class="btn btn-info btn-sm "> 
                                                <span class="glyphicon glyphicon-cog"></span>&nbsp;Convertir en factura</a> 
                                                
                                                
                                                <a href="{{route('invoice.edit', $invoice->public_id)}}" class="btn btn-info btn-sm "> 
                                                <span class="glyphicon glyphicon-pencil"></span>&nbsp;Editar</a> 

                                                <a href="{{route('invoice.edit', $invoice->public_id)}}?convert=clone" class="btn btn-info btn-sm "> 
                                                <span ></span>&nbsp;Clonar</a> 
                                           @endif 
                                                <a href="{{route('invoice.create')}}" class="btn btn-primary btn-sm pull-right"> 
                                                <span class="glyphicon glyphicon-plus"></span>&nbsp;Nueva Cotización</a> 

                                                <a class="btn btn-info btn-sm btn-outline"  @click="printPdf({{$invoice->public_id}})"> 
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
                                      @if (count($invoice->contact) > 0)
                                                 <a href="{{route('contact.show', $invoice->contact->public_id)}}">{{$invoice->contact->name}}</a>
                                        @endif</h4>
                                    </span><br/>
                                    
                                    <span><strong>Vendedor: </strong>  
                                        @if (count($invoice->seller) > 0)
                                                 {{$invoice->seller->name}}
                                        @endif</h4>                                 
                                    </span><br/>
                                    
                                     <span><strong>Lista de precios: </strong>  
                                        @if (count($invoice->list_price) > 0)
                                            {{$invoice->list_price->name}}
                                        @endif
                                     </span><br/>
                                     
                                      <span><strong>Total: $</strong>  
                                        {{$invoice->total}}
                                    </span><br/>
                                      <span><strong>Moneda: </strong>  
                                        {{$invoice->currency_code}}
                                    </span><br/>
                                    <span><strong>Observaciones: </strong>  
                                      {{$invoice->observations}}
                                    </span><br/>
                                    

                                </div>
                                    
                                <div class="col-sm-6 text-right">                                                                   
                                    <p>
                                        <span><strong>Fecha de creación:</strong>  {{$invoice->date}} </span><br/>
                                        <span><strong>Fecha de vencimiento:</strong> {{$invoice->due_date}}      </span>
                                        @if ($invoice->status_id==1)                                    
                                           <p>Estado: <span class='label label-primary'>ACTIVO</span></p>                                        
                                        @else
                                            <p>Estado: <span class='label label-warning'>ANULADO</span></p>
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
                                        <th>CANTIDAD</th>
                                        <th>DESC %</th>
                                        <th>IMPUESTO %</th>           
                                        <th>TOTAL</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                     
                                        @foreach($invoice->detail as $prod)
                                            <tr>
                                                <td class="table-product_id">
                                                    <div><strong>{{$prod->product->name}}</strong></div>
                                                    <small>{{$prod->description}}</small>
                                                </td>                                                
                                              
                                                <td class="table-price">$ {{$prod->unit_price  }}</td>
                                                <td class="table-qty">{{$prod->quantity}}</td>
                                                <td class="table-discount">{{$prod->discount}}</td>
                                                <td class="table-taxes">{{$prod->tax_amount}}</td>
                                                <td class="table-total text-right">$ {{$prod->total}}</td>
                                            </tr>
                                        @endforeach                                   

                                    </tbody>
                                </table>
                            </div><!-- /table-responsive -->

                            <table class="table invoice-total">
                                <tbody>
                                <tr>
                                    <td><strong>Sub Total :</strong></td>
                                    <td>$ {{$invoice->sub_total}}</td>
                                </tr>
                                <tr>
                                    <td><strong>Descuentos :</strong></td>
                                    <td>$ {{$invoice->total_discounts}}</td>
                                </tr>
                                 <tr>
                                    <td><strong>Impuestos :</strong></td>
                                    <td>$ {{$invoice->total_taxes}}</td>
                                </tr>
                                <tr>
                                    <td><strong>TOTAL COP:</strong></td>
                                    <td>$ {{$invoice->total}}</td>                                    
                                </tr>                                
                                </tbody>
                            </table>                           

                            <div class="well m-t"><strong>Notas: </strong>
                                {{$invoice->notes}}
                            </div>
                        </div>                     
                </div>         
        </div>

<script>

 var appInvoiceShow = new Vue({
  el: '#invoice_show',
  methods: {
       printPdf: function(val){
        window.open('/invoice/'+val+'/pdf', '_blank');
    },
    goShow: function(val){
          alert();
   
      },
  }
})
</script>

@endsection
