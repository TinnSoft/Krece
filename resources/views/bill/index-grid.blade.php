
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jqGrid/ui.jqgrid.css')!!}  
     {!!Html::script('/themes/krece/js/plugins/jqgrid/jquery.jqGrid52.min.js')!!}  
     {!!Html::script('/themes/krece/js/plugins/jquery-layout/jquery.layout.js')!!}
      {!!Html::script('/themes/krece/js/plugins/jqgrid/i18n/grid.locale-es.js')!!}  
    {!!Html::style('/themes/krece/css/plugins/jQueryUI/jquery-ui.css')!!}
    <script>
        moment.locale('es');  
    </script>
    



        <div id="bill_index" class="jqGrid_wrapper">            
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
                <table id="bill-grid"></table>
                <div id="pager_list_2"></div>     
            </div>        
        <div>

    <script>
        
        $(document).ready(function () {       
             var emptyMsgDiv = $("<div class='ibox-content ibox-heading'>" +
            "<h3><i class='fa fa-exclamation'></i> No tienes facturas de proveedores creadas!</h3>" +
            " <div class='ibox-content ibox-heading'><a href='{{route('bill.create')}}' class='btn btn-primary btn-outline btn-sm '>" +
            "<span class='fa fa-plus '></span>&nbsp;Crear Factura de proveedores</a> </div></div> '");
         
            $("#bill-grid").jqGrid({
                url: "getBillList",
                editurl: 'bill',
                datatype: "json",
                mtype: 'GET',
                emptyrecords:  "",
                colModel: [                   
                    { label: 'No', name: 'resolution_id',align:"center", sortable:"false", width: 30, sorttype: "text",formatter:formatpublicID },
                    { label: 'Proveedor', name: 'contact_name',  width: 120, sorttype: "text" },
                    { label: 'Creación', name: 'created_at', width: 70, formatter:diffForHumans},
                     { label: 'Vence en', name: 'due_date', width: 50, formatter: 'date', formatoptions: {newformat: 'd/m/Y'}},
                     { label: 'Total', name: 'total', width: 70, formatter:'currency', formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ "} },
                     { label: 'Pagado', name: 'total_payed', width: 70, formatter:'currency', formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ "} },
                     { label: 'Por Pagar', name: 'pending_to_pay', width: 70, formatter:'currency', formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ "} },
                     { label: 'Estado', name: 'status_id', width: 50,align:"center", formatter:state_mask },
                      { name: 'contact_id', hidden:true },
                    
                     {name:'public_id', search:false, keys: true,"width":150, label:'Acciones', index:'public_id',  "align":"right" , sortable: false, formatter: displayButtons }                  
                ],
                viewrecords: true, // show the current page, data rang and total records on the toolbar
                autowidth: true,
                shrinkToFit: true,
                height: 350,
                rowNum: 10,
                rowList: [10, 20, 50, 100],
                caption:" ",
                loadonce:true,
                loadComplete: function () {
                    var count = $("#bill-grid").getGridParam();
                    var ts = $("#bill-grid")[0];
                    if (ts.p.reccount === 0) {
                        $("#bill-grid").hide();
                        emptyMsgDiv.insertAfter($("#bill-grid").parent());
                        emptyMsgDiv.show();
                    } else {
                        $("#bill-grid").show();
                        emptyMsgDiv.hide();
                    };  
                                     
                }, 
                 beforeRequest:function()
                {
                    resizewidth();
                },           
                pager:"#pager_list_2"
            });
            
      
          $("#export").on("click", function(){
				$("#bill-grid").jqGrid("exportToExcel",{
					includeLabels : true,
					includeGroupHeader : true,
					includeFooter: true,
					fileName : "jqGridExport.xlsx",
					maxlength : 40 
				})
			})

         

             jQuery('#bill-grid').jqGrid('navGrid','#pager_list_2',
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
                else if(cellvalue==2){
                      return "<p><span class='label label-warning'>Anulada</span></p>"
                }
                else if(cellvalue==6){
                      return "<p><span class='label label-default'>Cerrada</span></p>"
                }
            }

             function displayButtons(cellvalue, options, rowObject) {
        
                var edit = "<div  title= 'editar'  class='fa fa-pencil fa-2x ' style='cursor: pointer;color:#1ABC9C' onClick=billApp.goEdit(\""+cellvalue+"\") ></div><span > </span>",
                    Details = "<div title= 'ver' class='fa fa-eye fa-2x ' style='cursor: pointer;color:#1ABC9C'  onClick=billApp.goShow(\""+cellvalue+"\")></div><span > </span>",
                    Print = "<div title= 'Imprimir' class='fa fa-print fa-2x' style='cursor: pointer;color:#1ABC9C'  onClick=billApp.printPdf(\""+cellvalue+"\")></div><span > </span>",
                    Delete = "<div title= 'eliminar' class='fa fa-remove fa-2x red'  style='cursor: pointer' onclick=billApp.remove(\""+cellvalue+"\")/></div><span > </span>";
                    Lock = "<div title= 'Anular' class='fa fa-unlock fa-2x '  style='cursor: pointer; color:#1ABC9C' onclick=billApp.updateItemStatus(\""+rowObject.id+"\",'2')/></div><span > </span>";
                    Payment = "<div title= 'Adicionar pago' class='fa fa-money fa-2x '  style='cursor: pointer; color:#1ABC9C' onclick=billApp.AddPayment(\""+rowObject.contact_public_id+"\")/></div><span > </span>";
                    if (rowObject.status_id==2)
                    {                    
                        edit = "<div  title= 'Editar'  class='fa fa-pencil fa-2x' style='color:#ABEBC6'/></div><span > </span>";
                        Lock = "<div title= 'Activar' class='fa fa-lock fa-2x'  style='cursor: pointer; color:gray' onclick=billApp.updateItemStatus(\""+rowObject.id+"\",'1')/></div><span > </span>";
                        Delete = "<div title= 'Eliminar' class='fa fa-remove fa-2x'  style='color:#F3D8D5'/></div><span > </span>";
                        Print = "<div title= 'Imprimir' class='fa fa-print fa-2x' style='color:#ABEBC6' /></div><span > </span>";
                        Payment = "<div title= 'Adicionar pago' class='fa fa-money fa-2x '  style='cursor: pointer; color:#ABEBC6'/></div><span > </span>";
                    }
                return Lock + Details + Print + Payment+  edit+ Delete;
            }   

            function formatpublicID(cellValue, options, rowObject) {
                    var goTo = "<div><a class='text-info' style='cursor: pointer; color:green;text-decoration: underline' onClick=billApp.goShow(\""+rowObject.public_id+"\") >"+rowObject.resolution_id+"</a></div>";
                    return goTo;
            }
             function diffForHumans(cellValue, options, rowObject) {
                    return billApp.moment(cellValue);
            }

            $(window).bind('resize', function () {
               resizewidth();
            });
                //resize on load
            function resizewidth()
            {
                var width = $('.jqGrid_wrapper').width();
                $('#bill-grid').setGridWidth(width); 
            }  
         

            	// activate the toolbar searching
			$('#bill-grid').jqGrid('navGrid',"#pager_list_2", {                
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
					$("#bill-grid").jqGrid('filterInput', self.value);
				},0);
			});

        });


    </script>

