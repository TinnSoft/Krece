
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jqGrid/ui.jqGrid.css')!!}  
     {!!Html::script('/themes/krece/js/plugins/jqgrid/jquery.jqGrid52.min.js')!!}  
     {!!Html::script('/themes/krece/js/plugins/jquery-layout/jquery.layout.js')!!}
      {!!Html::script('/themes/krece/js/plugins/jqgrid/i18n/grid.locale-es.js')!!}  
       {!!Html::script('/js/vue-library/vue.min.js')!!}
    {!!Html::style('/themes/krece/css/plugins/jQueryUi/jquery-ui.css')!!}
    <script>
        moment.locale('es');  
    </script>
    

 <style>
          .green {color: green;}
        .red {color: red;}

    </style>

        <div id="remision_index" class="jqGrid_wrapper">            
                <div class="table-responsive">
                <table id="remision-grid"></table>
                </div>
                <div id="pager_list_2"></div>     
                 
        <div>

    <script>
        
        $(document).ready(function () {       
             var emptyMsgDiv = $("<div class='ibox-content ibox-heading'>" +
            "<h3><i class='fa fa-exclamation'></i> No tienes remisiones creadas!</h3>" +
            " <div class='ibox-content ibox-heading'><a href='{{route('remision.create')}}' class='btn btn-primary btn-outline btn-sm '>" +
            "<span class='fa fa-plus '></span>&nbsp;Crear Remision</a> </div></div> '");
         
            $("#remision-grid").jqGrid({
                url: "getRemisionList",
                editurl: 'remision',
                datatype: "json",
                mtype: 'GET',
                emptyrecords:  "",
                colModel: [                   
                    { label: 'No', name: 'public_id', index: 'public_id', align:"center",width: 25, sorttype: "int",formatter:formatpublicID },
                    { label: 'Cliente', name: 'contact.name',  width: 140, sorttype: "text" },
                    { label: 'Creación', name: 'created_at.date', width: 70, formatter:diffForHumans},
                     { label: 'Vence en', name: 'due_date', width: 50, formatter: 'date', formatoptions: {newformat: 'd/m/Y'}},
                     { label: 'Estado', name: 'status_id', width: 50,align:"center", formatter:state_mask },
                    { label: 'Total', name: 'total', width: 70, formatter:'currency', formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ "} },
                     {name:'public_id', search:false, keys: true,"width":90, label:'Acciones', index:'public_id',  "align":"right" , sortable: false, formatter: displayButtons }                  
                ],
                viewrecords: true, // show the current page, data rang and total records on the toolbar
                autoresizeOnLoad: true,
                autowidth: true,
                shrinkToFit: true,
                autoResizing: {
                    compact: true
                    },
                 cmTemplate: {
                    autoResizable: true,
                    editable: true
                    },      
                width: 780,
                height: 'auto',
                rowNum: 10,
                rowList: [10, 20, 50, 100],
                caption:" ",
                loadonce:true,
                navOptions: { reloadGridOptions: { fromServer: true } },
                loadComplete: function () {
                    var count = $("#remision-grid").getGridParam();
                    var ts = $("#remision-grid")[0];
                    if (ts.p.reccount === 0) {
                        $("#remision-grid").hide();
                        emptyMsgDiv.insertAfter($("#remision-grid").parent());
                        emptyMsgDiv.show();
                    } else {
                        $("#remision-grid").show();
                        emptyMsgDiv.hide();
                    };
                    //resizewidth();
                },     
                 beforeRequest:function()
                {
                    resizewidth();
                },    
                pager:"#pager_list_2"
            });
            
      
          $("#export").on("click", function(){
				$("#remision-grid").jqGrid("exportToExcel",{
					includeLabels : true,
					includeGroupHeader : true,
					includeFooter: true,
					fileName : "jqGridExport.xlsx",
					maxlength : 40 
				})
			})

          

             jQuery('#remision-grid').jqGrid('navGrid','#pager_list_2',
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
                    return "<p><span class='label label-primary'>Abierta</span></p>"
                }
                else if (cellvalue==2){
                      return "<p><span class='label label-warning'>Anulado</span></p>"
                }
                else if (cellvalue==6){
                      return "<p><span class='label label-info'>Cerrado</span></p>"
                }
            }

             function displayButtons(cellvalue, options, rowObject) {
                var edit = "<div  title= 'editar'  class='fa fa-pencil green fa-2x' style='cursor: pointer' onClick=remisionApp.goEdit(\""+cellvalue+"\") ></div><span > </span>",
                    Details = "<div title= 'ver' class='fa fa-eye green fa-2x' style='cursor: pointer'  onClick=remisionApp.goShow(\""+cellvalue+"\")></div><span > </span>",
                    Print = "<div title= 'Imprimir' class='fa fa-print fa-2x' style='cursor: pointer'  onClick=remisionApp.printPdf(\""+cellvalue+"\")></div><span > </span>",
                    Delete = "<div title= 'eliminar' class='fa fa-remove red fa-2x'  style='cursor: pointer' onclick=remisionApp.remove(\""+cellvalue+"\")/></div><span > </span>";
                    Lock = "<div title= 'Anular' class='fa fa-unlock fa-2x '  style='cursor: pointer; color:#DDB215' onclick=remisionApp.updateItemStatus(\""+rowObject.id+"\",'2')/></div><span > </span>";
                    if (rowObject.status_id==2)
                    {                    
                        edit = "<div  title= 'Editar'  class='fa fa-pencil fa-2x ' style='color:#ABEBC6'/></div><span > </span>";
                        Lock = "<div title= 'Activar' class='fa fa-lock fa-2x '  style='cursor: pointer; color:gray' onclick=remisionApp.updateItemStatus(\""+rowObject.id+"\",'1')/></div><span > </span>";
                        Delete = "<div title= 'Eliminar' class='fa fa-remove fa-2x '  style='color:#F3D8D5'/></div><span > </span>";
                    }
                return Lock + Details + Print +  edit+ Delete;
            }   

            function formatpublicID(cellValue, options, rowObject) {
                    var goTo = "<p><a class='text-info' style='cursor: pointer; color:green;text-decoration: underline' onClick=remisionApp.goShow(\""+cellValue+"\") >"+cellValue+"</a></p>";
                    return goTo;
            }
             function diffForHumans(cellValue, options, rowObject) {
                    return remisionApp.moment(cellValue);
            }
              $(window).on("resize", function() {
                resizewidth();
            });
             $(window).bind('resize', function () {
               resizewidth();
            });
                //resize on load
            function resizewidth()
            {
                 var newWidth = $("#invoice-grid").closest(".ui-jqgrid").parent().width();
                $("#invoice-grid").jqGrid("setGridWidth", newWidth, true);
            }  

            	// activate the toolbar searching
			$('#remision-grid').jqGrid('navGrid',"#pager_list_2", {                
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
					$("#remision-grid").jqGrid('filterInput', self.value);
				},0);
			});

        });


    </script>

