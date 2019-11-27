"""
Reading a load of JSON files and writing a new one with only a few components
of the whole.
"""
import os
import json
FILESURL = '/Users/claudiauribe/Desktop/StatSpac/data/'
ALL_STORES = []
MY_STORES = []

def main():
    os.chdir(FILESURL) # Go to file dir

    for file in os.listdir(): # Iterating on the files
        if os.path.exists(file):
            with open(file, 'r') as f:
               try:
                   JSONfile = json.load(f) # JSONread
                   local_stores = JSONfile['stores'] # Get stores child
                   for store in local_stores: # Iterating on the stores
                       a = json.dumps({
                        "name": store['name'],
                        "type": store['type'],
                        "location": store['location']})
                       MY_STORES.append(a)
                       ALL_STORES.append(store)
               except :
                   print('\n\n\n~\n\n~\n\n\n\n')
    print(MY_STORES[298:307])

    # with open('Migros_Stores.json', 'w') as jj:
    #     try:
    #         json.dump(ALL_STORES, jj)
    #
    #     except:
    #         print('oh shit son')

    with open('MyMStores.json', 'w') as jj:
        try:
            json.dump(MY_STORES, jj, indent = 0 )

        except:
            print('oh shit son')

if __name__ == '__main__':
    main()
