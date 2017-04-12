@extends('pdf.master',['id_file' =>  $creditnote->public_id])

@section('content')



<div class="ibox">
    <table  width= "100%">
           <tbody>
                <tr>
                    <td style="text-align: centered;width: 98px">
                      @if (count($creditnote->account->logo) > 0)
                         <img alt="image" src= {{$creditnote->account->logo}} style='width: 98px' height='80px' />                                                   
                      @endif
                  </td>
                  <td style="text-align: left;">
                    <address>
                        <strong>
                            @if (count($creditnote->account) > 0)
                                 {{$creditnote->account->name}}
                            @endif
                        </strong><br>
                             NIT 
                             @if (count($creditnote->account) > 0)
                                {{$creditnote->account->identification}}
                            @endif<br>
                            @if (count($creditnote->account) > 0)
                                   {{$creditnote->account->city}}
                            @endif<br>
                            <abbr>Tel:</abbr>  
                            @if (count($creditnote->account) > 0)
                                   {{$creditnote->account->phone}}
                            @endif
                        </address>
                  </td>
                  <td style="text-align: right;">
                       <h2>Nota Crédito No: <a class="text-navy"> {{$creditnote->resolution_id}}</a></h2>
                       <small>{{$creditnote->account->account_regime->value}}</small><br>
                       <address>
                            <small>Fecha de expedición: {{$creditnote->date}}</small><br>
                       </address>
                       
                  </td>
                  
                 </tr>                                       
            </tbody>
    </table
</div>

<div class="ibox-title">
        <address>
             <span class="text-muted text-xs block">SEÑOR(ES):<br>   
             <a class="text-navy">{{$creditnote->contact->name}}</a></span><br>
             <span>Dirección: 
                 @if (count($creditnote->contact) > 0)
                      {{$creditnote->contact->address}}
                  @endif
             </span><br>
             <span>
                Ciudad: 
                 @if (count($creditnote->contact) > 0)
                      {{$creditnote->contact->city}}
                @endif
             </span><br>
              <span>Teléfono:
                 @if (count($creditnote->contact) > 0)
                      {{$creditnote->contact->phone1}}
                @endif
             </span><br>
              <span>
                NIT:
                 @if (count($creditnote->contact) > 0)
                      {{$creditnote->contact->nit}}
                @endif
             </span><br>
        </address>
 </div>

                



<div class="table-responsive m-t">
                                <table class="detail" style="width: 100%;font-size:70%;">
                                    <thead>
                                    <tr style="background: #009933; border-color: #93D4D4;color:white;">
                                        <th >PRODUCTO</th>                                       
                                        <th style="text-align: center">PRECIO</th>
                                        <th style="text-align: center">CANTIDAD</th>
                                        <th style="text-align: center;width: 12%">DESCUENTO</th>          
                                        <th style="text-align: center">TOTAL</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                     
                                        @foreach($creditnote->detail as $prod)
                                            <tr>
                                                <td  style="width: 33%;">
                                                    <div><strong>{{$prod->product->name}}</strong></div>
                                                    <small>{{$prod->description}}</small>
                                                </td>    
                                                <td  style="width: 15%; text-align: center" class="table-price">${{$prod->unit_price  }}</td>
                                                <td style="width: 10%; text-align: center" class="table-qty">{{$prod->quantity}}</td>
                                                <td style="width: 12%; text-align: center">{{$prod->discount}}%</td>
                                                <td style="width: 15%; text-align: center" class="table-total text-right">${{$prod->total}}</td>
                                            </tr>
                                        @endforeach                                   

                                    </tbody>
                                </table>
                            </div>
                            <div class="ibox">
                                <div>
                                    
                                </div>
                                <table class="total"  >
                                    <tbody>
                                    <tr><td></td></tr>
                                    <tr><td></td></tr>
                                    <tr>
                                        <td><strong>Sub Total:</strong></td>
                                        <td>${{$creditnote->sub_total}}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Descuentos:</strong></td>
                                        <td>${{$creditnote->total_discounts}}</td>
                                    </tr>
                                    @foreach($taxes as $tax)
                                    <tr>
                                        <td><strong>{{$tax->name}}</strong></td>
                                        <td>${{$tax->total}}</td>
                                    </tr>
                                    @endforeach
                                    <tr style="background:#00802b;color:white">
                                        <td><strong >TOTAL:</strong></td>
                                        <td><strong >${{$creditnote->total}}</strong></td>                                    
                                    </tr>                                
                                    </tbody>
                                </table>                           
                            </div>
                            <div class="row">
                                <div class="panel-body"><br>
                                    @if (count($creditnote->account) > 0)
                                    <small><strong>Notas:</strong> {{$creditnote->notes}}</small>
                                    @endif                                
                                </div>
                             </div>
                        <div class="ibox"><br><br><br><br>
                                     @include('partials.pdf-elaborated_by') 
                            </div>  
                        
@endsection


