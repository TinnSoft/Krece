

      
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jqgrid/ui.jqGrid.css')!!}  
    {!!Html::script('/themes/krece/js/plugins/jqgrid/jquery.jqGrid52.min.js')!!}  
    {!!Html::script('/themes/krece/js/plugins/jquery-layout/jquery.layout.js')!!}
    {!!Html::script('/themes/krece/js/plugins/jqgrid/i18n/grid.locale-es.js')!!}  

    {!!Html::style('/themes/krece/css/plugins/jqueryui/jquery-ui.css')!!}

 <style>
    .green {color: green;}
    .red {color: red;}
</style>

        <div class="jqGrid_wrapper"> 
           <div class="ibox-content">     
                <table id="category-grid"></table>    
            </div>  
    <div>

    
    <script>

       jQuery(document).ready(function($) {  
            jQuery('#category-grid').jqGrid({
                url: "/getCategoryIncome",
                datatype: "json",                 
                colModel:[                   
                    {name:'name', label:'Nombre', "width":70,index:'name'},
                    {name:'description', label:'Descripción',"width":170, index:'description'},
                    {name:'niif_account', label:'# Cuenta',"width":60, index:'niif_account'},
                    {name:'id',key:true,"width":30, label:'Acciones', index:'id',  "align":"right", formatter: displayButtons},
                    {name:"parent_id",hidden:true},
                    {"name":"lft","hidden":true},
                    {"name":"rgt","hidden":true},
                    {"name":"depth","hidden":true}
				],
				"width":"780",
				"viewrecords":false,
				"gridview":true,
				"height":"auto",
				"sortname":"lft",
				"loadonce":true,
				"rowNum":100,
				"scrollrows":true,
				"treeGrid":true,
                caption:"seleccione la categoría que aplica",
				"ExpandColumn":"name",
				"treedatatype":"json",
				"treeGridModel":"nested",
                "ExpandColClick" : true,
			    "treeReader":{
					"left_field":"lft",
					"right_field":"rgt",
					"level_field":"depth"
				},
				"sortorder":"asc",
                loadComplete: function () {                  
                    resizewidth();
                    // $('#category-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
                }
               
            
            });
            
             function displayButtons(cellvalue, options, rowObject) {
                var edit = "<div  title= 'editar'  class='fa fa-eye green' style='cursor: pointer' onClick=app.goShow(\""+cellvalue+"\") ></div><span > </span>",
                    Details = "<div title= 'ver' class='fa fa-pencil green' style='cursor: pointer'  onClick=app.goEdit(\""+cellvalue+"\")></div><span > </span>",
                    Delete = "<div title= 'eliminar' class='fa fa-remove red'  style='cursor: pointer' onclick=app.remove(\""+cellvalue+"\")/></div><span > </span>";
            
                
                return edit + Details + Delete;
            }   

             $(window).bind('resize', function () {
               resizewidth();
            });

            function resizewidth()
            {
                var width = $('.jqGrid_wrapper').width();
                $('#category-grid').setGridWidth(width); 
            }  

        });


    </script>
