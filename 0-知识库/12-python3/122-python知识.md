# [Pthon强制删除非空文件夹](https://www.cnblogs.com/shiqi17/p/12163096.html)

## 1 删除空文件夹

- os：模块
```python
os.remove(path)  #既能删除文件，又能删除文件夹
os.removedir()    #removedir只能删除文件夹
os.system("rm -rf pathname")   # Linux下调用bash命令
```
## 2 删除非空文件夹

- shutil:模块
```python
  shutil.rmtree(path, ignore_errors=True)
```



# [Python操作Excel 之 openpyxl](https://www.cnblogs.com/shiqi17/p/10739223.html)

一、基础

1. 安装openpyxl 模块`pip install openpyxl `

- ==font(字体类)：字号、字体颜色、下划线等==
- ==fill(填充类)：颜色等==
- ==border(边框类)：设置单元格边框==
- ==alignment(位置类)：对齐方式==
- ==number_format(格式类)：数据格式==
- ==protection(保护类)：写保护==

1.1

```python
from openpyxl import Workbook
import uuid,string,json,time,os,base64
from openpyxl.workbook import Workbook
from openpyxl.styles import Font, Alignment, Side, Border
from Lib.Utils import Utils
#============================= 创建excel文件
wb = Workbook()   #创建文件对象

wb.remove(wb["sheet"])
wb.remove(self.wb["sheet"])  #移除掉第一个sheet

ws = wb.create_sheet("蒸汽压力记录表", 0)
ws1 = wb.create_sheet("Mysheet")           #创建一个sheet
#============================= 操作单元格
ws1["A1"]=123.11
ws1["B2"]="你好"
d=ws1.cell(row=4, column=2, value=10)
print ws1["A1"].value
print ws1["B2"].value
print d.value



#=============================对多个单元格
class ExportReport:
    def __init__(self, start_time, water_temp, test_people,
                 sample_name, pressure_value, pressure_list,*args, **kwargs):
        """
        :param start_time: 实验开始时间
        :param water_temp: 水浴温度
        :param test_people: 试验人
        :param sample_name: 样品名称
        :param pressure_value: 最终压力
        :param args: 实验过程压力记录列表
        :param kwargs:
        """
        self.start_time = start_time
        self.water_temp = str(water_temp)+' ℃'
        self.test_people = test_people
        self.sample_name = sample_name
        self.pressure_value = pressure_value
        self.all_col = 5+len(pressure_list) #一共多少列
        self.pressure_record = pressure_list #第六列到最后一列的数据列表

        #所有的数据列
        self.data_list = [self.start_time, self.water_temp,self.test_people,self.sample_name,
            self.pressure_value]
        self.data_list.extend(self.pressure_record)
        self.col_list = ["开始时间", "水浴温度", "测试人", "样品名称", "最终压力值"]

        # base64转化为图片
        # self.bs64 = bs64
        # self.img_path = Utils.change_base64_as_img(self.bs64)

        self.wb = Workbook()
        #self.wb.remove(self.wb["sheet"])

        self.ws = self.wb.create_sheet("{0}蒸汽压力记录表".format(self.sample_name), 0)
        #生成所含列总数的大写字母
        self.upper_string_list = string.ascii_uppercase[:self.all_col]
        # 水平对齐，居中对齐
        self.alignment_style = Alignment(horizontal='center', vertical='center')
        #定义border 边框样式
        left, right, top, bottom = [Side(style='thin', color='000000')]*4
        self.border_style = Border(left=left, right=right, top=top, bottom=bottom)
        #定义字体
        self.font_size = Font(size=9)
        for col in self.upper_string_list:
            self.ws.column_dimensions[col].width = 20

    #创建表头第一行
    def create_row1(self):
        #把所有列合并
        self.ws.merge_cells(start_row=1, end_row=1, start_column=1, end_column=self.all_col)
        #写入值
        # self.ws.cell(row=1, column=1).value = value
        self.ws.cell(row=1, column=1).value = "{0}蒸汽压力记录表".format(self.sample_name)
        self.ws['A1'].alignment = self.alignment_style
        self.ws['A1'].font = Font(size=16, bold=True)
        self.create_row2_3()
        
    def create_row2_3(self):
        #把前五列，二三行单元格合并，并写入值
        for col in range(1, len(self.col_list)+1):
            self.ws.merge_cells(start_row=2, end_row=3, start_column=col, end_column=col)
            col_str = self.upper_string_list[col-1]+"2"
            self.ws[col_str] = self.col_list[col-1]
            self.ws[col_str].alignment = self.alignment_style
            self.ws[col_str].font = Font(size=12, bold=True)

        #把第二行第六列开始到最后列合并
        self.ws.merge_cells(start_row=2, end_row=2, start_column=len(self.col_list)+1, end_column=self.all_col)
        col_str = self.upper_string_list[len(self.col_list)]+"2"
        self.ws[col_str] = "实验过程压力记录"
        self.ws[col_str].alignment = self.alignment_style
        self.ws[col_str].font = Font(size=12, bold=True)

        #第三行第六列开始到最后列写入值
        for index, col_ltr in enumerate(self.upper_string_list[5:]):
            col_str = col_ltr+'3'
            self.ws[col_str] = "第{0}次压力记录".format(index+1)
            self.ws[col_str].alignment = self.alignment_style
            self.ws[col_str].font = Font(size=12, bold=True)

    def add_data(self):
        #第四行开始写入数据,所有数据居中对齐，水平居中
        for index, col in enumerate(self.upper_string_list):
            col_str = col+"4"
            self.ws[col_str] = self.data_list[index]
            self.ws[col_str].alignment = self.alignment_style
            self.ws[col_str].font = Font(size=12, bold=True)

    def create(self,value=None):
        if value:
            self.ws.cell(row=1, column=1).value = value
        self.create_row1()
        self.add_data()

    def save(self, filename):
        try:
            self.wb.save(filename)
        except:
            self.wb.save(filename[:-5] + str('_' + Utils.getFileName()) + filename[-5:])

        # 关闭excel
        self.close()

    def close(self):
        self.wb.close()

if __name__ == '__main__':
    er = ExportReport(1, 2, 3, 4, 5, ['x', 's', 's', 'b','w'])
    er.create()
    er.wb.save('17表.xlsx')


```

