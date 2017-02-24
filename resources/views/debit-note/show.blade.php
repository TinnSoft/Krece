@extends('home',['title' =>  'Nota Débito'])



@section('content')
 {!!Html::script('/js/vue-library/vue.min.js')!!}
 
    <div  class="row wrapper border-bottom white-bg page-heading">
            <div class="col-sm-4">
                <h2 >Nota Débito No: <span class="text-navy">{{$debitnote->resolution_id}}</span></h2>
                <ol class="breadcrumb">
                <li>
                    <a href="{{route('debit-note.index')}}">Inicio</a>
                </li>
                <li class="active">
                    <strong>Nota débito</strong>                            
                </li>
            </ol>
        </div>                
    </div>           

            <div id="debitnote_show" class="row wrapper wrapper-content">            
                                       <div class="ibox-title">                                       
                                            <p>
                                                <a href="{{route('debit-note.edit', $debitnote->public_id)}}" class="btn btn-info btn-sm "> 
                                                <span class="glyphicon glyphicon-pencil"></span>&nbsp;Editar</a> 
                                                
                                                <a href="{{route('debit-note.create')}}" class="btn btn-primary btn-sm pull-right"> 
                                                <span class="glyphicon glyphicon-plus"></span>&nbsp;Nueva Nota débito</a> 

                                                <a class="btn btn-info btn-sm btn-outline"  @click="printPdf({{$debitnote->public_id}})"> 
                                                <span class="fa fa-print"></span>&nbsp;Imprimir</a> 
                                            </p>                                     
                                        </div>                            
                 </div>          

  <div class="row">
         
                <div class="wrapper wrapper-content">
                    <div class="ibox-content p-xl">
                            <div class="row">
                                <div class="col-sm-6">
                                    <span><strong>Cotizado a: </strong>  <h4 class="text-navy">
                                      @if (count($debitnote->contact) > 0)
                                                 <a href="{{route('contact.show', $debitnote->contact->public_id)}}">{{$debitnote->contact->name}}</a>
                                        @endif</h4>
                                    </span>

                                      <small><strong>Moneda: </strong>  
                                        {{$debitnote->currency_code}}
                                    </small><br/>
                                </div>
                                    
                                <div class="col-sm-6 text-right">                                                                   
                                    <p>
                                        <span><strong>Fecha de creación:</strong>  {{$debitnote->date}} </span><br/>                                        
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
                                     
                                        @foreach($debitnote->detail as $prod)
                                            <tr>
                                                <td class="table-product_id">
                                                    <div><strong>{{$prod->category->name}}</strong></div>
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
                                    <td>$ {{$debitnote->sub_total}}</td>
                                </tr>
                                <tr>
                                    <td><strong>Descuentos :</strong></td>
                                    <td>$ {{$debitnote->total_discounts}}</td>
                                </tr>
                                 @foreach($taxes as $tax)
                                    <tr>
                                        <td><strong>{{$tax->name}}</strong></td>
                                        <td>${{$tax->total}}</td>
                                    </tr>
                                @endforeach
                                <tr>
                                    <td><strong>TOTAL COP:</strong></td>
                                    <td>$ {{$debitnote->total}}</td>                                    
                                </tr>                                
                                </tbody>
                            </table>                           

                            <div class="well m-t"><strong>Observaciones: </strong>
                                {{$debitnote->observations}}
                            </div>
                        </div>                     
                </div>         
        </div>

<script>

 var appDebitNoteShow = new Vue({
  el: '#debitnote_show',
  methods: {
       printPdf: function(val){
        window.open('/debit-note/'+val+'/pdf', '_blank');
    },
    goShow: function(val){
          alert();
   
      },
  }
})
</script>

@endsection
