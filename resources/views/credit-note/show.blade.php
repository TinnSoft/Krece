@extends('home',['title' =>  'Nota Crédito'])



@section('content')
 {!!Html::script('/js/vue-library/vue.min.js')!!}
 
    <div  class="row wrapper border-bottom white-bg page-heading">
            <div class="col-sm-4">
                <h2 >Nota Crédito No: <span class="text-navy">{{$creditnote->resolution_id}}</span></h2>
                <ol class="breadcrumb">
                <li>
                    <a href="{{route('credit-note.index')}}">Inicio</a>
                </li>
                <li class="active">
                    <strong>Cotizaciones</strong>                            
                </li>
            </ol>
        </div>                
    </div>           

            <div id="creditnote_show" class="row wrapper wrapper-content">  
                            @include('partials.SendEmailTo_modal')          
                                       <div class="ibox-title">                                       
                                            <p>
                                                                                                
                                                <a href="{{route('credit-note.edit', $creditnote->public_id)}}" class="btn btn-info btn-sm "> 
                                                <span class="glyphicon glyphicon-pencil"></span>&nbsp;Editar</a> 

                                                <a href="{{route('credit-note.create')}}" class="btn btn-primary btn-sm pull-right"> 
                                                <span class="glyphicon glyphicon-plus"></span>&nbsp;Nueva Nota crédito</a> 

                                                <a class="btn btn-success btn-sm "  @click="printPdf({{$creditnote->public_id}})"> 
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
                                    <span><strong>Cotizado a: </strong>  <h4 class="text-navy">
                                      @if (count($creditnote->contact) > 0)
                                                 <a href="{{route('contact.show', $creditnote->contact->public_id)}}">{{$creditnote->contact->name}}</a>
                                        @endif</h4>
                                    </span><br/>

                                    <span><strong>Observaciones: </strong>  
                                      {{$creditnote->observations}}
                                    </span><br/>
                                    
                                    
                                     <span><strong>Lista de precios: </strong>  
                                        @if (count($creditnote->list_price) > 0)
                                            {{$creditnote->list_price->name}}
                                        @endif
                                     </span><br/>
                                
                                      <span><strong>Moneda: </strong>  
                                        {{$creditnote->currency_code}}
                                    </span><br/>
                                </div>
                                    
                                <div class="col-sm-6 text-right">                                                                   
                                    <p>
                                        <span><strong>Fecha de creación:</strong>  {{$creditnote->date}} </span><br/>                                        
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
                                        <th>DESC %</th>
                                        <th>IMPUESTO %</th>           
                                        <th>TOTAL</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                     
                                        @foreach($creditnote->detail as $prod)
                                            <tr>
                                                <td class="table-product_id">
                                                    <div><strong>{{$prod->product->name}}</strong></div>
                                                    <small>{{$prod->description}}</small>
                                                </td>                                                
                                              
                                                <td class="table-price">$ {{$prod->unit_price  }}</td>
                                                <td class="table-ref"> {{$prod->reference  }}</td>
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
                                    <td>$ {{$creditnote->sub_total}}</td>
                                </tr>
                                <tr>
                                    <td><strong>Descuentos :</strong></td>
                                    <td>$ {{$creditnote->total_discounts}}</td>
                                </tr>
                                 @foreach($taxes as $tax)
                                    <tr>
                                        <td><strong>{{$tax->name}}</strong></td>
                                        <td>${{$tax->total}}</td>
                                    </tr>
                                @endforeach
                                <tr>
                                    <td><strong>TOTAL COP:</strong></td>
                                    <td>$ {{$creditnote->total}}</td>                                    
                                </tr>                                
                                </tbody>
                            </table>                           

                            <div class="well m-t"><strong>Notas: </strong>
                                {{$creditnote->notes}}
                            </div>
                        </div>                     
                </div>         
        </div>

<script>

 var appEstimateShow = new Vue({
  el: '#creditnote_show',
  data(){
      return {         
        email: {
                header: 'Enviar Nota Crédito',
                subject: '',
                body: '',
                to:'',
                public_id:'',
                model_from:'',
                additional_emails:[]
            },
            errors:{}
      }
  },
   mounted: function(){
      this.email.model_from='credit_note';
      this.email.public_id={!!$creditnote->public_id!!};
  },
  methods: {
       printPdf: function(val){
        window.open('/credit-note/'+val+'/pdf', '_blank');
    },
    prepareEmailToCustomer: function(){ 
        this.fetchData({!!$creditnote->resolution_id!!});
      },
    fetchData: function (resolution_id) {
      var vm = this
      axios.get('/getTemplateEmailToCustomerCreditNote/'+resolution_id)
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
