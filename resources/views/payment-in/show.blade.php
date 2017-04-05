@extends('home',['title' =>  'Pagos a facturas'])



@section('content')
 
    <div  class="row wrapper border-bottom white-bg page-heading">
            <div class="col-sm-7">
                @if($isCategory==0)
                    <h2 >Pago a Factura de venta: <span class="text-navy">
                    @foreach($detail as $prod)
                    {{$prod->resolution_id}},
                    @endforeach
                @else
                    <h2 >Egresos por concepto de categorías <span class="text-navy">
                @endif
                </span></h2>
                <ol class="breadcrumb">
                <li>
                    <a href="{{route('payment-in.index')}}">Inicio</a>
                </li>
                <li class="active">
                    <strong>Ver</strong>                            
                </li>
            </ol>
        </div>                
    </div>           

            <div id="payment_show" class="row wrapper wrapper-content">
                 @include('partials.SendEmailTo_modal')
                                       <div class="ibox-title">                                       
                                            <p>  
                                                
                                                <a href="{{route('payment-in.edit', $payment->public_id)}}" class="btn btn-info btn-sm "> 
                                                <span class="glyphicon glyphicon-pencil"></span>&nbsp;Editar</a> 

                                                <a class="btn btn-success btn-sm"  @click="printPdf({{$payment->public_id}})"> 
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
                                     <ul class="stat-list">
                                        <li>
                                            <h2  class="text-info" class="no-margins "><a class="fa fa-money text-info"></a>  ${{$total}}</h2>
                                            <small>Total Pagado</small>

                                        </li>    
                                        <li>
                                            <h2  class="text-navy" class="no-margins ">
                                                @if (count($payment->contact) > 0)
                                                 <span class="fa fa-user text-navy"></span><a class="text-navy" href="{{route('contact.show', $payment->contact->public_id)}}" >
                                                 {{$payment->contact->name}} </a>
                                                @endif</h4>
                                                 <small>Cliente</small>
                                            </h2>
                                        
                                        </li>                                       
                                    </ul><br>
                                    
                                     <span><strong>Cuenta: </strong>  
                                        @if (count($payment->bank_account) > 0)
                                             {{$payment->bank_account->bank_account_name}}
                                        @endif
                                     </span><br/>
                                     
                                      <span><strong>Método de pago: </strong>  
                                        {{$payment->payment_method->name}}
                                    </span><br/>
                                    <span><strong>Observaciones: </strong>  
                                      {{$payment->observations}}
                                    </span><br/>
                                    <span><strong>Notas: </strong>  
                                      {{$payment->notes}}
                                    </span><br/>

                                </div>
                                    
                                <div class="col-sm-6 text-right">                                                                   
                                    <p>
                                     <ul class="stat-list">
                                        <li>
                                            <h2 class="no-margins">Recibo de caja # <a class="text-navy">{{$payment->resolution_id}}</a>  </h2>
                                        </li>
                                    </ul><br>
                                        <span><strong>Fecha de creación:</strong>  {{$payment->date}} </span><br/>
                                        @if ($payment->status_id==1)                                    
                                           <p>Estado: <span class='label label-primary'>ABIERTA</span></p>                                        
                                        @else
                                            <p>Estado: <span class='label label-warning'>ANULADA</span></p>
                                        @endif
                
                                    </p>
                                </div>
                            </div>

                            <div class="table-responsive m-t">
                                <table class="table payment-table">
                                    <thead>
                                    <tr>
                                       @if($isCategory==0)
                                            <th>NÚMERO</th>                                       
                                            <th>FECHA</th>
                                            <th>VENCIMIENTO</th> 
                                            <th>TOTAL</th>
                                            <th>PAGADO</th>
                                            <th>POR PAGAR</th> 
                                        @else
                                            <th>CATEGORÍA</th>                                       
                                            <th>PRECIO UNITARIO</th>
                                            <th>IMPUESTO</th> 
                                            <th>CANTIDAD</th>
                                            <th>OBSERVACIONES</th>
                                            <th>TOTAL</th> 
                                        @endif 
                                    </tr>
                                    </thead>
                                    <tbody>
                                      @if($isCategory==0)
                                            @foreach($detail as $prod)
                                                <tr>
                                                    <td class=""> <a href="{{route('invoice.show', $prod->public_id)}}">
                                                    {{$prod->resolution_id  }}</a></td>
                                                    <td class=""> {{$prod->date  }}</td>
                                                    <td class="">{{$prod->due_date}}</td>
                                                    <td class="">${{$prod->total}}</td>
                                                    <td class="text-info">${{$prod->total_payed}}</td>
                                                    @if ($prod->total_pending_by_payment2==0)
                                                        <td >${{$prod->total_pending_by_payment}}</td>
                                                    @else
                                                        <td class=" text-danger">${{$prod->total_pending_by_payment}}</td>
                                                    @endif
                                                    
                                                </tr>
                                            @endforeach                                   
                                        @else
                                             @foreach($detail as $prod)
                                                <tr>
                                                    <td class=""> <a href="{{route('category.show', $prod->public_id)}}">
                                                    {{$prod->category->type->description.': '.$prod->category->name }}</a></td>
                                                    <td class="">${{$prod->unit_price  }}</td>
                                                    <td class="">{{$prod->tax_amount}}%</td>
                                                    <td class="">{{$prod->quantity}}</td>
                                                    <td class="">{{$prod->observations}}</td>
                                                    <td class="">${{$prod->total_with_taxes}}</td>
                                                    
                                                </tr>
                                            @endforeach          
                                        @endif 
                                    </tbody>
                                </table>
                            </div>
                        </div>        
                </div>
        </div>





<script>

 var appPaymentShow = new Vue({
  el: '#payment_show',
  data: function()  {
    return { 
     email: {
                header: 'Enviar transacción de pago',
                subject: '',
                body: '',
                to:'',
                public_id:'',
                model_from:'',
                additional_emails:[]
            }
  }},
   mounted: function(){
      this.email.model_from='payment';
      this.email.public_id={!!$payment->public_id!!};
  },
  methods: {
       printPdf: function(val){
        window.open('/payment-in/'+val+'/pdf', '_blank');
    },
     prepareEmailToCustomer: function(){ 
        this.fetchData({!!$payment->resolution_id!!});
      },
       fetchData: function (resolution_id) {
      var vm = this
     
      axios.get('/getTemplateEmailToCustomerPaymentIn/'+resolution_id)
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
  }
})
</script>

@endsection
