第一步，用cu.in先输出Cu原子（包含了纳米颗粒）的坐标备用。
第二步，将输出文件中dump_cu.xzy的前面几行删除，只保留原子坐标，然后导入matlab。
第三步，matlab选择工作目录（包含creat_spring_bond等文件），然后运行script_lammps_model.m脚本。就可以得到需要的结果。