@extends('pdf.master',['id_file' =>  $estimate->public_id])

@section('content')



<div class="ibox">
    <table  width= "100%">
           <tbody>
                <tr>
                    <td style="text-align: centered;width: 98px">
                      @if (count($estimate->account->logo) > 0)
                         <img alt="image" src= {{$estimate->account->logo}} style='width: 98px' height='80px' />                                                   
                      @endif
                  </td>
                  <td style="text-align: left;">
                    <address>
                        <strong>
                            @if (count($estimate->account) > 0)
                                 {{$estimate->account->name}}
                            @endif
                        </strong><br>
                             NIT 
                             @if (count($estimate->account) > 0)
                                {{$estimate->account->identification}}
                            @endif<br>
                            @if (count($estimate->account) > 0)
                                   {{$estimate->account->city}}
                            @endif<br>
                            <abbr>Tel:</abbr>  
                            @if (count($estimate->account) > 0)
                                   {{$estimate->account->phone}}
                            @endif
                        </address>
                  </td>
                  <td style="text-align: right;">
                       <h2>Cotización No: <a class="text-navy"> {{$estimate->resolution_id}}</a></h2>
                       <address>
                            <small>Fecha de expedición: {{$estimate->date}}</small><br>
                            <small>Fecha de vencimiento: {{$estimate->due_date}}</small>
                       </address>
                  </td>
                  
                 </tr>                                       
            </tbody>
    </table
</div>

<div class="ibox-title">
        <address>
             <span class="text-muted text-xs block">SEÑOR(ES):<br>   
             <a class="text-navy">{{$estimate->contact->name}}</a></span><br>
             <span>Dirección: 
                 @if (count($estimate->contact) > 0)
                      {{$estimate->contact->address}}
                  @endif
             </span><br>
             <span>
                Ciudad: 
                 @if (count($estimate->contact) > 0)
                      {{$estimate->contact->city}}
                @endif
             </span><br>
              <span>Teléfono:
                 @if (count($estimate->contact) > 0)
                      {{$estimate->contact->phone1}}
                @endif
             </span><br>
              <span>
                NIT:
                 @if (count($estimate->contact) > 0)
                      {{$estimate->contact->nit}}
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
                                        <th style="text-align: center">DESC %</th>          
                                        <th style="text-align: center">TOTAL</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                     
                                        @foreach($estimate->detail as $prod)
                                            <tr>
                                                <td  style="width: 35%;">
                                                    <div><strong>{{$prod->product->name}}</strong></div>
                                                    <small>{{$prod->description}}</small>
                                                </td>    
                                                <td  style="width: 15%; text-align: center" class="table-price">${{$prod->unit_price  }}</td>
                                                <td style="width: 10%; text-align: center" class="table-qty">{{$prod->quantity}}</td>
                                                <td style="width: 10%; text-align: center">{{$prod->discount}}</td>
                                                <td style="width: 15%; text-align: center" class="table-total text-right">${{$prod->total}}</td>
                                            </tr>
                                        @endforeach                                   

                                    </tbody>
                                </table>
                            </div>
                            <div class="ibox">
                            <table class="total" >
                                <tbody>
                                <tr><td></td></tr>
                                <tr><td></td></tr>
                                <tr>
                                    <td><strong>Sub Total:</strong></td>
                                    <td>${{$estimate->sub_total}}</td>
                                </tr>
                                <tr>
                                    <td><strong>Descuentos:</strong></td>
                                    <td>${{$estimate->total_discounts}}</td>
                                </tr>
                                  @foreach($taxes as $tax)
                                    <tr>
                                        <td><strong>{{$tax->name}}</strong></td>
                                        <td>${{$tax->total}}</td>
                                    </tr>
                                @endforeach
                                <tr style="background:#00802b;color:white">
                                    <td><strong >TOTAL:</strong></td>
                                    <td><strong >${{$estimate->total}}</strong></td>                                    
                                </tr>                                
                                </tbody>
                            </table>    
                              <div class="ibox"><br><br><br><br>
                                     @include('partials.pdf-elaborated_by') 
                            </div>                              
                            </div>
                      

@endsection