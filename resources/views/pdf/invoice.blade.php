@extends('pdf.master',['id_file' =>  $invoice->public_id])

@section('content')

@if($invoice->status_id==2)
    @include('partials.pdf-watermark_null')
@endif
<div id="content">
<div class="ibox">
    <table  width= "100%">
           <tbody>
                <tr>
                    <td style="text-align: centered;width: 98px">
                      @if (count($invoice->account->logo) > 0)
                         <img alt="image" src= {{$invoice->account->logo}} style='width: 98px' height='80px' />                                                   
                      @endif
                  </td>
                  <td style="text-align: left;">
                    <address>
                        <strong>
                            @if (count($invoice->account) > 0)
                                 {{$invoice->account->name}}
                            @endif
                        </strong><br>
                             NIT 
                             @if (count($invoice->account) > 0)
                                {{$invoice->account->identification}}
                            @endif<br>
                            @if (count($invoice->account->city) > 0)
                                   {{$invoice->account->city}}, {{$invoice->account->address}} 
                            @endif<br>
                            <abbr>Tel:</abbr>  
                            @if (count($invoice->account->phone) > 0)
                                   {{$invoice->account->phone}}
                            @endif
                            
                        </address>
                  </td>
                  <td style="text-align: right;">
                       <h2>Factura de venta No: <a class="text-navy"> {{$invoice->resolution_id}}</a></h2>                      
                        @if (count($invoice->resolution->invoice_text) > 0)
                            <h6>
                                <small class="text-muted">{{$invoice->resolution->invoice_text}}</small><br>
                                <hr class="hr-line-solid" style="color: white;background-color:green">  
                            </h6>
                        @endif
                        
                        <small>FACTURA DE VENTA ORIGINAL</small><br> 
                       <small>{{$invoice->account->account_regime->value}}</small><br><br>                        

                       <address>
                            <small>Fecha de expedición: {{$invoice->date}}</small><br>
                            <small>Fecha de vencimiento: {{$invoice->due_date}}</small>
                       </address>
                      
                  </td>
                  
                 </tr>                                       
            </tbody>
    </table
</div>
<hr class="hr-line-solid" style="color: white;background-color:green">    
<div class="">
        <address>
             <span class="text-muted text-xs block">SEÑOR(ES):<br>   
             <a class="text-navy">{{$invoice->contact->name}}</a></span><br>
             <span>Dirección: 
                 @if (count($invoice->contact) > 0)
                      {{$invoice->contact->address}}
                  @endif
             </span><br>
             <span>
                Ciudad: 
                 @if (count($invoice->contact) > 0)
                      {{$invoice->contact->city}}
                @endif
             </span><br>
              <span>Teléfono:
                 @if (count($invoice->contact) > 0)
                      {{$invoice->contact->phone1}}
                @endif
             </span><br>
              <span>
                NIT:
                 @if (count($invoice->contact) > 0)
                      {{$invoice->contact->nit}}
                @endif
             </span><br>
               @if (count($invoice->payment_terms) > 0)
                             @if (count($invoice->payment_terms->days) > 0)
                                <small>Condición de pago: Crédito</small><br>
                             @else
                                <small>Condición de pago: Contado</small><br>
                             @endif
                            
                        @endif   
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
                                     
                                        @foreach($invoice->detail as $prod)
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
                                        <td>${{$invoice->sub_total}}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Descuentos:</strong></td>
                                        <td>${{$invoice->total_discounts}}</td>
                                    </tr>
                                    @foreach($taxes as $tax)
                                    <tr>
                                        <td><strong>{{$tax->name}}</strong></td>
                                        <td>${{$tax->total}}</td>
                                    </tr>
                                    @endforeach
                                    <tr style="background:#00802b;color:white">
                                        <td><strong >TOTAL:</strong></td>
                                        <td><strong >${{$invoice->total}}</strong></td>                                    
                                    </tr>                                
                                    </tbody>
                                </table>                           
                            </div>
                            <div class="row">
                                <div class="panel-body"><br>
                                    @if (count($invoice->account) > 0)
                                    <small><strong>Notas:</strong> {{$invoice->notes}}</small>
                                    @endif                                
                                </div>
                             </div>
                             
                            <div class="ibox"><br><br><br><br>
                                     @include('partials.pdf-elaborated_by') 
                            </div>  
                      
                         <div class="footer"> 
                                <div class="ibox">
                                
                                <h6><small>
                                        Esta factura se asimila en todos sus efectos a una letra de cambio de conformidad con el Art. 774 del código de
                                        comercio. Autorizo que en caso de incumplimiento de esta obligación sea reportado a las centrales de riesgo, se
                                        cobrarán intereses por mora.
                                    </small>  </h6> 
                                       
                                </div>
                        </div>
                        
@endsection


