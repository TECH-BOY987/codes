def process(data):
    if isinstance(data,list):
        print("processing list")
        for item in data:
            print(item)
    elif isinstance(data,tuple):
         print("processing tuple")
         for item in data:
            print(item)
    elif isinstance(data,dict):
        print("processing dict")
        for key,value in data.items():
            print(f"key:{key},value:{value}")
    elif isinstance(data,set):
        print("processing set")
        for item in data:
            print(item)
    else:
        print("error")                
my_list=[1,2,3]
my_tuple=(1,2,3,4)
my_dict={'name':'neeraj','age':'22'}
my_set={2,1,3,2,4,5,2,1,9,4}
process(my_list)
process(my_tuple)
process(my_dict)
process(my_set) 
processing list
1
2
3
processing tuple
1
2
3
4
processing dict
key:name,value:neeraj
key:age,value:22
processing set
1
2
3
4
5
9
