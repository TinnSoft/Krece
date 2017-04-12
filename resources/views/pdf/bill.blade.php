@extends('pdf.master',['id_file' =>  $bill->public_id])

@section('content')



<div class="ibox">
    <table  width= "100%">
           <tbody>
                <tr>
                    <td style="text-align: centered;width: 98px">
                      @if (count($bill->account->logo) > 0)
                         <img alt="image" src= {{$bill->account->logo}} style='width: 98px' height='80px' />                                                   
                      @endif
                  </td>
                  <td style="text-align: left;">
                    <address>
                        <strong>
                            @if (count($bill->account) > 0)
                                 {{$bill->account->name}}
                            @endif
                        </strong><br>
                             NIT 
                             @if (count($bill->account) > 0)
                                {{$bill->account->identification}}
                            @endif<br>
                            @if (count($bill->account) > 0)
                                   {{$bill->account->city}}
                            @endif<br>
                            <abbr>Tel:</abbr>  
                            @if (count($bill->account) > 0)
                                   {{$bill->account->phone}}
                            @endif
                        </address>
                  </td>
                  <td style="text-align: right;">
                       <h2>Factura de Proveedores No: <a class="text-navy"> {{$bill->resolution_id}}</a></h2>
                       <small>{{$bill->account->account_regime->value}}</small><br>

                       <address>
                            <small>Fecha de expedición: {{$bill->date}}</small><br>
                            <small>Fecha de vencimiento: {{$bill->due_date}}</small>
                       </address>
                       
                  </td>
                  
                 </tr>                                       
            </tbody>
    </table
</div>

<div class="ibox-title">
        <address>
             <span class="text-muted text-xs block">SEÑOR(ES):<br>   
             <a class="text-navy">{{$bill->contact->name}}</a></span><br>
             <span>Dirección: 
                 @if (count($bill->contact) > 0)
                      {{$bill->contact->address}}
                  @endif
             </span><br>
             <span>
                Ciudad: 
                 @if (count($bill->contact) > 0)
                      {{$bill->contact->city}}
                @endif
             </span><br>
              <span>Teléfono:
                 @if (count($bill->contact) > 0)
                      {{$bill->contact->phone1}}
                @endif
             </span><br>
              <span>
                NIT:
                 @if (count($bill->contact) > 0)
                      {{$bill->contact->nit}}
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
                                     
                                        @foreach($bill->detail as $prod)
                                            <tr>
                                                <td  style="width: 33%;">
                                                    <div><strong>{{$prod->category->name}}</strong></div>
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
                                        <td>${{$bill->sub_total}}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Descuentos:</strong></td>
                                        <td>${{$bill->total_discounts}}</td>
                                    </tr>
                                    @foreach($taxes as $tax)
                                    <tr>
                                        <td><strong>{{$tax->name}}</strong></td>
                                        <td>${{$tax->total}}</td>
                                    </tr>
                                    @endforeach
                                    <tr style="background:#00802b;color:white">
                                        <td><strong >TOTAL:</strong></td>
                                        <td><strong >${{$bill->total}}</strong></td>                                    
                                    </tr>                                
                                    </tbody>
                                </table>                           
                            </div>
                       
                        
@endsection


