@extends('pdf.master',['id_file' =>  $payment->public_id])

@section('content')

@if($payment->status_id==2)
    @include('partials.pdf-watermark_null')
@endif
<div id="content">
<div  class="ibox">

    <table  width= "100%">
           <tbody>
                <tr>
                    <td style="text-align: centered;width: 98px">
                      @if (count($payment->account->logo) > 0)
                         <img alt="image" src= {{$payment->account->logo}} style='width: 98px' height='80px' />                                                   
                      @endif
                  </td>
                  <td style="text-align: left;">
                    <address>
                        <strong>
                            @if (count($payment->account) > 0)
                                 {{$payment->account->name}}
                            @endif
                        </strong><br>
                             NIT 
                             @if (count($payment->account) > 0)
                                {{$payment->account->identification}}
                            @endif<br>
                            @if (count($payment->account) > 0)
                                   {{$payment->account->city}}
                            @endif<br>
                            <abbr>Tel:</abbr>  
                            @if (count($payment->account) > 0)
                                   {{$payment->account->phone}}
                            @endif<br>
                            @if (count($payment->account) > 0)
                                   {{$payment->account->email}}
                            @endif
                        </address>
                  </td>
                  <td style="text-align: right;">
                       <h2>Recibo de Caja No: <a class="text-navy"> {{$payment->resolution_id}}</a></h2>
                       
                     

                       <address>
                            <small>Fecha de expedición: {{$payment->date}}</small><br>
                       </address>
                       
                  </td>
                  
                 </tr>                                       
            </tbody>
    </table
</div>
<hr class="hr-line-solid" style="color: white;background-color:green">
<div >
        <address>
             <span class="text-muted text-xs block">SEÑOR(ES):<br>   
             <a class="text-navy">{{$payment->contact->name}}</a></span><br>
             <span><strong>Dirección: </strong>
                 @if (count($payment->contact) > 0)
                      {{$payment->contact->address}}
                  @endif
             </span><br>
             <span>
                <strong>Ciudad: </strong>
                 @if (count($payment->contact) > 0)
                      {{$payment->contact->city}}
                @endif
             </span><br>
              <span><strong>Teléfono:</strong>
                 @if (count($payment->contact) > 0)
                      {{$payment->contact->phone1}}
                @endif
             </span><br>
              <span>
                <strong>NIT:</strong>
                 @if (count($payment->contact) > 0)
                      {{$payment->contact->nit}}
                @endif
             </span><br>
                @if (count($payment->payment_method) > 0)
                      <strong>Método de pago:</strong> {{$payment->payment_method->name}}<br>
                @endif
                 @if (count($payment->account) > 0)
                      <strong>Cuenta:</strong> {{$payment->bank_account->bank_account_name}}<br>
                @endif
        </address>
 </div>



<div class="table-responsive m-t">
                                <table class="detail" style="width: 100%;font-size:70%;">
                                    <thead>
                                    <tr style="background: #009933; border-color: #93D4D4;color:white;">
                                        <th >CONCEPTO</th>       
                                        <th style="text-align: center">CANTIDAD</th>                                 
                                        <th style="text-align: right">VALOR</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        @foreach($detail as $prod)
                                            <tr>
                                                <td  style="width: 33%;" >
                                                    {{$prod['concept']}}
                                                </td>    
                                               <td  style="width: 33%;text-align: center" >
                                                    {{$prod['quantity']}}
                                                </td>    
                                                <td style="width: 15%; text-align: right"
                                                class="table-total ">
                                                ${{$prod['total']}}</td>
                                            </tr>
                                        @endforeach   
                                    </tbody>
                                </table>
                            </div><br>
                            <div class="ibox">                                
                                <table class="total"  >
                                    <tbody>                                   
                                    <tr>
                                        <td><strong>Sub Total:</strong></td>
                                        <td>${{$subtotal}}</td>
                                    </tr>
                                  
                                    @foreach($taxes as $tax)
                                    <tr>
                                        <td><strong>{{$tax->name}}</strong></td>
                                        <td>${{$tax->total}}</td>
                                    </tr>
                                    @endforeach
                                    <tr style="background:#00802b;color:white">
                                        <td><strong >TOTAL:</strong></td>
                                        <td><strong >${{$total}}</strong></td>                                    
                                    </tr>                                
                                    </tbody>
                                </table>                           
                            </div>
                             <div class="row">
                                <div class="panel-body"><br>
                                    @if (count($payment->account) > 0)
                                    <small><strong>Notas:</strong> {{$payment->notes}}</small>
                                    @endif                                
                                </div>
                             </div>
                            <div class="ibox"><br><br><br><br>
                                     @include('partials.pdf-elaborated_by') 
                            </div>   
                                            

    </div>                    
                        
@endsection
