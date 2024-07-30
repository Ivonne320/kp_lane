'''iterate through a prediction json folder and find the corresponding video segment name in the gt path and remove them into the corresponding parent folder
'''
import os
import json
import glob

def main():
    pred_path = "/work/vita/yiwang/predictions/culane/new_exp/M-00003-scale/lrtest-50e/e-6/"
    gt_path = "/work/vita/datasets/CULane/test/driver_37_30frame/"
    segment_names = os.listdir(gt_path)
    # print(segment_names)
    seg_map = {}
    for seg in segment_names:
        seg_map[seg] = []
        #get seg path
        seg_path = os.path.join(gt_path, seg)
        #get all the image names
        img_names = os.listdir(seg_path) 
        for img_name in img_names:
            #get the image name without extension
            img_name = img_name.split('.')[0]
            saved_img_name = seg + '_' + img_name
            seg_map[seg].append(saved_img_name)
    # print(seg_map)
    #iterate through the prediction json folder
    json_files = sorted(glob.glob(os.path.join(pred_path, '*.json')))
    # print(len(json_files))
    for json_file in json_files:
        #get json basename
        # json_basename = os.path.basename(json_file).split('.')[0]
        json_seg_name = os.path.basename(json_file).split('.')[0]+'MP4'
        json_img_name = os.path.basename(json_file).split('.')[0]+'.'+os.path.basename(json_file).split('.')[1]
        
        #get corresponding segment name
        for seg_name in segment_names:
            image_names = seg_map[seg_name]  
            if json_img_name in image_names:
                #make a corresponding segment folder in pred_path and move the json file into it
                seg_pred_path = os.path.join(pred_path, seg_name)
                os.makedirs(seg_pred_path, exist_ok=True)
                #move the json file into the above folder
                os.rename(json_file, os.path.join(seg_pred_path, os.path.basename(json_file)))
                
                break
                
def renamer():
    pred_path = "/work/vita/yiwang/predictions/culane/new_exp/M-00003-scale/lrtest-50e/e-6"
    segment_names = os.listdir(pred_path)
    for seg in segment_names:
        seg_path = os.path.join(pred_path, seg)
        json_files = sorted(glob.glob(os.path.join(seg_path, '*.json')))
        for json_file in json_files:
            # json_basename = os.path.basename(json_file).split('.')[0]
            img_name = os.path.basename(json_file).split('_')[2]
            save_img_name= img_name.split('.')[0] 
            
            os.rename(json_file, os.path.join(seg_path, save_img_name+'.json'))
    
    
            
if __name__ == "__main__":
    main()
    renamer()


