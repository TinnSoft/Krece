
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jqGrid/ui.jqgrid.css')!!}  
     {!!Html::script('/themes/krece/js/plugins/jqgrid/jquery.jqGrid52.min.js')!!}  
     {!!Html::script('/themes/krece/js/plugins/jquery-layout/jquery.layout.js')!!}
      {!!Html::script('/themes/krece/js/plugins/jqgrid/i18n/grid.locale-es.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jQueryUI/jquery-ui.css')!!}
    <script>
        moment.locale('es');  
    </script>
    

 <style>
          .green {color: green;}
        .red {color: red;}

    </style>
       
      
                 <div class="table-responsive">
                    <table id="payment-grid"></table>
                <div>
                <div id="pager_list_2"></div>     
        
    <script>
        
        $(document).ready(function () {       
             var emptyMsgDiv = $("<div class='ibox-content ibox-heading'>" +
            "<h3><i class='fa fa-exclamation'></i> No tienes pagos creados!</h3>" +
            " <div class='ibox-content ibox-heading'><a href='{{route('payment-in.create')}}' class='btn btn-primary btn-outline btn-sm '>" +
            "<span class='fa fa-plus '></span>&nbsp;Adicionar nuevo pago</a> </div></div> '");
         
            $("#payment-grid").jqGrid({
                url: "getPaymentList",
                datatype: "json",
                mtype: 'GET',
                emptyrecords:  "",
                colModel: [                   
                    { label: 'No', name: 'resolution_id', align:"center",index: 'resolution_id', width: 30, sorttype: "int",formatter:formatpublicID },
                    { label: 'Cliente', name: 'contact',  width: 140, sorttype: "text" },
                    { label: 'Tipo de Proceso', name: 'IsCategory', width: 100,align:"left", formatter:processtype_mask },
                    { label: 'Fecha', name: 'date', width: 60, formatter: 'date', formatoptions: {newformat: 'd/m/Y'}},
                     { label: 'Cuenta', name: 'bank_account_name', width: 100},
                     { label: 'Estado', name: 'status_id', width: 50,align:"center", formatter:state_mask },
                     { label: 'Monto', name: 'total', width: 70, formatter:'currency', formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ "} },
                     {name:'public_id', search:false, keys: true,"width":100, label:'Acciones', index:'public_id',  "align":"right" , sortable: false, formatter: displayButtons }                  
                ],
                viewrecords: true, // show the current page, data rang and total records on the toolbar
                autowidth: true,
                autoresizeOnLoad: true,
                autoResizing: {
                    compact: true
                    },
                 cmTemplate: {
                    autoResizable: true,
                    editable: true
                    },
                shrinkToFit: true,
                height: 'auto',
                rowNum: 10,
                rowList: [10, 20, 50, 100],
                caption:" ",
                loadonce:true,
                navOptions: { reloadGridOptions: { fromServer: true } },
                loadComplete: function () {
                    var count = $("#payment-grid").getGridParam();
                    var ts = $("#payment-grid")[0];
                    if (ts.p.reccount === 0) {
                        $("#payment-grid").hide();
                        emptyMsgDiv.insertAfter($("#payment-grid").parent());
                        emptyMsgDiv.show();
                    } else {
                        $("#payment-grid").show();
                        emptyMsgDiv.hide();
                    };
                   // resizewidth();
                },         
                pager:"#pager_list_2"
            });
            

             jQuery('#payment-grid').jqGrid('navGrid','#pager_list_2',
                {
                    "edit":false,
                    "add":false,
                    "del":false,
                    "search":true,
                    "refresh":false,
                    "view":false,
                    "excel":false,
                    "pdf":false,
                    "csv":false,
                    "columns":false
                },
                {"drag":true,"resize":true,"closeOnEscape":true,"dataheight":150},
                {"drag":true,"resize":true,"closeOnEscape":true,"dataheight":150}
                );
                                
              setTimeout(function(){
                $('.wrapper-content').removeClass('animated fadeInRight');
            },700);

             function state_mask(cellvalue, options, rowObject) {
                if (cellvalue==1)
                {
                    return "<div><p><span class='label label-primary'>Abierta</span></p>"
                }
                else{
                      return "<p><span class='label label-warning'>Anulada</span></p>"
                }
            }

            function processtype_mask(cellvalue, options, rowObject) {
                if (cellvalue==1)
                {
                    return "<p class='text-primary'>Categoría</p>"
                }
                else{
                      return "<p class='text-success'>Factura de venta: "+rowObject.invoice_id+"</p>"
                }
            }

             function displayButtons(cellvalue, options, rowObject) {
                var edit = "<div  title= 'editar'  class='fa fa-pencil fa-2x green' style='cursor: pointer' onClick=paymentApp.goEdit(\""+cellvalue+"\") ></div><span > </span>",
                    Details = "<div title= 'ver' class='fa fa-eye fa-2x green' style='cursor: pointer'  onClick=paymentApp.goShow(\""+cellvalue+"\")></div><span > </span>",
                    Print = "<div title= 'Imprimir' class='fa fa-print fa-2x' style='cursor: pointer'  onClick=paymentApp.printPdf(\""+cellvalue+"\")></div><span > </span>",
                    Delete = "<div title= 'eliminar' class='fa fa-remove fa-2x red'  style='cursor: pointer' onclick=paymentApp.remove(\""+cellvalue+"\")/></div><span > </span>";
                    Lock = "<div title= 'Anular' class='fa fa-unlock fa-2x '  style='cursor: pointer; color:#DDB215' onclick=paymentApp.updateItemStatus(\""+rowObject.payment_id+"\",'2')/></div><span > </span>";
                    if (rowObject.status_id==2)
                    {                    
                        edit = "<div  title= 'Editar'  class='fa fa-pencil fa-2x' style='color:#ABEBC6'/></div><span > </span>";
                        Lock = "<div title= 'Activar' class='fa fa-lock fa-2x'  style='cursor: pointer; color:gray' onclick=paymentApp.updateItemStatus(\""+rowObject.payment_id+"\",'1')/></div><span > </span>";
                        Delete = "<div title= 'Eliminar' class='fa fa-remove fa-2x'  style='color:#F3D8D5'/></div><span > </span>";
                        Print = "<div title= 'Imprimir' class='fa fa-print fa-2x' style='color:#F3D8D5' /></div><span > </span>";
                    }
                return Lock + Details + Print +  edit+ Delete;
            }   

            function formatpublicID(cellValue, options, rowObject) {
                    var goTo = "<p><a class='text-info' style='cursor: pointer; color:green;text-decoration: underline' onClick=paymentApp.goShow(\""+rowObject.public_id+"\") >"+rowObject.public_id+"</a></p>";
                    return goTo;
            }
         
            
             $(window).bind('resize', function () {
               resizewidth();
            });
            $(window).on("resize", function() {
                resizewidth();
            });
                //resize on load
            function resizewidth()
            {
                var newWidth = $("#payment-grid").closest(".ui-jqgrid").parent().width();
                $("#payment-grid").jqGrid("setGridWidth", newWidth, true);
            }  

            	// activate the toolbar searching
			$('#payment-grid').jqGrid('navGrid',"#pager_list_2", {                
                search: false, // show search button on the toolbar
                add: false,
                edit: false,
                del: false,
                refresh: true
            });
			var timer;
			$("#search_cells").on("keyup", function() {
				var self = this;
				if(timer) { clearTimeout(timer); }
				timer = setTimeout(function(){
					$("#payment-grid").jqGrid('filterInput', self.value);
				},0);
			});

          

        });

         setTimeout(function(){
                $('.wrapper-content').removeClass('animated fadeInRight');
            },700);


    </script>

