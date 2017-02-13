
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jqgrid/ui.jqGrid.css')!!}  
     {!!Html::script('/themes/krece/js/plugins/jqgrid/jquery.jqGrid52.min.js')!!}  
     {!!Html::script('/themes/krece/js/plugins/jquery-layout/jquery.layout.js')!!}
      {!!Html::script('/themes/krece/js/plugins/jqgrid/i18n/grid.locale-es.js')!!}  
       {!!Html::script('/js/vue-library/vue.min.js')!!}
    {!!Html::style('/themes/krece/css/plugins/jqueryui/jquery-ui.css')!!}
    <script>
        moment.locale('es');  
    </script>
    

 <style>
          .green {color: green;}
        .red {color: red;}

    </style>

        <div id="invoice_index" class="jqGrid_wrapper">            
           <!-- activar buscador 
            <div class="ibox-content">
                <ul class="todo-list m-t small-list  col-sm-5 pull-right">
                    <li>
                        <div  class="input-group"><input id="search_cells" type="text" placeholder="Buscar" class="input-sm form-control"> <span class="input-group-btn">
                        <button type="button" class="btn btn-sm btn-primary"><span class="fa fa-search"></span></button> </span></div>
                    </li>
                </ul>                      
            </div>-->
           <div class="ibox-content">  
                <table id="invoice-grid"></table>
                <div id="pager_list_2"></div>     
            </div>        
        <div>

    <script>
        
        $(document).ready(function () {       
             var emptyMsgDiv = $("<div class='ibox-content ibox-heading'>" +
            "<h3><i class='fa fa-exclamation'></i> No tienes facturas de venta creadas!</h3>" +
            " <div class='ibox-content ibox-heading'><a href='{{route('invoice.create')}}' class='btn btn-primary btn-outline btn-sm '>" +
            "<span class='fa fa-plus '></span>&nbsp;Crear Factura de venta</a> </div></div> '");
         
            $("#invoice-grid").jqGrid({
                url: "getInvoiceList",
                editurl: 'invoice',
                datatype: "json",
                mtype: 'GET',
                emptyrecords:  "",
                colModel: [                   
                    { label: 'No', name: 'public_id', index: 'public_id', width: 30, sorttype: "int",formatter:formatpublicID },
                    { label: 'Cliente', name: 'contact.name',  width: 140, sorttype: "text" },
                    { label: 'Creación', name: 'created_at.date', width: 70, formatter:diffForHumans},
                     { label: 'Vence en', name: 'due_date', width: 50, formatter: 'date', formatoptions: {newformat: 'd/m/Y'}},
                     { label: 'Total', name: 'total', width: 70, formatter:'currency', formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ "} },
                     { label: 'Pagado', name: 'total', width: 70, formatter:'currency', formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ "} },
                     { label: 'Por Pagar', name: 'total', width: 70, formatter:'currency', formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ "} },
                     { label: 'Estado', name: 'status_id', width: 50,align:"center", formatter:state_mask },
                    
                     {name:'public_id', search:false, keys: true,"width":50, label:'Acciones', index:'public_id',  "align":"right" , sortable: false, formatter: displayButtons }                  
                ],
                viewrecords: true, // show the current page, data rang and total records on the toolbar
                width: 780,
                height: 'auto',
                rowNum: 10,
                rowList: [10, 20, 50, 100],
                caption:" ",
                loadonce:true,
                navOptions: { reloadGridOptions: { fromServer: true } },
                loadComplete: function () {
                    var count = $("#invoice-grid").getGridParam();
                    var ts = $("#invoice-grid")[0];
                    if (ts.p.reccount === 0) {
                        $("#invoice-grid").hide();
                        emptyMsgDiv.insertAfter($("#invoice-grid").parent());
                        emptyMsgDiv.show();
                    } else {
                        $("#invoice-grid").show();
                        emptyMsgDiv.hide();
                    };
                    resizewidth();
                },         
                pager:"#pager_list_2"
            });
            
      
          $("#export").on("click", function(){
				$("#invoice-grid").jqGrid("exportToExcel",{
					includeLabels : true,
					includeGroupHeader : true,
					includeFooter: true,
					fileName : "jqGridExport.xlsx",
					maxlength : 40 
				})
			})

             $("#refresh_all").on("click", function(){             
                 refreshgrid('a','invoiceos (todos)');
			})

            $("#refresh_client").on("click", function(){              
                refreshgrid('c','invoiceos (Clientes)');
			})

            $("#refresh_providers").on("click", function(){             
                 refreshgrid('p','invoiceos (Proveedores)');
			})

            function refreshgrid(filter, caption)
            {
                 $("#invoice-grid").setGridParam({url:"getinvoicelist/"+filter});
                $('#invoice-grid').jqGrid('setCaption', caption);
                 $('#invoice-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
            }

             jQuery('#invoice-grid').jqGrid('navGrid','#pager_list_2',
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
                console.log(cellvalue);
                if (cellvalue==1)
                {
                    return "<div><p><span class='label label-primary'>Activo</span></p>"
                }
                else{
                      return "<p><span class='label label-warning'>Anulado</span></p>"
                }
            }

             function displayButtons(cellvalue, options, rowObject) {
                var edit = "<div  title= 'editar'  class='fa fa-pencil green' style='cursor: pointer' onClick=invoiceApp.goEdit(\""+cellvalue+"\") ></div><span > </span>",
                    Details = "<div title= 'ver' class='fa fa-eye green' style='cursor: pointer'  onClick=invoiceApp.goShow(\""+cellvalue+"\")></div><span > </span>",
                    Print = "<div title= 'Imprimir' class='fa fa-print' style='cursor: pointer'  onClick=invoiceApp.printPdf(\""+cellvalue+"\")></div><span > </span>",
                    Delete = "<div title= 'eliminar' class='fa fa-remove red'  style='cursor: pointer' onclick=invoiceApp.remove(\""+cellvalue+"\")/></div><span > </span>";
                    Lock = "<div title= 'Anular' class='fa fa-unlock '  style='cursor: pointer; color:#DDB215' onclick=invoiceApp.updateItemStatus(\""+rowObject.id+"\",'2')/></div><span > </span>";
                    if (rowObject.status_id==2)
                    {                    
                        edit = "<div  title= 'Editar'  class='fa fa-pencil ' style='color:#ABEBC6'/></div><span > </span>";
                        Lock = "<div title= 'Activar' class='fa fa-lock '  style='cursor: pointer; color:gray' onclick=invoiceApp.updateItemStatus(\""+rowObject.id+"\",'1')/></div><span > </span>";
                        Delete = "<div title= 'Eliminar' class='fa fa-remove '  style='color:#F3D8D5'/></div><span > </span>";
                    }
                return Lock + Details + Print +  edit+ Delete;
            }   

            function formatpublicID(cellValue, options, rowObject) {
                    var goTo = "<p><a class='text-info' style='cursor: pointer; color:green;text-decoration: underline' onClick=invoiceApp.goShow(\""+cellValue+"\") >"+cellValue+"</a></p>";
                    return goTo;
            }
             function diffForHumans(cellValue, options, rowObject) {
                    return invoiceApp.moment(cellValue);
            }

             $(window).bind('resize', function () {
               resizewidth();
            });
                //resize on load
            function resizewidth()
            {
                var width = $('.jqGrid_wrapper').width();
                $('#invoice-grid').setGridWidth(width); 
            }  

            	// activate the toolbar searching
			$('#invoice-grid').jqGrid('navGrid',"#pager_list_2", {                
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
					$("#invoice-grid").jqGrid('filterInput', self.value);
				},0);
			});

        });


    </script>

