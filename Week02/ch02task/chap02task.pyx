# -*- coding: utf-8 -*-


import numpy as np
cimport numpy as cnp
import pandas as pd


def target_mean(data, y_name, x_name):
    cdef:
        int data_shape = data.shape[0]
        cnp.ndarray[cnp.float32_t] result = np.zeros(data_shape, dtype=np.float32)
        dict value_dict = {}
        dict count_dict = {}
        cnp.ndarray[cnp.int_t] x_val_array = data[x_name].values
        cnp.ndarray[cnp.int_t] y_val_array = data[y_name].values

    for i in range(data_shape):
        data_loc_x = x_val_array[i]
        data_loc_y = y_val_array[i]
        if data_loc_x not in value_dict:
            value_dict[data_loc_x] = data_loc_y
            count_dict[data_loc_x] = 1
        else:
            value_dict[data_loc_x] += data_loc_y
            count_dict[data_loc_x] += 1

    for i in range(data_shape):
        count = count_dict[x_val_array[i]] - 1
        result[i] = (value_dict[x_val_array[i]] - y_val_array[i]) / count

    return result


def main():
    x = np.random.randint(10, size=(5000, 1))
    y = np.random.randint(2, size=(5000, 1))
    data = pd.DataFrame(np.concatenate([y, x], axis=1), columns=['y', 'x'])
    result = target_mean(data, 'y', 'x')
    print(result)


if __name__ == '__main__':
    main()