import os
path = 'C:/Users/MZC-USER/Desktop/sample_data/etc'
def rename_files():
  i = 1

  
  for filename in os.listdir(path):
    dst = str(i) + '.jpg'
    src = path + '/'  + filename
    dst = path +'/'  +  dst
      
    os.rename(src, dst)
    i += 1

if __name__ == '__main__':
  rename_files()