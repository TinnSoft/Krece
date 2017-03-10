
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jqgrid/ui.jqGrid.css')!!}  
     {!!Html::script('/themes/krece/js/plugins/jqgrid/jquery.jqGrid52.min.js')!!}  
     {!!Html::script('/themes/krece/js/plugins/jquery-layout/jquery.layout.js')!!}
      {!!Html::script('/themes/krece/js/plugins/jqgrid/i18n/grid.locale-es.js')!!}  
       {!!Html::script('/js/vue-library/vue.min.js')!!}
    {!!Html::style('/themes/krece/css/plugins/jqueryui/jquery-ui.css')!!}



    <div class=jqGrid_wrapper> 
        <div class=ibox-content>     
            <table id=bankaccount-grid></table>
            <div id=pager_list_2></div>     
        </div>        
    <div>

    <script>
        
        $(document).ready(function () {       
            var emptyMsgDiv = $("<div class='ibox-content ibox-heading'>" +
            "<h3><i class='fa fa-exclamation'></i> Aún no se han realizado transacciones para este banco!</h3>" +
            "</div>'");

            var baccount = {!!$account!!};

            $('#bankaccount-grid').jqGrid({
                url: '/getbank_transaction_history/' + baccount.id,               
                datatype: 'json',
                mtype: 'GET',
                colModel: [        
                    { label: 'Fecha', name: 'date', formatoptions: {newformat: 'd/m/Y'},  formatter: 'date', width: 60 },
                    { label: 'Beneficiario', name: 'customer_name', width: 120 },
                    { label: 'Categoría', name: 'category_name', width: 120 },
                    { label: 'Estado', name: 'status_id', width: 40,formatter:state_mask },
                    { label: 'Salida', name: 'total_outcome', width: 90,formatter: 'currency',
                    formatoptions: { decimalSeparator: '.', decimalPlaces: 2, thousandsSeparator: ',', prefix: '$' }},  
                    { label: 'Entradas', name: 'total_income', width: 90,formatter: 'currency',
                    formatoptions: { decimalSeparator: '.', decimalPlaces: 2, thousandsSeparator: ',', prefix: '$' }},  
                    {name:'public_id',  keys: true,'width':100, label:'Acciones', index:'public_id',  'align':'right' , 
                     sortable: false, formatter: displayButtons }      
                ],
                 autoresizeOnLoad: true,
                viewrecords: true, 
                autowidth: true,
                shrinkToFit: true,
                autoResizing: {
                    compact: true
                    },
                 cmTemplate: {
                    autoResizable: true,
                    editable: true
                    },             
                height: 'auto',
                rowNum: 10,
                rowList: [10, 20, 50, 100],
                caption:'Resumen de movimientos',
                loadonce:true,               
                loadComplete: function () {
                    var count = $('#bankaccount-grid').getGridParam();
                    var ts = $('#bankaccount-grid')[0];
                    if (ts.p.reccount === 0) {
                        $('#bankaccount-grid').hide();
                        emptyMsgDiv.insertAfter($('#bankaccount-grid').parent());
                        emptyMsgDiv.show();
                    } else {
                        $('#bankaccount-grid').show();
                        emptyMsgDiv.hide();
                    };
                   // resizewidth();
                },         
                pager:'#pager_list_2'
            });

  
            function state_mask(cellvalue, options, rowObject) {
                if (cellvalue==1)
                {
                    return "<p><span class='label label-primary'>Abierta</span></p>"
                }
                else{
                      return "<p><span class='label label-warning'>Anulada</span></p>"
                }
            }

             jQuery('#bankaccount-grid').jqGrid('navGrid','#pager_list_2',
                {
                    'edit':false,
                    'add':false,
                    'del':false,
                    'search':true,
                    'refresh':false,
                    'view':false,
                    'excel':false,
                    'pdf':false,
                    'csv':false,
                    'columns':false
                },
                {'drag':true,'resize':true,'closeOnEscape':true,'dataheight':150},
                {'drag':true,'resize':true,'closeOnEscape':true,'dataheight':150}
                );
                                
              setTimeout(function(){
                $('.wrapper-content').removeClass('animated fadeInRight');
            },700);

             function displayButtons(cellvalue, options, rowObject) {
                var edit = "<div  title= 'Editar'  class='fa fa-pencil fa-2x' style='cursor: pointer ; color:green' onClick=appBankAccountShow.paymentIN_Edit(\""+cellvalue+"\") ></div><span > </span>",
                    Details = "<div title= 'Ver' class='fa fa-eye fa-2x' style='cursor: pointer; color:blue'  onClick=appBankAccountShow.paymentIN_Show(\""+cellvalue+"\")></div><span > </span>";
                    Delete = "<div title= 'Eliminar' class='fa fa-remove fa-2x'  style='cursor: pointer; color:red' onclick=appBankAccountShow.payment_remove(\""+cellvalue+"\")/></div><span > </span>";
                    
                if (rowObject.total_outcome>0)
                {
                    edit = "<div  title= 'Editar'  class='fa fa-pencil fa-2x' style='cursor: pointer ; color:green' onClick=appBankAccountShow.paymentOUT_Edit(\""+cellvalue+"\") ></div><span > </span>";
                    Details = "<div title= 'Ver' class='fa fa-eye fa-2x' style='cursor: pointer; color:blue'  onClick=appBankAccountShow.paymentOUT_Show(\""+cellvalue+"\")></div><span > </span>";
                }

                if (rowObject.payment_method_id==3)
                {
                   //Delete = "<div title= 'Eliminar' class='fa fa-remove fa-2x'  style='color:#F3D8D5'/></div><span > </span>";
                    edit = "<div  title= 'Editar'  class='fa fa-pencil fa-2x' style='color:#ABEBC6'/></div><span > </span>";
                }
               
                return edit + Details + Delete;
            }   


        });


    </script>

