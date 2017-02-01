
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jqgrid/ui.jqGrid.css')!!}  
    <!--{!!Html::style('/themes/krece/css/plugins/jqueryui/jquery-ui-1.10.4.custom.min.css')!!}-->
     {!!Html::script('/themes/krece/js/plugins/jqgrid/jquery.jqGrid52.min.js')!!}  
     {!!Html::script('/themes/krece/js/plugins/jquery-layout/jquery.layout.js')!!}
      {!!Html::script('/themes/krece/js/plugins/jqgrid/i18n/grid.locale-es.js')!!}  
       {!!Html::script('/js/vue-library/vue.min.js')!!}
   
   {!!Html::script('https://cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js')!!}

    {!!Html::style('/themes/krece/css/plugins/jqueryui/jquery-ui.css')!!}

 <style>
          .green {color: green;}
        .red {color: red;}
        .white {color: white;}
    </style>

        <div id="contact2" class="jqGrid_wrapper">            
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
              
                        
                         <div class="ibox-content ibox-heading">
                            <button type="button" class="btn btn-outline btn-info btn-sm" data-toggle="tooltip" data-placement="right" title="En esta opción usted podrá filtrar los datos de cada una de las transacciones asociadas al contacto actual."> <span class="fa fa-exclamation"></span></button>

                            <div class="btn-group">
                                <button data-toggle="dropdown" class="btn btn-primary dropdown-toggle btn-sm">Seleccionar vista <span class="caret"></span></button>
                                <ul class="dropdown-menu">
                                    <li><a id="refresh_all">Transacciones</a></li>
                                    <li><a >Facturas de venta</a></li>
                                    <li><a >Facturas de compra</a></li>
                                    <li><a >Notas crédito</a></li>
                                    <li><a >Notas débito</a></li>
                                    <li><a >Cotizaciones</a></li>
                                    <li><a >Remisiones</a></li>
                                    <li><a >Órdenes de compra</a></li>
                                    <li><a >Ajustes categorías</a></li>
                                </ul>
                            </div>
                           
                    </div>
                  
                <table id="transaction-grid"></table>
                <div id="pager_list_2"></div>     
                 
    <div>

    <script>
        
        $(document).ready(function () {       
            var emptyMsgDiv = $("<div class='ibox-content ibox-heading'>" +
            "<h3><i class='fa fa-exclamation'></i> Aún no tienes ninguna transacción creada!</h3>" +
            " <div class='ibox-content ibox-heading'><a href='{{route('contact.index')}}' class='btn btn-primary btn-outline btn-sm '>" +
                                                "<span class='fa fa-plus '></span>&nbsp;Nueva transacción</a> </div></div> '");
          
          

            $("#transaction-grid").jqGrid({
                //url: "getContactlist/all",
                editurl: 'contact',
                datatype: "json",
                mtype: 'GET',
                emptyrecords:  "",
                colModel: [                   
                    { label: 'Fecha', name: 'name', index: 'name', width: 75, sorttype: "text" },
                    { label: 'Estado', name: 'nit', width: 90 },
                    { label: 'Detalle', name: 'phone1', width: 200 },
                    { label: 'Salidas', name: 'observation', width: 90 },
                    { label: 'Entradas', name: 'observation', width: 90 }
                    // {name:'public_id',  keys: true,"width":50, label:'Acciones', index:'public_id',  "align":"right" , sortable: false, formatter: displayButtons }                  
                ],
                viewrecords: true, // show the current page, data rang and total records on the toolbar
                width: 780,
                height: 300,
                rowNum: 20,
                rowList: [20, 50, 100],
                caption:"Transacciones",
                loadonce:true,
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
                    resizewidth();
                },         
                pager:"#pager_list_2"
            });
            emptyMsgDiv.insertAfter($("#transaction-grid").parent());
          $("#export").on("click", function(){
				$("#transaction-grid").jqGrid("exportToExcel",{
					includeLabels : true,
					includeGroupHeader : true,
					includeFooter: true,
					fileName : "jqGridExport.xlsx",
					maxlength : 40 
				})
			})

             $("#refresh_all").on("click", function(){             
                 refreshgrid('a','Contactos (todos)');
			})

            $("#refresh_client").on("click", function(){              
                refreshgrid('c','Contactos (Clientes)');
			})

            $("#refresh_providers").on("click", function(){             
                 refreshgrid('p','Contactos (Proveedores)');
			})

            function refreshgrid(filter, caption)
            {
                 $("#transaction-grid").setGridParam({url:"getContactlist/"+filter});
                $('#transaction-grid').jqGrid('setCaption', caption);
                 $('#transaction-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
            }

             jQuery('#transaction-grid').jqGrid('navGrid','#pager_list_2',
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

             function displayButtons(cellvalue, options, rowObject) {
                var edit = "<div  title= 'editar'  class='fa fa-eye green' style='cursor: pointer' onClick=app.goShow(\""+cellvalue+"\") ></div><span > </span>",
                    Details = "<div title= 'ver' class='fa fa-pencil green' style='cursor: pointer'  onClick=app.goEdit(\""+cellvalue+"\")></div><span > </span>",
                    Delete = "<div title= 'eliminar' class='fa fa-remove red'  style='cursor: pointer' onclick=app.remove(\""+cellvalue+"\")/></div><span > </span>";
                
                return edit + Details + Delete;
            }   

             $(window).bind('resize', function () {
               resizewidth();
            });
                //resize on load
            function resizewidth()
            {
                var width = $('.jqGrid_wrapper').width();
                $('#transaction-grid').setGridWidth(width); 
            }  

            	// activate the toolbar searching
			$('#transaction-grid').jqGrid('navGrid',"#pager_list_2", {                
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
					$("#transaction-grid").jqGrid('filterInput', self.value);
				},0);
			});

        });


    </script>

