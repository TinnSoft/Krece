@extends('pdf.master')

@section('content')


 
                   
                            <div class="row">
                                <div class="col-sm-6">
                                     <h1>Cotización No: <a class="text-navy"> {{$estimate->public_id}}</a></h1>
                                    <table  style=" width: 50%;border-color: #BBB; float: right;background: #EEE; border-color: #BBB;">
                                        <tbody>
                                            <tr>
                                                <td colspan=2><strong>Mi negocio:</strong></td>
                                            </tr>
                                            <tr >
                                                <td><strong>Nit:</strong></td>
                                                <td>
                                                    @if (count($estimate->contact) > 0)
                                                    {{$estimate->contact->nit}}
                                                    @endif
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><strong>Ciudad:</strong></td>
                                                    <td>
                                                        @if (count($estimate->contact) > 0)
                                                        {{$estimate->contact->city}}
                                                        @endif
                                                    </td>
                                            </tr>         
                                            <tr>
                                                <td><strong>Teléfono:</strong></td>
                                                    <td>
                                                        @if (count($estimate->contact) > 0)
                                                        {{$estimate->contact->phone1}}
                                                        @endif
                                                    </td>
                                            </tr>            
                                        </tbody>
                                    </table>  
                                </div>

                                <div class="col-sm-6 ">
                                    <div class="table-responsive m-t">
                                      <table  style=" width: 50%;border-color: black ;">
                                        <tbody >
                                            <tr>
                                                <td><h4><strong>Señor(es)</strong></h4></td>
                                                <td>
                                                    @if (count($estimate->contact) > 0)
                                                    {{$estimate->contact->name}}
                                                    @endif
                                                </td>
                                            </tr>
                                            <tr >
                                                <td><small><strong>Dirección:</strong></small></td>
                                                <td>
                                                    @if (count($estimate->contact) > 0)
                                                    {{$estimate->contact->address}}
                                                    @endif
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><small><strong>Ciudad:</strong></small></td>
                                                    <td>
                                                        @if (count($estimate->contact) > 0)
                                                        {{$estimate->contact->city}}
                                                        @endif
                                                    </td>
                                            </tr>         
                                            <tr>
                                                <td><small><strong>Teléfono:</strong></small></td>
                                                    <td>
                                                        @if (count($estimate->contact) > 0)
                                                        {{$estimate->contact->phone1}}
                                                        @endif
                                                    </td>
                                            </tr>    
                                            <tr>
                                                <td><small><strong>Nit:</strong></small></td>
                                                    <td>
                                                        @if (count($estimate->contact) > 0)
                                                        {{$estimate->contact->nit}}
                                                        @endif
                                                    </td>
                                            </tr>           
                                        </tbody>
                                    </table> 
                                   </div>
                                </div>
                            </div>

                          <div class="table-responsive m-t">
                                <table class="table invoice-table"  style="width: 100%;font-size:70%;">
                                    <thead>
                                    <tr style="background: #009933; border-color: #93D4D4;color:white;">
                                        <th style="text-align: center">PRODUCTO</th>                                       
                                        <th style="text-align: center">PRECIO</th>
                                        <th style="text-align: center">CANTIDAD</th>
                                        <th style="text-align: center">DESC %</th>
                                        <th style="text-align: center">IMPUESTO %</th>           
                                        <th style="text-align: center">TOTAL</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                     
                                        @foreach($estimate->estimatedetail as $prod)
                                            <tr>
                                                <td  style="width: 35%;">
                                                    <div><strong>{{$prod->product->name}}</strong></div>
                                                    <small>{{$prod->description}}</small>
                                                </td>    
                                                <td  style="width: 15%;" class="table-price">{{$prod->unit_price  }}</td>
                                                <td style="width: 10%;" class="table-qty">{{$prod->quantity}}</td>
                                                <td style="width: 10%;" class="table-discount">{{$prod->discount}}</td>
                                                <td style="width: 15%;" class="table-taxes">{{$prod->tax_amount}}</td>
                                                <td style="width: 15%;" class="table-total text-right">{{$prod->quantity * $prod->unit_price}}</td>
                                            </tr>
                                        @endforeach                                   

                                    </tbody>
                                </table>
                            </div><!-- /table-responsive -->

                            <table class="table invoice-total" style="float: right;font-size:70%; ">
                                <tbody>
                                <tr>
                                    <td><strong>Sub Total:</strong></td>
                                    <td>{{$estimate->sub_total}}</td>
                                </tr>
                                <tr>
                                    <td><strong>Descuentos:</strong></td>
                                    <td>{{$estimate->total_discounts}}</td>
                                </tr>
                                 <tr>
                                    <td><strong>Impuestos:</strong></td>
                                    <td>{{$estimate->total_taxes}}</td>
                                </tr>
                                <tr style="background:#00802b;color:white">
                                    <td><strong >TOTAL:</strong></td>
                                    <td><strong >{{$estimate->total}}</strong></td>                                    
                                </tr>                                
                                </tbody>
                            </table>                           

                         <div class="footer">                 
                            <div>
                               <small> Cotización generada en el sistema <strong> www.krece.co</strong></small>
                            </div>
                        </div>
  
                            
                     


@endsection