@extends('home',['title' =>  'Factura de venta'])



@section('content')
 {!!Html::script('/js/components/vue-spinner/vue-spinner.min.js')!!}
 
    <div  class="row wrapper border-bottom white-bg page-heading">
            <div class="col-sm-4">
                <h2 >Factura de venta No: <span class="text-navy">{{$invoice->resolution_id}}</span></h2>
                <ol class="breadcrumb">
                <li>
                    <a href="{{route('invoice.index')}}">Inicio</a>
                </li>
                <li class="active">
                    <strong>Ver</strong>                            
                </li>
            </ol>
        </div>                
    </div>           

            <div id="invoice_show" class="row wrapper wrapper-content">
                @include('partials.SendEmailTo_modal')
                                       <div class="ibox-title">
                                            <p>
                                            @if($invoice->status_id==1)
                                                <a href="{{route('payment-in.create')}}?{{$invoice->contact->public_id}}" class="btn btn-info btn-sm "> 
                                                <span class="fa fa-money "></span>&nbsp;Agregar pago</a> 
                                                
                                                <a href="{{route('invoice.edit', $invoice->public_id)}}" class="btn btn-info btn-sm "> 
                                                <span class="glyphicon glyphicon-pencil"></span>&nbsp;Editar</a> 

                                                <a href="{{route('invoice.edit', $invoice->public_id)}}?convert=clone" class="btn btn-info btn-sm "> 
                                                <span class="fa fa-copy"></span>&nbsp;Clonar</a> 

                                                <a @click="updateItemStatus({{$invoice->id}},2)" class="btn btn-info btn-sm "> 
                                                <span ></span>&nbsp;Anular</a> 
                                           @else
                                                <a @click="updateItemStatus({{$invoice->id}},1)" class="btn btn-info btn-sm "> 
                                                <span ></span>&nbsp;Habilitar</a>
                                           @endif
                                                <a href="{{route('invoice.create')}}" class="btn btn-primary btn-sm pull-right"> 
                                                <span class="glyphicon glyphicon-plus"></span>&nbsp;Nueva Factura de venta</a> 

                                               
                                                <a class="btn btn-success btn-sm "  @click="printPdf({{$invoice->public_id}})"> 
                                                <span class="fa fa-print"></span>&nbsp;Imprimir</a> 

                                                <a class="btn btn-success btn-sm"  @click="prepareEmailToCustomer()"> 
                                                <span class="fa fa-envelope"></span>&nbsp;Enviar por correo</a> 

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
                                    <span><strong>Notas: </strong>  
                                      {{$invoice->notes}}
                                    </span><br/>

                                </div>
                                    
                                <div class="col-sm-6 text-right">                                                                   
                                    <p>
                                        <span><strong>Fecha de creación:</strong>  {{$invoice->date}} </span><br/>
                                        <span><strong>Fecha de vencimiento:</strong> {{$invoice->due_date}}      </span>
                                       

                                        @if ($invoice->status_id==1)                                    
                                           <p>Estado: <span class='label label-primary'>ABIERTA</span></p>                                         
                                        @elseif ($invoice->status_id==2) 
                                            <p>Estado: <span class='label label-warning'>ANULADA</span></p>
                                         @elseif ($invoice->status_id==6) 
                                            <p>Estado: <span class='label label-info'>CERRADA</span></p>
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
                                     
                                        @foreach($invoice->detail as $prod)
                                            <tr>
                                                <td class="table-product_id">
                                                    <div><strong>{{$prod->product->name}}</strong></div>
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
                                    <td>$ {{$invoice->sub_total}}</td>
                                </tr>
                                <tr>
                                    <td><strong>Descuentos :</strong></td>
                                    <td>$ {{$invoice->total_discounts}}</td>
                                </tr>
                                 @foreach($taxes as $tax)
                                    <tr>
                                        <td><strong>{{$tax->name}}</strong></td>
                                        <td>${{$tax->total}}</td>
                                    </tr>
                                @endforeach
                                <tr>
                                    <td><strong>TOTAL COP:</strong></td>
                                    <td>$ {{$invoice->total}}</td>                                    
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
                                                <table class="table invoice-table">
                                                    <thead>
                                                        <tr>
                                                            <th>Fecha</th>                                       
                                                            <th>Recibo de Caja #</th>
                                                            <th>Estado</th> 
                                                            <th>Método de pago</th>
                                                            <th>Monto</th>
                                                            <th>Observaciones</th>     
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        @foreach($paymentHistorical as $item)
                                                            <tr>
                                                                <td> {{$item->date  }}</td>
                                                                <td > <a href="{{route('payment-in.show', $item->public_id)}}">
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

                                                                <td class="">{{$item->payment_method}}</td>
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

//<pulse-loader :loading="loading" ></pulse-loader>
//var PulseLoader = VueSpinner.PulseLoader

 var appInvoiceShow = new Vue({
  el: '#invoice_show',
   data: function()  {
    return { 
    status:{status_id:null,},
     email: {
                header: 'Enviar Factura de venta',
                subject: '',
                body: '',
                to:'',
                public_id:'',
                model_from:'',
                additional_emails:[]
            }
  }},
  mounted: function(){
      this.email.model_from='invoice';
      this.email.public_id={!!$invoice->public_id!!};
  },
  methods: {
       printPdf: function(val){
        window.open('/invoice/'+val+'/pdf', '_blank');
    },
    prepareEmailToCustomer: function(){ 
        this.fetchData({!!$invoice->resolution_id!!});
      },
       fetchData: function (resolution_id) {
      var vm = this
      axios.get('/getTemplateEmailToCustomerInvoice/'+resolution_id)
        .then(function (response) {
            
            Vue.set(vm.$data.email, 'subject', response.data.subject);
            Vue.set(vm.$data.email, 'body', response.data.body);
            Vue.set(vm.$data.email, 'to', response.data.to);
            Vue.set(vm.$data.email, 'additional_emails', response.data.additional_emails);
   
            $('#summernote').summernote();
            $('#summernote').summernote('code', response.data.body);
        
            $('#SendEmailModal').modal('toggle'); 
          
        })
        .catch(function (error) {
          Vue.set(vm.$data, 'errors', error);
        })
    },
    updateItemStatus: function(item,status)
    {          
        if (item)
        {
            if (status)
            {
                var vm = this; 
                Vue.set(vm.$data.status, 'status_id', status);                 
                axios.put('/invoice_update_state/' + item, vm.status)
                .then(function(response) {
                    if(response.data.updated) {   
                         location.reload();
                    }
                })
                .catch(function(error) {  
                    Vue.set(vm.$data, 'errors', error.response.data);
                })
            }
        }
    },
  }
})
</script>

@endsection
