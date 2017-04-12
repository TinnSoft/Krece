@extends('pdf.master',['id_file' =>  $po->public_id])

@section('content')



<div class="ibox">
    <table  width= "100%">
           <tbody>
                <tr>
                    <td style="text-align: centered;width: 98px">
                      @if (count($po->account->logo) > 0)
                         <img alt="image" src= {{$po->account->logo}} style='width: 98px' height='80px' />                                                   
                      @endif
                  </td>
                  <td style="text-align: left;">
                    <address>
                        <strong>
                            @if (count($po->account) > 0)
                                 {{$po->account->name}}
                            @endif
                        </strong><br>
                             NIT 
                             @if (count($po->account) > 0)
                                {{$po->account->identification}}
                            @endif<br>
                            @if (count($po->account) > 0)
                                   {{$po->account->city}}
                            @endif<br>
                            <abbr>Tel:</abbr>  
                            @if (count($po->account) > 0)
                                   {{$po->account->phone}}
                            @endif
                        </address>
                  </td>
                  <td style="text-align: right;">
                       <h2>Orden de Compra No: <a class="text-navy"> {{$po->resolution_id}}</a></h2>
                       <address>
                            <small>Fecha de expedición: {{$po->date}}</small><br>
                            <small>Fecha de entrega: {{$po->due_date}}</small>
                       </address>
                  </td>
                  
                 </tr>                                       
            </tbody>
    </table
</div>

<div class="ibox-title">
        <address>
             <span class="text-muted text-xs block">SEÑOR(ES):<br>   
             <a class="text-navy">{{$po->contact->name}}</a></span><br>
             <span>Dirección: 
                 @if (count($po->contact) > 0)
                      {{$po->contact->address}}
                  @endif
             </span><br>
             <span>
                Ciudad: 
                 @if (count($po->contact) > 0)
                      {{$po->contact->city}}
                @endif
             </span><br>
              <span>Teléfono:
                 @if (count($po->contact) > 0)
                      {{$po->contact->phone1}}
                @endif
             </span><br>
              <span>
                NIT:
                 @if (count($po->contact) > 0)
                      {{$po->contact->nit}}
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
                                     
                                        @foreach($po->detail as $prod)
                                            <tr>
                                                <td  style="width: 35%;">
                                                    <div><strong>{{$prod->category->name}}</strong></div>
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
                                    <td>${{$po->sub_total}}</td>
                                </tr>
                                <tr>
                                    <td><strong>Descuentos:</strong></td>
                                    <td>${{$po->total_discounts}}</td>
                                </tr>
                                 @foreach($taxes as $tax)
                                    <tr>
                                        <td><strong>{{$tax->name}}</strong></td>
                                        <td>${{$tax->total}}</td>
                                    </tr>
                                    @endforeach
                                <tr style="background:#00802b;color:white">
                                    <td><strong >TOTAL:</strong></td>
                                    <td><strong >${{$po->total}}</strong></td>                                    
                                </tr>                                
                                </tbody>
                            </table>                                           
                            </div>
                            
                            <div class="ibox">
                                <div class="col-lg-4"> <br> <br>
                                <table>
                                   
                                    <tbody>
                                    @if ($po->notes<>'')
                                        <tr>
                                            <td ><small><strong>Notas: </strong> {{$po->notes}}</small></td>
                                        </tr>
                                    @endif
                                    <tr><td></td></tr>
                                    <tr><td></td></tr>
                                    @if ($po->terms<>'')
                                    <tr>                                        
                                        <td ><small><strong>Términos y condiciones: </strong> {{$po->terms}}</small></td>
                                    </tr>
                                     @endif
                                    </tbody>
                                </table>
                                </div>
                            </div>

                          <div class="ibox"><br><br><br><br>
                                     @include('partials.pdf-elaborated_by') 
                            </div> 

@endsection