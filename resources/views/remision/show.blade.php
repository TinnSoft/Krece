@extends('home',['title' =>  'Remision'])



@section('content')
 {!!Html::script('/js/vue-library/vue.min.js')!!}
 
    <div  class="row wrapper border-bottom white-bg page-heading">
            <div class="col-sm-4">
                <h2 >Remision No: <span class="text-navy">{{$remision->resolution_id}}</span></h2>
                <ol class="breadcrumb">
                <li>
                    <a href="{{route('remision.index')}}">Inicio</a>
                </li>
                <li class="active">
                    <strong>Inicio</strong>                            
                </li>
            </ol>
        </div>                
    </div>           

            <div id="remision_show" class="row wrapper wrapper-content">
                @include('partials.SendEmailTo_modal') 
                                       <div class="ibox-title">
                                       
                                            <p>
                                            @if($remision->status_id==1)
                                                <a href="{{route('invoice.edit', $remision->public_id)}}?convert=toInvoiceR" class="btn btn-info btn-sm "> 
                                                <span class="fa fa-share-square-o"></span>&nbsp;Convertir en factura</a> 
                                                
                                                
                                                <a href="{{route('remision.edit', $remision->public_id)}}" class="btn btn-info btn-sm "> 
                                                <span class="fa fa-pencil"></span>&nbsp;Editar</a> 

                                                <a href="{{route('remision.edit', $remision->public_id)}}?convert=clone" class="btn btn-info btn-sm "> 
                                                <span class="fa fa-copy"></span>&nbsp;Clonar</a> 
                                                  <a @click="updateItemStatus({{$remision->id}},2)" class="btn btn-info btn-sm "> 
                                                <span ></span>&nbsp;Anular</a> 
                                            @else
                                                <a @click="updateItemStatus({{$remision->id}},1)" class="btn btn-info btn-sm "> 
                                                <span ></span>&nbsp;Habilitar</a>
                                           @endif 
                                                <a href="{{route('remision.create')}}" class="btn btn-primary btn-sm pull-right"> 
                                                <span class="glyphicon glyphicon-plus"></span>&nbsp;Nueva Remision</a> 

                                                <a class="btn btn-success btn-sm "  @click="printPdf({{$remision->public_id}})"> 
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
                                      @if (count($remision->contact) > 0)
                                                 <a href="{{route('contact.show', $remision->contact->public_id)}}">{{$remision->contact->name}}</a>
                                        @endif</h4>
                                    </span><br/>
                                    
                                    <span><strong>Vendedor: </strong>  
                                        @if (count($remision->seller) > 0)
                                                 {{$remision->seller->name}}
                                        @endif</h4>                                 
                                    </span><br/>
                                    
                                     <span><strong>Lista de precios: </strong>  
                                        @if (count($remision->list_price) > 0)
                                            {{$remision->list_price->name}}
                                        @endif
                                     </span><br/>
                                     
                                      <span><strong>Total: $</strong>  
                                        {{$remision->total}}
                                    </span><br/>
                                      <span><strong>Moneda: </strong>  
                                        {{$remision->currency_code}}
                                    </span><br/>
                                    <span><strong>Observaciones: </strong>  
                                      {{$remision->observations}}
                                    </span><br/>
                                    

                                </div>
                                    
                                <div class="col-sm-6 text-right">                                                                   
                                    <p>
                                        <span><strong>Fecha de creación:</strong>  {{$remision->date}} </span><br/>
                                        <span><strong>Fecha de vencimiento:</strong> {{$remision->due_date}}      </span>
                                        @if ($remision->status_id==1)                                    
                                           <p>Estado: <span class='label label-primary'>ABIERTA</span></p>                                        
                                        @elseif ($remision->status_id==2)   
                                            <p>Estado: <span class='label label-warning'>ANULADA</span></p>
                                        @elseif ($remision->status_id==6)   
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
                                        <th>CANTIDAD</th>
                                        <th>DESC %</th>
                                        <th>IMPUESTO %</th>           
                                        <th>TOTAL</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                     
                                        @foreach($remision->detail as $prod)
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
                                    <td>$ {{$remision->sub_total}}</td>
                                </tr>
                                <tr>
                                    <td><strong>Descuentos :</strong></td>
                                    <td>$ {{$remision->total_discounts}}</td>
                                </tr>
                                 @foreach($taxes as $tax)
                                    <tr>
                                        <td><strong>{{$tax->name}}</strong></td>
                                        <td>${{$tax->total}}</td>
                                    </tr>
                                @endforeach
                                <tr>
                                    <td><strong>TOTAL COP:</strong></td>
                                    <td>$ {{$remision->total}}</td>                                    
                                </tr>                                
                                </tbody>
                            </table>                           

                            <div class="well m-t"><strong>Notas: </strong>
                                {{$remision->notes}}
                            </div>
                        </div>                     
                </div>         
        </div>

<script>

 var appRemisionShow = new Vue({
  el: '#remision_show',
   data: function()  {
    return { 
    status:{status_id:null,},
     email: {
                header: 'Enviar Remisión',
                subject: '',
                body: '',
                to:'',
                public_id:'',
                model_from:'',
                additional_emails:[]
            },
        errors:{}
  }},
   mounted: function(){
      this.email.model_from='remision';
      this.email.public_id={!!$remision->public_id!!};
  },
  methods: {
       printPdf: function(val){
        window.open('/remision/'+val+'/pdf', '_blank');
    },
    prepareEmailToCustomer: function(){ 
        this.fetchData({!!$remision->resolution_id!!});
      },
    fetchData: function (resolution_id) {
      var vm = this
      axios.get('/getTemplateEmailToCustomerRemision/'+resolution_id)
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
                axios.put('/remision_update_state/' + item, vm.status)
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
