@extends('home',['title' =>  'Pagos de facturas'])



@section('content')
 {!!Html::script('/js/vue-library/vue.min.js')!!}
 
    <div  class="row wrapper border-bottom white-bg page-heading">
            <div class="col-sm-7">
                <h2 >Pagos a Facturas de venta: <span class="text-navy">
                @foreach($detail as $prod)
                 {{$prod->resolution_id}},
                @endforeach
                </span></h2>
                <ol class="breadcrumb">
                <li>
                    <a href="{{route('payment.index')}}">Inicio</a>
                </li>
                <li class="active">
                    <strong>Ver</strong>                            
                </li>
            </ol>
        </div>                
    </div>           

            <div id="payment_show" class="row wrapper wrapper-content">
            
                                       <div class="ibox-title">                                       
                                            <p>                                          
                                                <a href="{{route('payment.index')}}" class="btn btn-info btn-sm "> 
                                                <span class="glyphicon glyphicon-cog"></span>&nbsp;Enviar por correo</a> 
                                                
                                                
                                                <a href="{{route('payment.edit', $payment->public_id)}}" class="btn btn-info btn-sm "> 
                                                <span class="glyphicon glyphicon-pencil"></span>&nbsp;Editar</a> 

                                                <a href="{{route('payment.edit', $payment->public_id)}}?convert=clone" class="btn btn-info btn-sm "> 
                                                <span ></span>&nbsp;Eliminar</a> 

                                                <a href="{{route('payment.edit', $payment->public_id)}}?convert=clone" class="btn btn-info btn-sm "> 
                                                <span ></span>&nbsp;Anular</a> 

                                                <a class="btn btn-info btn-sm btn-outline"  @click="printPdf({{$payment->public_id}})"> 
                                                <span class="fa fa-print"></span>&nbsp;Imprimir</a> 
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
                                                 <a href="{{route('contact.show', $payment->contact->public_id)}}" class="fa fa-user text-navy">
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
                                        <th>NÚMERO</th>                                       
                                        <th>FECHA</th>
                                        <th>VENCIMIENTO</th> 
                                        <th>TOTAL</th>
                                        <th>PAGADO</th>
                                        <th>POR PAGAR</th>  
                                    </tr>
                                    </thead>
                                    <tbody>
                                     
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

                                    </tbody>
                                </table>
                            </div>
                        </div>        
                </div>
        </div>





<script>

 var apppaymentShow = new Vue({
  el: '#payment_show',
  methods: {
       printPdf: function(val){
        window.open('/payment/'+val+'/pdf', '_blank');
    },
    goShow: function(val){
          alert();
   
      },
  }
})
</script>

@endsection