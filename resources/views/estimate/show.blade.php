@extends('home',['title' =>  'Cotización'])



@section('content')


    <div  class="row wrapper border-bottom white-bg page-heading">
            <div class="col-sm-6">
                <h2 >Cotización No: <span class="text-navy">{{$estimate->resolution_id}}</span></h2>
                <ol class="breadcrumb">
                <li>
                    <a href="{{route('estimate.index')}}">Inicio</a>
                </li>
                <li class="active">
                    <strong>Cotizaciones</strong>                            
                </li>
            </ol>
        </div>                
    </div>           

            <div id="estimate_show" class="row wrapper wrapper-content">

                 @include('partials.SendEmailTo_modal',['header'=>'Enviar cotización'])

                                       <div class="ibox-title">
                                       
                                            <p>
                                                <a href="{{route('invoice.edit', $estimate->public_id)}}?convert=toInvoice" 
                                                class="btn btn-info btn-sm "> 
                                                <span class="fa fa-share-square-o"></span>&nbsp;Convertir en factura</a> 
                                                
                                                <a href="{{route('estimate.edit', $estimate->public_id)}}" class="btn btn-info btn-sm "> 
                                                <span class="fa fa-pencil"></span>&nbsp;Editar</a> 

                                                <a href="{{route('estimate.edit', $estimate->public_id)}}?convert=clone" 
                                                class="btn btn-info btn-sm "> 
                                                <span class="fa fa-copy"></span>&nbsp;Clonar</a> 
                                                
                                                <a href="{{route('estimate.create')}}" class="btn btn-primary btn-sm pull-right"> 
                                                <span class="fa fa-plus"></span>&nbsp;Nueva Cotización</a> 

                                                <a class="btn btn-success btn-sm "  @click="printPdf({{$estimate->public_id}})"> 
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
                                      @if (count($estimate->contact) > 0)
                                                 <a href="{{route('contact.show', $estimate->contact->public_id)}}">{{$estimate->contact->name}}</a>
                                        @endif</h4>
                                    </span><br/>

                                    <span><strong>Observaciones: </strong>  
                                      {{$estimate->observations}}
                                    </span><br/>
                                    
                                    <span><strong>Vendedor: </strong>  
                                        @if (count($estimate->seller) > 0)
                                                 {{$estimate->seller->name}}
                                        @endif</h4>                                 
                                    </span><br/>
                                    
                                     <span><strong>Lista de precios: </strong>  
                                        @if (count($estimate->list_price) > 0)
                                            {{$estimate->list_price->name}}
                                        @endif
                                     </span><br/>
                                
                                      <span><strong>Moneda: </strong>  
                                        {{$estimate->currency_code}}
                                    </span><br/>

                                </div>
                                    
                                <div class="col-sm-6 text-right">                                                                   
                                    <p>
                                        <span><strong>Fecha de creación:</strong>  {{$estimate->date}} </span><br/>
                                        <span><strong>Fecha de vencimiento:</strong> {{$estimate->due_date}}      </span>
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
                                     
                                        @foreach($estimate->detail as $prod)
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
                                    <td>$ {{$estimate->sub_total}}</td>
                                </tr>
                                <tr>
                                    <td><strong>Descuentos :</strong></td>
                                    <td>$ {{$estimate->total_discounts}}</td>
                                </tr>
                                 @foreach($taxes as $tax)
                                    <tr>
                                        <td><strong>{{$tax->name}}</strong></td>
                                        <td>${{$tax->total}}</td>
                                    </tr>
                                @endforeach
                                <tr>
                                    <td><strong>TOTAL COP:</strong></td>
                                    <td>$ {{$estimate->total}}</td>                                    
                                </tr>                                
                                </tbody>
                            </table>                           

                            <div class="well m-t"><strong>Notas: </strong>
                                {{$estimate->notes}}
                            </div>
                        </div>                     
                </div>         
        </div>

<script>

 var appEstimateShow = new Vue({
  el: '#estimate_show',
  data(){
      return {         
        email: {
                header: 'Enviar Cotización',
                subject: '',
                body: 'original',
                to:'',
                additional_emails:[]
            }
      }
  },
  methods: {     
    printPdf: function(val){
        window.open('/estimate/'+val+'/pdf', '_blank');
    },
    prepareEmailToCustomer: function(){ 
        this.fetchData({!!$estimate->resolution_id!!});
      },
    fetchData: function (resolution_id) {
      var vm = this
      axios.get('/getTemplateEmailToCustomer/'+resolution_id)
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
