
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

        <div id="creditnote_index" class="jqGrid_wrapper">      
                <table id="creditnote-grid"></table>
                <div id="pager_list_2"></div>   
        <div>

    <script>
        
        $(document).ready(function () {       
             var emptyMsgDiv = $("<div class='ibox-content ibox-heading'>" +
            "<h3><i class='fa fa-exclamation'></i> No tienes Notas crédito creadas!</h3>" +
            " <div class='ibox-content ibox-heading'><a href='{{route('credit-note.create')}}' class='btn btn-primary btn-outline btn-sm '>" +
            "<span class='fa fa-plus '></span>&nbsp;Crear Nota Crédito</a> </div></div> '");
         
            $("#creditnote-grid").jqGrid({
                url: "getCreditNoteList",
                datatype: "json",
                mtype: 'GET',
                emptyrecords:  "",
                colModel: [                   
                    { label: 'No', align:"center",name: 'public_id', index: 'public_id',  sorttype: "int",formatter:formatpublicID },
                    { label: 'Cliente', name: 'contact.name',   sorttype: "text" },
                    { label: 'Creación', name: 'created_at.date', formatter:diffForHumans},
                    { label: 'Total', name: 'total',  formatter:'currency', formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ "} },
                    { label: 'Por aplicar', name: 'amount_pending_to_apply',  formatter:'currency', formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ "} },
                     {name:'public_id', search:false, keys: true, label:'Acciones', index:'public_id',  "align":"right" , sortable: false, formatter: displayButtons }                  
                ],
                 cmTemplate: {
                    autoResizable: true,
                    editable: true
                    },
                     autoResizing: {
                    compact: true
                    },   
                viewrecords: true, // show the current page, data rang and total records on the toolbar
                width: 780,
                height: 'auto',
                rowNum: 10,
                rowList: [10, 20, 50, 100],
                caption:" ",
                loadonce:true,
                navOptions: { reloadGridOptions: { fromServer: true } },
                loadComplete: function () {
                    var count = $("#creditnote-grid").getGridParam();
                    var ts = $("#creditnote-grid")[0];
                    if (ts.p.reccount === 0) {
                        $("#creditnote-grid").hide();
                        emptyMsgDiv.insertAfter($("#creditnote-grid").parent());
                        emptyMsgDiv.show();
                    } else {
                        $("#creditnote-grid").show();
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
    

             jQuery('#creditnote-grid').jqGrid('navGrid','#pager_list_2',
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
                var edit = "<div  title= 'editar'  class='fa fa-eye green fa-2x' style='cursor: pointer' onClick=creditnoteApp.goShow(\""+cellvalue+"\") ></div><span > </span>",
                    Details = "<div title= 'ver' class='fa fa-pencil green fa-2x' style='cursor: pointer'  onClick=creditnoteApp.goEdit(\""+cellvalue+"\")></div><span > </span>",
                    Print = "<div title= 'Imprimir' class='fa fa-print fa-2x' style='cursor: pointer'  onClick=creditnoteApp.printPdf(\""+cellvalue+"\")></div><span > </span>",
                    Delete = "<div title= 'eliminar' class='fa fa-remove red fa-2x'  style='cursor: pointer' onclick=creditnoteApp.remove(\""+cellvalue+"\")/></div><span > </span>";
                
                return Details + Print + edit+ Delete;
            }   

            function formatpublicID(cellValue, options, rowObject) {
                    var goTo = "<p><a class='text-info' style='cursor: pointer; color:green;text-decoration: underline' onClick=creditnoteApp.goShow(\""+cellValue+"\") >"+cellValue+"</a></p>";
                    return goTo;
            }
             function diffForHumans(cellValue, options, rowObject) {
                    return creditnoteApp.moment(cellValue);
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
                var width = $('.jqGrid_wrapper').width();
                $('#creditnote-grid').setGridWidth(width); 
            }  

            	// activate the toolbar searching
			$('#creditnote-grid').jqGrid('navGrid',"#pager_list_2", {                
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
					$("#creditnote-grid").jqGrid('filterInput', self.value);
				},0);
			});

        });


    </script>

