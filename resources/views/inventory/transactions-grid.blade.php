
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jqueryui/jquery-ui.css')!!}
    {!!Html::style('/themes/krece/css/plugins/jqgrid/ui.jqGrid.css')!!}  
     {!!Html::script('/themes/krece/js/plugins/jqgrid/jquery.jqGrid52.min.js')!!}  
     {!!Html::script('/themes/krece/js/plugins/jquery-layout/jquery.layout.js')!!}
      {!!Html::script('/themes/krece/js/plugins/jqgrid/i18n/grid.locale-es.js')!!}  
       {!!Html::script('/js/vue-library/vue.min.js')!!}
       

    

 <style>
          .green {color: green;}
        .red {color: red;}
        .white {color: white;}
    </style>

        <div id="contact2" class="jqGrid_wrapper">            
          
           <div class="">
           <div id="pager_list_2"></div> 
                    <div id='gridContainer'></div>
                    <button id="export">Export to Excel</button>
            </div> 
    <div>

    <script>
        
        $(document).ready(function () {  
            jQuery.jgrid.no_legacy_api = true;

            var emptyMsgDiv = $("<div class='ibox-content ibox-heading'>" +
            "<h3><i class='fa fa-exclamation'></i> Aún no tienes ninguna transacción creada!</h3>" +
            " <div class='ibox-content ibox-heading'><a href='{{route('contact.index')}}' class='btn btn-primary btn-outline btn-sm '>" +
                                                "<span class='fa fa-plus '></span>&nbsp;Nueva transacción</a> </div></div> '");

     
              //on load -> crear tabla
                 var _colModelx=[{ label: 'cliente2', name: 'name', index: 'name', width: 75, sorttype: "text" } ];
                 createGrid('remision',{!!$products->id!!}, _colModelx,'Transacciones','#pager_list_2');

           //Facturas de venta
             $("#invoice").on("click", function(){             
                
                 var _colModelx=[{ label: 'proveedor', name: 'name', index: 'name', width: 75, sorttype: "text" } ];
                 createGrid('remision',{!!$products->id!!}, _colModelx,'Factura de venta','#pager_list_2');
			})

            //Remisiones
            $("#remision").on("click", function(){               

                 function state_mask(cellvalue, options, rowObject) {
                    if (cellvalue==1)
                    {
                        return "<p><span class='label label-primary'>"+rowObject.status_description+"</span></p>"
                    }
                    else {
                        return "<p><span class='label label-warning'>"+rowObject.status_description+"</span></p>"
                    };
                   
                }
                
                 var _colModelx=[
                     {label:'No', name:'resolution_id',  keys: true,"width":40, index:'public_id',  align:"center"} , 
                     {label: 'Cliente', name: 'name', index: 'name', width: 75, sorttype: "text" } ,
                     { label: 'Creación', name: 'date',  formatter:'date',formatoptions: {newformat: 'd/m/Y'}},
                     { label: 'Vence en', name: 'due_date', formatoptions: {newformat: 'd/m/Y'},  formatter: 'date'},
                     { label: 'Estado', name: 'status_id',width: 70,align:"center", formatter:state_mask },
                     { label: 'Total', name: 'total', formatter:'currency',align:"right", formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ "} },
                     
                ];
                 createGrid('remision',{!!$products->id!!}, _colModelx,'Remisiones','#pager_list_2');
			})

            //Cotizaciones
            $("#estimate").on("click", function(){    
              
                
                 var _colModelx=[
                     {label:'No', name:'resolution_id',  keys: true,"width":40, index:'public_id',  align:"center"} , 
                     {label: 'Cliente', name: 'name', index: 'name', width: 75, sorttype: "text" } ,
                     { label: 'Creación', name: 'date',  formatter:'date',formatoptions: {newformat: 'd/m/Y'}},
                     { label: 'Vence en', name: 'due_date', formatoptions: {newformat: 'd/m/Y'},  formatter: 'date'},
                     { label: 'Total', name: 'total', formatter:'currency',align:"right", formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ "} },
                     
                ];
                 createGrid('estimate',{!!$products->id!!}, _colModelx,'Cotizaciones','#pager_list_2');
			})
            
          function dropGrid()
          {
            $('#transaction-grid').jqGrid("clearGridData");
            $('#transaction-grid').remove();
            $.jgrid.gridDestroy('#gridContainer'); 
            $('#gridContainer').empty();
          }

           function createGrid(transaction_type,customerId, model, _caption, _pager){
               dropGrid();
              
                var table = document.createElement('table');
                table.id = 'transaction-grid';
                $('#gridContainer').append(table);
                

            $('#transaction-grid').jqGrid({
                datatype: 'json',
                url:'getInventoryReports/'+transaction_type+'/'+customerId,
                mtype: 'GET',    
                emptyrecords:  "",
                colModel: model,
                viewrecords: true, 
                width: 'auto',
                height: 300,
                autoresizeOnLoad: true,
                shrinkToFit: true,               
                autowidth: true,
                autoResizing: {
                    compact: true
                    },
                 cmTemplate: {
                    autoResizable: true,
                    editable: true
                    },         
                rowNum: 20,
                rowList: [20, 50, 100],
                caption:_caption,
                loadtext: 'Cargando...',
                loadonce:true,
                gridview:true,
                page: 1,
                navOptions: { reloadGridOptions: { fromServer: true } },
                loadComplete: function () {
                    var count = $("#transaction-grid").getGridParam();
                    var ts = $("#transaction-grid")[0];
                    if (ts.p.reccount === 0) {
                        $("#transaction-grid").hide();
                        emptyMsgDiv.show();
                    } else {
                        $("#transaction-grid").show();
                        emptyMsgDiv.hide();
                    };                   
                }, 
                toppager: true,
                //pager:'#pager_list_2'
            });
   

            emptyMsgDiv.insertAfter($("#transaction-grid").parent());



            jQuery('#transaction-grid').jqGrid('navGrid','#pager_list_2',
                {
                    "edit":false,
                    "add":false,
                    "del":false,
                    "search":true,
                    "refresh":false,
                    "view":false,
                    "excel":true,
                    "pdf":false,
                    "csv":false,
                    "columns":false,
                    cloneToTop: true,
                },
                {"drag":true,"resize":true,"closeOnEscape":true,"dataheight":150},
                {"drag":true,"resize":true,"closeOnEscape":true,"dataheight":150}
                );
                                
              setTimeout(function(){
                $('.wrapper-content').removeClass('animated fadeInRight');
            },700);
            
      
			var timer;
			$("#search_cells").on("keyup", function() {
				var self = this;
				if(timer) { clearTimeout(timer); }
				timer = setTimeout(function(){
					$("#transaction-grid").jqGrid('filterInput', self.value);
				},0);
			});
           };

        });

        

    </script>

