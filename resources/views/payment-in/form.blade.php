
<!--evita que se muestren los caracteres ocultos mientras se cargan los datos-->
<style>
[v-cloak] {
  display: none;
}
</style>


<link href="/css/style_tables.css" rel="stylesheet">

        <div class="row">
            <div class="col-lg-5">
                 <h2>Recibo de caja No: @{{form.resolution_id}}</h2>
            </div>        
        </div>

 

@section('header_payment')
    <div class="row">        
        <div class="col-lg-5">
            <table class="table table-responsive">			
                
				<tr> 
					<th style="width: 10em"><span>Cliente</span><a class="text-danger"><strong> *</strong></a></th>
					<td>  <span>  
                     
                          <multiselect 
                            :options="customer_list" 
                            v-model="form.contact"
                            label="name"         
                            track-by="name"
                            :show-labels="false"
                            placeholder="Seleccione..." 
                            @input="onInputContact"
                        >
                        </multiselect>

                        <small v-if="errors.customer_id" class="error is-danger  text-danger">
                            Olvidaste seleccionar un cliente.
                        </small>   </span>                           
                    </td>                 
				</tr>

                <tr> 
					<th style="width: 10em"><span>Cuenta</span><a class="text-danger"><strong> *</strong></a></th>
					<td>  <span>  
                     
                           <multiselect 
                                v-model="form.bank_account" 
                                :options="bank" 
                                :multiple="false" 
                                group-values="bank" 
                                group-label="description" 
                                placeholder="Seleccione..." 
                                track-by="bank_account_name" 
                                label="bank_account_name"
                                 @input="onInputBank">                                
                        </multiselect>

                        <small v-if="errors.bank_account_id" class="error is-danger  text-danger">
                            Debes seleccionar una cuenta.
                        </small>   </span>                           
                    </td>                 
				</tr>
               
               <tr> 
					<th style="width: 10em"><span>Método de pago</span><a class="text-danger"><strong> *</strong></a></th>
					<td>  <span>  
                     
                         <multiselect 
                                v-model="form.payment_method" 
                                label="name" 
                                placeholder="Seleccione..." 
                                :options="paymentmethod" 
                               :show-labels="false"
                                :allow-empty="false"
                                @input="onInputPaymentMethod">
                            </multiselect>

                        <small v-if="errors.payment_method_id" class="error is-danger  text-danger">
                            Debe seleccionar un método de pago
                        </small>   </span>                           
                    </td>                 
				</tr>
                <tr> 
					<th style="width: 10em"><span>Fecha</span><a class="text-danger"><strong> *</strong></a></th>
					<td>
                        <span >                        
                             <datepicker-vue class="form-control" 
                                v-model="form.date" 
                                value='@{{form.date }}'>
                             </datepicker-vue>
                                             
                            <small v-if="errors.date" class="error is-danger  text-danger">
                            Ingrese una fecha para la factura de venta</small>  
                        </span>
                    </td>                 
				</tr>
				
			</table>
        </div> 

         <div class="col-lg-5">
            <table class="table table-responsive">				
				
                <tr>
					<th><span >Notas del recibo</span></th>
					<td>
                        <span id="prefix2" ></span>
                        <span>
                        
                            <textarea class="form-control has-icon has-icon-right form-control"v-model="form.notes"></textarea> 
                            
                        </span>

                    </td>
				</tr>
                 <tr>
					<th><span >Observaciones</span></th>
					<td>
                        <span id="prefix1" ></span>
                        <span>
                            <textarea class="form-control" 
                            v-model="form.observations"></textarea>
                        </span>
                    </td>
				</tr>
			</table>
            
        </div> 
        
    </div> 
<small>los campos marcados con <a class="text-danger"><strong> *</strong></a> son obligatorios</small>
@endsection

@section('payment_warning1')
        <template v-if="wasCustomerSelected()==false">
            <p  class="text-center">
                <div class="alert alert-warning">
                    <span class="text-center">Para asociar este pago a una  <strong>factura de venta</strong>, 
                        primero debes seleccionar un cliente que tenga facturas de venta pendientes por pagar
                        existente?
                    </span>
                </div>
            </p>  
        </template> 
@endsection

@section('payment_warning2')
        <template v-if="hasPendingPayment==0">
            <p  class="text-center">
                <div class="alert alert-warning">
                    <span class="text-center">El cliente seleccionado no tiene  <strong>pagos pendientes</strong>
                    </span>
                </div>
            </p>  
        </template> 
@endsection

@section('payment_pending_to_pay')

    <table class="table-hover">
    <thead>
        <tr>           
            <th >Factura #</th>
            <th>Total</th>
            <th>Pagado</th>
            <th>Por Pagar</th>
            <th>Valor Recibido</th>
        </tr>
    </thead>
       
    <tbody>
        
        <tr v-for="_pend in form.pending_payment_in">                       
                
             <td class="form-ref" style="width: 7em" >
               <a @click="goShow(_pend.public_id)">@{{_pend.resolution_id}}</a>
            </td> 
             <td class="form-ref" style="width: 7em" >
                $@{{_pend.total}}
            </td> 
             <td class="form-ref" style="width: 7em" >
               $@{{_pend.total_payed}}
            </td> 
             <td class="form-ref" style="width: 7em" >
                $@{{_pend.total_pending_by_payment}}
            </td> 
             <td class="form-ref" style="width: 7em" >
                 <input type="number" class="form-control input-sm input_number" v-model.number="_pend.amount_receipt">
            </td> 
        <tr>
    </tbody>
    
    </table>
 
@endsection


@section('payment_to_category')

    <table class="table-hover">
    <thead>
        <tr>           
            <th >Categoría</th>
            <th>Valor</th>
            <th>Impuesto</th>
            <th>Cantidad</th>
            <th>Observaciones</th>
            <th colspan=2>Total</th>
        </tr>
    </thead>
       
    <tbody>
        
        <tr v-for="_data in form.payment_in_to_category">                       
            
             <td style="width: 18em" class="form-category_id"  >
               <span> 
                    <multiselect 
                            :options="category_list"
                            v-model="_data.category"
                            label="name"         
                            track-by="name"
                            :show-labels="false"
                            placeholder="Buscar Categoría..." 
                            @input="onInputCategory(_data)"
                        >
                        </multiselect>
                </span>  
            </td>     
            
             <td class="form-ref" style="width: 7em" >
               <input type="number" min=0 class="form-control input-sm input_number"  v-model.number="_data.unit_price">
            </td> 
             <td class="form-ref" style="width: 8em" >
               <multiselect 
                            :options="taxes" 
                            v-model="_data.tax_value"
                            label="text"         
                            track-by="value"
                            placeholder=""
                            ShowLabels="false"
                            @input="onInputTax(_data)"
                            :show-labels="false"
                        >
                        </multiselect>
            </td> 
             <td class="form-ref" style="width: 5em" >
                <input type="number" min=0 class="form-control input-sm input_number" v-model.number="_data.quantity">
            </td> 
             <td class="form-ref" style="width: 7em" >
                 <textarea rows="1" class="form-control input_number" v-model="_data.observations"></textarea>
            </td>              
             <td class="form-ref" style="width: 7em" >
               <span class="form-number">@{{_data.quantity * _data.unit_price  | formatCurrency}}</span>
            </td> 
            <td style="width: 1em">
               <a @click="removeItem(_data)">
                    <span id="icon-detail" class="fa fa-remove fa-2x" style="color:red">
                    </span>
                </a>
            </td>      
        <tr>
    </tbody>    
    </table>
    <template id="mtemplate">
    </template>


    <table class="table2">
            <tr>					
                <span class="fa fa-plus-circle" style="color:green">&nbsp;&nbsp;</span><a @click="addLine" ><u>Agregar nuevo ítem</u></a>
            </tr>
    </table>
 
@endsection

            <div class="row animated fadeInRight">
                        <div id="vertical-timeline" class="vertical-container dark-timeline left-orientation">
                            <div class="vertical-timeline-block">
                                <div class="vertical-timeline-icon navy-bg">
                                    <i class="fa fa-pencil-square-o"></i>
                                </div>

                                <div class="vertical-timeline-content">
                                    <h2>Datos generales del Ingreso</h2>
                                     @yield('header_payment')  
                                </div>
                            </div>

                            <div class="vertical-timeline-block">
                                <div class="vertical-timeline-icon blue-bg">
                                    <i class="fa fa-question"></i>
                                </div>

                                <div class="vertical-timeline-content">
                                    <h2>Tipo de transacción</h2>
                                        <span><h5><small>Tambien es posible registrar un ingreso sin necesidad de estar asociado a una factura de venta</small></h5></span>
                                        <div class="ibox-content">
                                            <div class="panel panel-info"> 
                                                <div class="panel-body">
                                                    <p class="text-center">
                                                        <span class="text-center">¿Desea asociar este ingreso a una <strong>factura de venta</strong> existente?
                                                            <span> <br>
                                                                <body>
                                                                    <input type="radio" id="percentaje" value=1 v-model="form.isInvoice" @click=" getInvoiceSale()">
                                                                        <label for="p">Si</label>
                                                                    <input type="radio" id="value" value=0 v-model="form.isInvoice" @click=" getInvoiceSale()">
                                                                        <label for="v">No</label>   
                                                                </body>
                                                            </span>
                                                        </span><br>
                                                    </p>   
                                                 </div>
                                            </div>  
                                            @yield('payment_warning1')    
                                            @yield('payment_warning2') 
                                            <template  v-if="errors.payment_empty" >
                                                    <div class="alert alert-danger">         
                                                        Asegurese que el cliente seleccionado tenga pagos pendientes
                                                </div>
                                            </template>
                                             <template  v-if="errors.amount_error" >
                                                    <div class="alert alert-danger">         
                                                       Los montos que ha ingresado <strong>son mayores a los habilitados 
                                                       por pagar</strong>, revise nuevamente
                                                </div>
                                            </template>

                                            
                                        </div>
                                </div>
                            </div>
                            <template v-if="DisplayPendingInvoiceSale()==true">
                                <div class="vertical-timeline-block">
                                    <div class="vertical-timeline-icon lazur-bg">
                                        <i class="fa fa-paste"></i>
                                    </div>

                                    <div class="vertical-timeline-content">
                                        <h2>Facturas de venta pendientes</h2>
                                        @yield('payment_pending_to_pay')
                                    </div>
                                </div>
                            </template>
                             <template v-if="form.isInvoice==0">
                            <div class="vertical-timeline-block">
                                <div class="vertical-timeline-icon lazur-bg">
                                    <i class="fa fa-th"></i>
                                </div>

                                <div class="vertical-timeline-content">
                                    <h2>Seleccione la Categoría a la que pertenece el gasto</h2>
                                    @yield('payment_to_category')
                                </div>
                            </div>
                            </template>
                    </div>
            </div>
  
<pre><code>@{{$data.errors | json}}</code></pre>
<!--

<pre><code>@{{$data.form | json}}</code></pre>
-->


